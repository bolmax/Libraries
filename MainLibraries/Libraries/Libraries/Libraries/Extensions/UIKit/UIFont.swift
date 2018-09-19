//
//  UIFont.swift
//  MOETeachers
//
//  Created by Valera on 8/21/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension UIFont {
    
    open class func assistantSemiBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Assistant-SemiBold", size: fontSize)!
    }
    
    open class func assistantBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Assistant-Bold", size: fontSize)!
    }
    
    open class func assistantRegularFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Assistant-Regular", size: fontSize)!
    }
    
    open class func awesomeSolidFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Font Awesome 5 Free", size: fontSize)!
    }
}
