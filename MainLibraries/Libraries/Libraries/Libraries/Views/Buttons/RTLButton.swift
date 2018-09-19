//
//  RTLButton.swift
//  SmartBoiler
//
//  Created by Max Bolotov on 1/11/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

class RTLButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if Localize.isDirectionRightToLeft() {
            
            self.titleEdgeInsets = UIEdgeInsetsMake(self.titleEdgeInsets.top, self.titleEdgeInsets.right, self.titleEdgeInsets.bottom, self.titleEdgeInsets.left)
            self.imageEdgeInsets = UIEdgeInsetsMake(self.imageEdgeInsets.top, self.imageEdgeInsets.right, self.imageEdgeInsets.bottom, self.imageEdgeInsets.left)
            self.contentEdgeInsets = UIEdgeInsetsMake(self.contentEdgeInsets.top, self.contentEdgeInsets.right, self.contentEdgeInsets.bottom, self.contentEdgeInsets.left)
        }
    }
}

