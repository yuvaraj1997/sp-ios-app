//
//  View.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

extension View {
    
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    @ViewBuilder func applyTextColor(_ color: Color) -> some View {
      if UITraitCollection.current.userInterfaceStyle == .light {
        self.colorInvert().colorMultiply(color)
      } else {
        self.colorInvert().colorMultiply(color)
      }
    }  
    
}
