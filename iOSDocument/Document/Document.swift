//
//  Document.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    public static let DocumentModelUpdated = Notification.Name("DocumentModelUpdated")
}

class Document: UIDocument {

    let freehandTool = FreehandTool()
    var drawing: Drawing = Drawing()
    
    override init(fileURL url: URL) {
        super.init(fileURL: url)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(documentModelUpdated),
                                               name: .DocumentModelUpdated,
                                               object: nil)
    }
    
    @objc func documentModelUpdated() {
        updateChangeCount(.done)
    }

    func activeTool() -> Tool {
        if let layer = activeLayer() {
            freehandTool.layer = layer
        }
        
        return freehandTool
    }
    
    func activeLayer() -> Layer? {
        // TODO: Support multiple layers; For now just use the first available layer
        if let layer = drawing.layers.first {
            return layer
        }
        
        return nil
    }
    
    override func contents(forType typeName: String) throws -> Any {
        let jsonEncoder = JSONEncoder()
        
        let jsonData = try jsonEncoder.encode(drawing)
        return jsonData
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let data = contents as? Data {
            drawing = try JSONDecoder().decode(Drawing.self, from: data)
        }
    }
}

