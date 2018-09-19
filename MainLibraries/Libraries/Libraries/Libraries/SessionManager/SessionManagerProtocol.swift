//
//  SessionManagerProtocol.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation

protocol SessionManagerProtocol {
    
    func clear()
    
    func hasActiveToken() -> Bool
    func accessToken() -> String?
    func setAccessToken(_ token: String?)
}
