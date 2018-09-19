//
//  AlertableView.swift
//  WeatherTest
//
//  Created by Sergey Krasiuk on 31/01/2018.
//  Copyright © 2018 Sergey Krasiuk. All rights reserved.
//

import UIKit

// MARK: - Alertable View

protocol AlertableView {
    
    // Use handler if need catch cancel alert action
    typealias CompletionHandler = (() -> Void)
    
    func displayOKAlert(with title: String, message: String?, completion: CompletionHandler?)
    func displayCancellableAlert(with title: String, message: String?, completion: CompletionHandler?, cancelCompletion: CompletionHandler?)
    func displayAlert(with title: String, message: String?, approveTitle: String, cancelTitle: String?, completion: CompletionHandler?)
    func displayAlert(with title: String, message: String?, approveTitle: String, cancelTitle: String?, completion: CompletionHandler?, cancelCompletion: CompletionHandler?)
}

extension AlertableView where Self: UIViewController {
    
    func displayOKAlert(with title: String, message: String?, completion: CompletionHandler? ) {
        self.displayAlert(with: title, message: message, approveTitle: "OK".localized, cancelTitle: nil, completion: completion)
    }
    
    func displayCancellableAlert(with title: String, message: String?, completion: CompletionHandler?, cancelCompletion: CompletionHandler?) {
        self.displayAlert(with: title, message: message, approveTitle: "OK".localized, cancelTitle: "Cancel".localized, completion: completion, cancelCompletion: cancelCompletion)
    }
    
    func displayAlert(with title: String, message: String?, approveTitle: String, cancelTitle: String?, completion: CompletionHandler?) {
        self.displayAlert(with: title, message: message, approveTitle: approveTitle, cancelTitle: cancelTitle, completion: completion, cancelCompletion: nil)
    }
    
    func displayAlert(with title: String, message: String?, approveTitle: String, cancelTitle: String?, completion: AlertableView.CompletionHandler?, cancelCompletion: AlertableView.CompletionHandler?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: approveTitle, style: .default) { (action) in
            guard let completion = completion else { return }
            completion()
        }
        
        alertController.addAction(okAction)
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
                guard let cancelCompletion = cancelCompletion else { return }
                cancelCompletion()
            }
            
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
