//
//  Formatter.swift
//  sp
//
//  Created by Yuvaraj Naidu on 12/04/2023.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.groupingSeparator = ","
        return formatter
    }()
}
