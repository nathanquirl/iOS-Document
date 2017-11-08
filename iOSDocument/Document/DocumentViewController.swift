//
//  DocumentViewController.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {

    var document: Document?
    
    var toolDown: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        if let document = self.document {
            document.open(completionHandler: { (success) in
                if success {
                    if let drawingView = self.view as? DrawingView {
                        drawingView.drawing = self.document?.drawing;
                        drawingView.setNeedsDisplay()
                    }
                } else {
                    let title = NSLocalizedString("Cannot Open Document", comment: "Document open fail title")
                    let message = NSLocalizedString("Unexpected document format.", comment: "Document open fail")
                    
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Alert accept"),
                                                  style:.default,
                                                  handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            if let document = self.document {
                document.close(completionHandler: nil)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let doc = document {
            if let location = touches.first?.location(in: self.view) {
                doc.activeTool().toolDown(point: location)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let doc = document {
            let tool = doc.activeTool()
            
            if tool.toolDown {
                if let location = touches.first?.location(in: self.view) {
                    tool.toolDragged(point: location)
                    
                    self.view.setNeedsDisplay()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let doc = document {
            if let location = touches.first?.location(in: self.view) {
                doc.activeTool().toolUp(point: location)
                
                self.view.setNeedsDisplay()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let doc = document {
            if let location = touches.first?.location(in: self.view) {
                doc.activeTool().toolCancel(point: location)
                
                self.view.setNeedsDisplay()
            }
        }
    }
}
