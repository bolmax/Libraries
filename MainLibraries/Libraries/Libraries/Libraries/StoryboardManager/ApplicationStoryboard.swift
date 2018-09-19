//
//  ApplicationStoryboard.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

enum ApplicationStoryboard: String {
    
    // MARK: Storyboards names
    
    case main, splash, auth, stubs
    
    var storyboardInstance : UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return storyboardInstance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return storyboardInstance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiate(fromStoryboard storyboard: ApplicationStoryboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
