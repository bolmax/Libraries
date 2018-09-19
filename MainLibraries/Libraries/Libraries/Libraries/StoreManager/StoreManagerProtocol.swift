//
//  StoreManagerProtocol.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation

protocol StoreManagerProtocol {
    
    // MARK: - First Launch
    
    func isFirstLaunchOccurred() -> Bool
    func setFirstLaunch(occurred: Bool)
}
