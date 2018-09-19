//
//  BaseResponse.swift
//  MOETeachers
//
//  Created by Valera on 9/3/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

import Foundation

public protocol Serializable {
    init?(jsonData: [String: Any])
}

class BaseResponse: Serializable {
    

    var code: Int
    var errorMessage: String
    var data: Data?
    
    required init?(jsonData: [String: Any]) {
        
        self.code = jsonData["code"] as? Int ?? 0
        self.errorMessage = jsonData["errorMessage"] as? String ?? ""
        self.data = jsonData["data"] as? Data ?? Data()
    }
}
