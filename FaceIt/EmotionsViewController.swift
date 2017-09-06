//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by KimYusung on 9/6/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController, UISplitViewControllerDelegate {

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
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return false
    }
}
