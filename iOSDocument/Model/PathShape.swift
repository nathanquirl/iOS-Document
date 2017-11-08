//
//  PathShape.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class PathShape: Codable {
    var points: [CGPoint] = []
    
    func display(context: CGContext) {
        if !points.isEmpty {
            context.setLineWidth(2.0)
            context.setStrokeColor(UIColor.darkGray.cgColor)
            
            context.move(to: points[0])
            
            for i in 1..<points.count {
                context.addLine(to: points[i])
            }
            
            context.strokePath()
        }
    }
}
