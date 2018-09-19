//
//  RoutableViewControllerProtocol.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

protocol RoutableViewControllerProtocol {
    
    // MARK: - Navigation
    
    func pop()
    func popToRoot()
    
    // MARK: -

}

extension RoutableViewControllerProtocol where Self: UIViewController {
    
    // MARK: - Navigation
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

