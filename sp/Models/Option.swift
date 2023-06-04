//
//  Option.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import Foundation

struct Option {
    
    let id = UUID()
    var value: String
    var text: String
    
    init(value: String, text: String) {
         self.value = value
         self.text = text
     }
    
}

struct DropdownOption: Decodable {
    var value: String
    var text: String
    
    init() {
        value = ""
        text = ""
    }
}
