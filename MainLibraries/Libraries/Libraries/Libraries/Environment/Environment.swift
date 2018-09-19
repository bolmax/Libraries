//
//  Environment.swift
//  Meuhedet
//
//  Created by Tsahi Deri on 01/04/2018.
//  Copyright © 2018 Sergey Krasiuk. All rights reserved.
//

import Foundation

struct Environment: EnvironmentProtocol {
    
    var delayedStub: Int
    var type: EnvironmentType = .production
    var baseURLString: String
    var versionURLString: String
    var usingStubs: Bool
    var authorization: Authorization
    
    init() {
        
        guard let environmentFileName = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String else {
            fatalError("No environment file name has been configured for the project in Info.plist under 'Environment' key.")
        }

        guard let path = Bundle.main.path(forResource: environmentFileName, ofType: "plist") else {
            fatalError("Environment plist with name '\(environmentFileName)' not found in project bundle.")
        }
        
        guard let environmentDictionary = NSDictionary(contentsOfFile: path) else {
            fatalError("Environment plist with name '\(environmentFileName)' cannot be parsed to disctionary")
        }
        
        if let environmentTypeString = environmentDictionary["EnvironmentType"] as? String {
            self.type = EnvironmentType.from(string: environmentTypeString)
        }
        self.baseURLString = environmentDictionary["BaseURL"] as? String ?? ""
        self.versionURLString = environmentDictionary["VersionURL"] as? String ?? ""
        self.usingStubs = environmentDictionary["UsingStubs"] as? Bool ?? false
        
        self.authorization = Authorization()
        if let authorizationDictionary = environmentDictionary["Authorization"] as? [String : String] {
            self.authorization = Authorization(with: authorizationDictionary)
        }
        
        self.delayedStub = environmentDictionary["delayedStub"] as? Int ?? 0
    }
}

extension EnvironmentType {
    
    static func from(string: String) -> EnvironmentType {
        
        switch string.lowercased() {
        case "development":
            return .development
        case "staging":
            return .staging
        case "production":
            return .production
        default:
            return .production
        }
    }
}
