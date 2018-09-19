//
//  UIView.swift
//  MOETeachers
//
//  Created by Max Bolotov on 9/11/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(with color: CGColor, offset: CGSize? = nil, radius: CGFloat? = nil, opacity: CGFloat? = nil) {
        
        self.layer.shadowColor = color
        
        if let shadowOffset = offset {
            self.layer.shadowOffset = shadowOffset
        }
        if let shadowRadius = radius {
            self.layer.shadowRadius = shadowRadius
        }
        if let shadowOpacity = opacity {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
}
