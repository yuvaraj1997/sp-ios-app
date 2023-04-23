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
    
    var emptyCard: Bool = false
    var action: (() -> Void) /// use closure for callback
    
    var body: some View {
        if !emptyCard {
            VStack(alignment: .leading){
                CustomText(text: "Bank A", size: .p1, color: .bg_color)
                CustomText(text: "MYR 1,200.00", size: .h4, color: .bg_color, bold: true)
                    .frame(alignment: .center)
                    .frame(maxWidth: .infinity, maxHeight: 95)
            }
            .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
            .frame(maxWidth: self.screenWidth - 40, maxHeight: 184, alignment: .topLeading)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.gradient)
                .shadow(color: Color.white, radius: 2))
        } else {
            VStack(alignment: .leading){
                CustomText(text: "+", size: .h4, bold: true)
                    .frame(alignment: .center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
            .frame(maxWidth: self.screenWidth - 40, maxHeight: 184, alignment: .topLeading)
            .background(RoundedRectangle(cornerRadius: 30)
                .strokeBorder(Color.white, style: StrokeStyle(lineWidth: 2, dash: [8]))
            )
            .onTapGesture {
                self.action()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(ModalControl())
    }
}
