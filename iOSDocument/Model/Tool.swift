//
//  Tool.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class Tool: NSObject {
    private(set) var toolDown: Bool = false
    
    func toolDown(point: CGPoint) { toolDown = true; }
    func toolDragged(point: CGPoint) {}
    func toolUp(point: CGPoint) { toolDown = false; }
    func toolCancel(point: CGPoint) { toolDown = false; }
    
    // Can be used for interactive display of shape proxies
    // before applying changes to document
    func display(context: CGContext) {}
}
