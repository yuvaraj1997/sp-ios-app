//
//  ErrorResponse.swift
//  sp
//
//  Created by Yuvaraj Naidu on 30/05/2023.
//

import Foundation

struct ErrorResponse: Hashable, Codable, Error {
    
    var status: CommonResponse
    var error: CommonResponse?
    var additionalProperties: [String : String]?

    struct CommonResponse: Hashable, Codable {
        var code: Int
        var message: String
    }
    
}


