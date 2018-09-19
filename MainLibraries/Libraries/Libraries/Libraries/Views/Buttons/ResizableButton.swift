//
//  ResizableButton.swift
//  SmartBoiler
//
//  Created by Max Bolotov on 3/12/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation
import CoreGraphics

class ResizableButton: RTLButton {
    
    override var intrinsicContentSize: CGSize {
        
        get {
            if let defaultSize = self.titleLabel?.intrinsicContentSize {
                return CGSize(width: defaultSize.width + self.insetsWidth(), height: defaultSize.height)
            }
            return super.intrinsicContentSize
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let width = self.titleLabel?.frame.size.width {
            self.titleLabel?.preferredMaxLayoutWidth = width
        }
    }
    
    func insetsWidth() -> CGFloat {
        
        var width = self.titleEdgeInsets.left +  self.titleEdgeInsets.right + self.imageEdgeInsets.left + self.imageEdgeInsets.right
        
        if let image = self.imageView?.image {
            width += image.size.width
        }
        return width
    }
    
}
