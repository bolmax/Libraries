//
//  LanguageManager.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension Localize {
    
    // MARK: Localize library extension
    
    func setLayout(direction: UISemanticContentAttribute, `for` controls: [UIView]) {
        
        controls.forEach { (view) in
            view.semanticContentAttribute = direction
        }
    }
    
    open class func isRTLDirection(language: String) -> Bool {
        return Locale.characterDirection(forLanguage: language) == .leftToRight ? false : true
    }
    
    open class func isDirectionRightToLeft() -> Bool {
        return Localize.isRTLDirection(language: Localize.currentLanguage())
    }
}
