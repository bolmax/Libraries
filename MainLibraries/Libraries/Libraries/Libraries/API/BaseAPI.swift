//
//  BaseAPI.swift
//  MOETeachers
//
//  Created by Valera on 8/31/18.
//  Copyright © 2018 IdeoDigital. All rights reserved.
//

//import Moya
import Foundation

protocol BaseAPI {
    static var shouldUseStubs: Bool { get }
}

extension BaseAPI {
    
    var baseURL: URL {
        return URL(string: "\(AppContext.shared.environment.baseURLString)")!
    }

    func stubbedResponseFromJSONFile(filename: String, inDirectory subpath: String = "", bundle: Bundle = Bundle.main ) -> Data {
        
        guard let path = bundle.path(forResource: filename, ofType: "json", inDirectory: subpath) else { return Data() }
        
        if let dataString = try? String(contentsOfFile: path), let data = dataString.data(using: String.Encoding.utf8){
            return data
        } else {
            return Data()
        }
    }
}
