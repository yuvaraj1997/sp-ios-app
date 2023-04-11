//
//  CardView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

struct CardView: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .leading){
            CustomText(text: "Bank A", size: .p1, color: .bgColor)
            CustomText(text: "MYR 1,200.00", size: .h4, color: .bgColor, bold: true)
                .frame(alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: 95)
        }
        .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
        .frame(maxWidth: self.screenWidth - 40, maxHeight: 184, alignment: .topLeading)
        .background(RoundedRectangle(cornerRadius: 30)
            .fill(Color.secondaryColor.gradient)
            .shadow(color: Color.secondaryColor, radius: 2))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
