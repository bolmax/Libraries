//
//  SessionManager.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation
//import KeychainAccess

class SessionManager: SessionManagerProtocol {

//    lazy var keychain = Keychain()
    
    func clear() {
        // TODO: Clear
    }
}

extension SessionManager {
    
    func hasActiveToken() -> Bool {
        return true//self.keychain["access-token"] != nil
    }
    
    func accessToken() -> String? {
        return nil//self.keychain["access-token"]
    }
    
    func setAccessToken(_ token: String?) {
        //self.keychain["access-token"] = token
    }
}
