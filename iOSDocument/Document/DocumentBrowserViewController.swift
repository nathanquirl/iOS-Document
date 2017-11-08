//
//  DocumentBrowserViewController.swift
//  iOSDocument
//
//  Created by Nathan Quirl on 11/7/17.
//  Copyright © 2017 Cinespan, Inc. All rights reserved.
//

import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
    }
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        let newDocumentURL: URL? = nil

        if newDocumentURL != nil {
            importHandler(newDocumentURL, .move)
        } else {
            // Create document
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("untitled").appendingPathExtension("diplo")
            let doc = Document(fileURL: url)

            // Create a new document in a temporary location
            doc.save(to: url, for: .forCreating) { (saveSuccess) in
                
                // Make sure the document saved successfully
                guard saveSuccess else {
                    // Cancel document creation
                    importHandler(nil, .none)
                    return
                }
                
                // Close the document.
                doc.close(completionHandler: { (closeSuccess) in
                    
                    // Make sure the document closed successfully
                    guard closeSuccess else {
                        // Cancel document creation
                        importHandler(nil, .none)
                        return
                    }
                    
                    // Pass the document's temporary URL to the import handler.
                    importHandler(url, .move)
                })
            }
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        let title = NSLocalizedString("Cannot Import Document", comment: "Document import fail title")
        let message = NSLocalizedString("Unexpected document format.", comment: "Document import fail")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Alert accept"),
                                      style:.default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentViewController.document = Document(fileURL: documentURL)
        
        present(documentViewController, animated: true, completion: nil)
    }
}

