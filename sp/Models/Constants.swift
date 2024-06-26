//
//  Constants.swift
//  sp
//
//  Created by Yuvaraj Naidu on 03/06/2023.
//

import Foundation


struct Constants {
    static let FINANCIAL_MANAGEMENT_API = "http://localhost:8080"
    
    
    
    static func replaceNullWithEmpty(val: String?) -> String {
        if (nil == val){
            return ""
        }
        return val!
    }
}
