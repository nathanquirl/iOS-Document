//
//  Layer.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class Layer: Codable {
    var shapes: [PathShape] = []
    
    func display(context: CGContext) {
        for shape in shapes {
            shape.display(context: context)
        }
    }
}
