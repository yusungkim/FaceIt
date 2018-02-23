//
//  FaceViewController.swift
//  FaceIt
//
//  Created by KimYusung on 9/6/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController
{
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            // target : who is going to handle
            // action : what method to do, #selcetor: is actual function, not abstract type.
            let pinchRecognizer = UIPinchGestureRecognizer(
                target: faceView,
                action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
//            let tapRecognizer = UITapGestureRecognizer(
//                target: self,
//                action: #selector(self.toggleEyes(byReactingTo:)))
//            tapRecognizer.numberOfTapsRequired = 1
//            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(
                target: self,
                action: #selector(self.decreaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(
                target: self,
                action: #selector(increaseHappiness(byReactingTo:)))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }
    
    @objc func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    @IBAction func shakeHead(_ sender: UITapGestureRecognizer) {
        shakeHead()
    }
    
    private struct HeadShake {
        static let angle = CGFloat.pi/6
        static let segmentDuration: TimeInterval = 0.5 // each head shake has 3 segments
    }
    
    private func rotateFace(by angle: CGFloat) {
        faceView.transform = faceView.transform.rotated(by: angle)
    }
    
    private func shakeHead() {
        UIView.animate(withDuration: HeadShake.segmentDuration,
                       animations: { self.rotateFace(by: HeadShake.angle) },
                       completion: { finished in
                        UIView.animate(withDuration: HeadShake.segmentDuration,
                                       animations: { self.rotateFace(by: -HeadShake.angle*2) },
                                       completion: { finished in
                                        UIView.animate(withDuration: HeadShake.segmentDuration,
                                                       animations: { self.rotateFace(by: HeadShake.angle) }
                                        ) }
                        ) }
        )
    }
    
    @objc func increaseHappiness(byReactingTo swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .ended {
            expression = expression.happier
        }
    }
    @objc func decreaseHappiness() {
        expression = expression.sadder
    }
    
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,
                                   .frown: -1.0,
                                   .smile:1.0,
                                   .neutral:0.0,
                                   .smirk:-0.5]
}

