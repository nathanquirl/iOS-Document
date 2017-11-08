//
//  Drawing.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class Drawing: Codable {
    var layers: [Layer] = [Layer()]
    
    func display(context: CGContext) {
        for layer in layers {
            layer.display(context: context)
        }
    }
}
