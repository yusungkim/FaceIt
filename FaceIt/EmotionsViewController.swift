//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by KimYusung on 9/6/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class EmotionsViewController: VCLLoggingViewController, UISplitViewControllerDelegate {

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination
        
        if let navigationController = destinationController as? UINavigationController {
            destinationController = navigationController.visibleViewController ?? destinationController
        }
        
        if let faceViewController = destinationController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {
            faceViewController.expression = expression
            
            faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]
    
    // set the splitVC's delegate in the very early stage.
    // splitViewController? is a point for the splitVC who is pointing me.
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let _ = secondaryViewController.contents as? FaceViewController {
                return true // I(emotionVC) will do the collapse job, but the actual code for collapse is not in me, so it is not going to collapse.
            }
        }
        return false // You(splitVC) do the collapse job, which means it will collapse as a default in your setting.
    }
}

extension UIViewController {
    var contents: UIViewController? {
        get {
            if let navcon = self as? UINavigationController {
                return navcon.visibleViewController
            } else {
                return self
            }
        }
    }
}
