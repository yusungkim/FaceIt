//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by KimYusung on 2017/10/08.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {
    public var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    private func blinkIfNeeded() {
        if blinking {
            faceView.eyesOpen = true
            Timer.scheduledTimer(withTimeInterval: blinkRate.eyesOpenDuration, repeats: false, block: { [weak self] timer in
                self?.faceView.eyesOpen = false
                Timer.scheduledTimer(withTimeInterval: blinkRate.eyesClosedDuration, repeats: false, block: { [weak self] timer in
                    self?.blinkIfNeeded()
                })
            })
        }
    }
    
    private struct blinkRate {
        static let eyesOpenDuration: TimeInterval = 2.0
        static let eyesClosedDuration: TimeInterval = 0.4
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        blinking = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
}
