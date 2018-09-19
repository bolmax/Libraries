//
//  String.swift
//  MOETeachers
//
//  Created by Max Bolotov on 9/11/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension String {
    
    func highlight(matchingText: String, to color: UIColor) -> NSMutableAttributedString {
        
        let attributedString  = NSMutableAttributedString(string: self)
        if let regularExpression = try? NSRegularExpression(pattern: "\(matchingText)", options: .caseInsensitive) {
            let matchedResults = regularExpression.matches(in: self, options: [], range: NSRange(location: 0, length: attributedString.length))
            for matched in matchedResults {
                attributedString.addAttributes([ NSAttributedStringKey.foregroundColor : color ], range: matched.range)
            }
        }
        return attributedString
    }
    
    func isNotBlanked() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == false
    }
    
}
