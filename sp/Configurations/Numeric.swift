//
//  Numeric.swift
//  sp
//
//  Created by Yuvaraj Naidu on 12/04/2023.
//
import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}



//extension Locale {
//    static let englishUS: Locale = .init(identifier: "en_US")
//    static let frenchFR: Locale = .init(identifier: "fr_FR")
//    static let portugueseBR: Locale = .init(identifier: "pt_BR")
//    // ... and so on
//}
//extension Numeric {
//    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
//        Formatter.number.locale = locale
//        Formatter.number.numberStyle = style
//        if let groupingSeparator = groupingSeparator {
//            Formatter.number.groupingSeparator = groupingSeparator
//        }
//        return Formatter.number.string(for: self) ?? ""
//    }
//    // Localized
//    var currency:   String { formatted(style: .currency) }
//    // Fixed locales
//    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
//    var currencyFR: String { formatted(style: .currency, locale: .frenchFR) }
//    var currencyBR: String { formatted(style: .currency, locale: .portugueseBR) }
//    // ... and so on
//    var calculator: String { formatted(groupingSeparator: " ", style: .decimal) }
//}
