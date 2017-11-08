//
//  FreehandTool.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class FreehandTool: Tool {
    var path: PathShape?
    var layer: Layer?
    
    override func toolDown(point: CGPoint) {
        super.toolDown(point: point)
        
        path = PathShape()

        if let layer = self.layer, let path = self.path {
            path.points.append(point)
            layer.shapes.append(path)
        }
    }
    
    override func toolDragged(point: CGPoint) {
        super.toolDragged(point: point)
        
        if let path = self.path {
            path.points.append(point)
        }
    }
    
    override func toolUp(point: CGPoint) {
        super.toolUp(point: point)

        NotificationCenter.default.post(name: .DocumentModelUpdated, object: self)
        resetPath()
    }
    
    override func toolCancel(point: CGPoint) {
        super.toolCancel(point: point)
        
        resetPath()
    }
    
    func resetPath() {
        path = nil
    }
}
