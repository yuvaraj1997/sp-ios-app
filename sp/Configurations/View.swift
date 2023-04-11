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
    
}
