//
//  FaceView.swift
//  FaceIt
//
//  Created by KimYusung on 9/5/17.
//  Copyright © 2017 yusungkim. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.9

    override func draw(_ rect: CGRect) {
        let skullRadius = min(bounds.size.width, bounds.size.height) / 2 * scale
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)//convert(center, from: superview)
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: true)
        path.lineWidth = 5.0
        UIColor.blue.set()
        path.stroke()
    }
}
