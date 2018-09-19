//
//  Router.swift
//  MOETeachers
//
//  Created by Valera on 8/21/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

class Router {
    
    class var window:UIWindow? {
        return UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first
    }
    
    static func showSplash() {
        self.window?.rootViewController = ApplicationStoryboard.splash.initialViewController()
    }
    
    static func showMain() {
        self.window?.rootViewController = ApplicationStoryboard.main.initialViewController()
    }
    
    static func showAuth() {
        
        if AppContext.shared.environment.type == .development {
            self.window?.rootViewController = ApplicationStoryboard.auth.initialViewController()
        } else {
            self.window?.rootViewController = ApplicationStoryboard.auth.initialViewController()
        }
    }
    
    static func openInbox() {
        
    }
    
    static func openBookmarks() {
        
    }
    
    static func openProfile() {
        
    }
    
}

extension Router {
    
    static func handle(url: URL) {
        
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func handle(urlString: String) {
        
        if let url = URL(string: urlString) {
            self.handle(url: url)
        }
    }
}
