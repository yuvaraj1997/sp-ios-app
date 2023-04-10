//
//  CustomText.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct CustomText: View {
    
    var text: String
    var size: Size
    var color: Color
    var bold: Bool = false
    
    func sizeValue() -> Double {
        switch self.size {
            case Size.h0:
                return 40
            case Size.h1:
                return 32
            case Size.h2:
                return 26
            case Size.h3:
                return 22
            case Size.h4:
                return 20
            case Size.p1:
                return 13
            case Size.p2:
                return 11
        }
    }
    
    var body: some View {
        Text(self.text)
            .font(.system(size: sizeValue()))
            .foregroundColor(self.color)
            .bold(self.bold)
    }
}

enum Size {
  case h0
  case h1
  case h2
  case h3
  case h4
  case p1
  case p2
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "Hello World!", size: .h1, color: .accentColor, bold: false)
    }
}
