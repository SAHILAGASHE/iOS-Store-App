//
//  UIViewController+Extensions.swift
//  Store-App
//
//  Created by Sahil Agashe on 13/04/23.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
    
    func showMessage(title: String, message: String, messageType: MessageType) {
        
        let hostingController = UIHostingController(rootView: MessageView(title: title, message: message, messageType: messageType))
      
        guard let messageView = hostingController.view else { return }
        
        view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        messageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // remove the errorView
            messageView.removeFromSuperview()
        }
        
    }
    
}
