//
//  StoreManager.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation

class StoreManager: StoreManagerProtocol {
    
    private lazy var userDefault = UserDefaults.standard
        
    // MARK: - First Launch
    
    func isFirstLaunchOccurred() -> Bool {
        return userDefault.bool(forKey: "FirstLaunchOccurred")
    }
    
    func setFirstLaunch(occurred: Bool) {
        userDefault.set(occurred, forKey: "FirstLaunchOccurred")
    }
    
}
