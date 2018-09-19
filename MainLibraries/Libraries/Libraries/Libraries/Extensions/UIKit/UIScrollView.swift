//
//  UIScrollView.swift
//  MOETeachers
//
//  Created by Max Bolotov on 9/11/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var isOnTop: Bool {
        return contentOffset.y > 0
    }
    
    var isBouncingBottom: Bool {
        
        let contentFillsScrollEdges = contentSize.height + contentInset.top + contentInset.bottom >= bounds.height
        return contentFillsScrollEdges && contentOffset.y > contentSize.height - bounds.height + contentInset.bottom
    }
    
    var isBouncingTop: Bool {
        return contentOffset.y < -contentInset.top
    }
}
