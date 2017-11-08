//
//  DrawingView.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    var drawing: Drawing?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if let drawing = self.drawing {
            if let context = UIGraphicsGetCurrentContext() {
                drawing.display(context: context)
            }
        }
    }
}
