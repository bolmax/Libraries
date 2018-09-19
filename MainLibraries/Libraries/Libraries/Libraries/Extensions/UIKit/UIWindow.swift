//
//  UIWindow.swift
//  MOETeachers
//
//  Created by Valera on 8/31/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import UIKit

extension UIWindow {
    
    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let controller = ApplicationStoryboard.stubs.initialViewController()
            self.rootViewController?.present(controller!, animated: true, completion: nil)
        }
    }
}
