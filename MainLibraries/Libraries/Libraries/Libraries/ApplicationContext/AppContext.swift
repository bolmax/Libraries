//
//  AppContext.swift
//  MOETeachers
//
//  Created by Tsahi Deri on 19/08/2018.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation

class AppContext {
    
    static let shared = AppContext()
    
    let environment: EnvironmentProtocol!
    let storeManager: StoreManagerProtocol!
    let sessionManager: SessionManagerProtocol!
    let contentProvider: ContentProviderProtocol!
    
    // MARK: - Private
    
    private init() {
    
        self.environment = Environment()
        self.storeManager = StoreManager()
        self.sessionManager = SessionManager()
        self.contentProvider = ContentProvider()
        
        let authorization = self.environment.authorization
        // TODO:
    }
    
    func performFirstLaunchActionsIfNeeded() {
        
        if self.storeManager.isFirstLaunchOccurred() == false {
            
            self.storeManager.setFirstLaunch(occurred: true)
            self.sessionManager.clear()
            // TODO: Clear session, KeyChain or any other information needded
        }
    }
}
