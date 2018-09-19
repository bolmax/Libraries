//
//  UISearchBar.swift
//  MOETeachers
//
//  Created by Max Bolotov on 9/12/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func textFieldFrame() -> CGRect {
        
        for subView in self.subviews  {
            
            for subsubView in subView.subviews  {
                if let textField = subsubView as? UITextField {
                    return textField.frame
                }
            }
        }
        return CGRect.zero
    }
}
