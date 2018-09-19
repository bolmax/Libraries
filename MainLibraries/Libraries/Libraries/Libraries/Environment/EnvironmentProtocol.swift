//
//  EnvironmentProtocol.swift
//  Meuhedet
//
//  Created by Tsahi Deri on 01/04/2018.
//  Copyright © 2018 Sergey Krasiuk. All rights reserved.
//

import Foundation

protocol EnvironmentProtocol {
    
    var type: EnvironmentType { get set }
    var baseURLString: String { get set }
    var versionURLString: String { get set }
    var usingStubs: Bool { get set }
    var delayedStub: Int { get set }
    var authorization: Authorization { get set }
}

enum EnvironmentType {
    
    case development
    case staging
    case production
}

struct Authorization {
    
    var idm: String
    var clientID: String
    var clientSecret: String
    var redirectURI: String
    var headerName: String
    var headerPrefix: String
    
    init() {
        
        self.idm = ""
        self.clientID = ""
        self.clientSecret = ""
        self.redirectURI = ""
        self.headerName = ""
        self.headerPrefix = ""
    }
    
    init(with dictionary: [String : Any]) {
        
        self.idm = dictionary["IDM"] as? String ?? ""
        self.clientID = dictionary["ClientID"] as? String ?? ""
        self.clientSecret = dictionary["ClientSecret"] as? String ?? ""
        self.redirectURI = dictionary["RedirectURI"] as? String ?? ""
        self.headerName = dictionary["HeaderName"] as? String ?? ""
        self.headerPrefix = dictionary["HeaderPrefix"] as? String ?? ""
    }
}
