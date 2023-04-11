//
//  HomepageHeadingView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

struct HomepageHeadingView: View {
    
    @Binding var showPeriodSelection: Bool
    
    var body: some View {
        
        VStack {
            //User greetings & image
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    CustomText(text: "Hello <Name>", size: .h4, color: .secondaryColor, bold: true)
                    CustomText(text: "Welcome back", size: .p2, color: .secondaryColor)
                }
                Spacer()
                Avatar(image: "profile_picture")
            }
            //Total Spending & Control
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center, spacing: 4) {
                    CustomText(text: "Total Spending", size: .p1, color: .secondaryColor, bold: true)
                    CustomText(text: "-", size: .p1, color: .secondaryColor)
                    HStack(alignment: .center, spacing: 4) {
                        CustomText(text: "March 2023", size: .p2, color: .secondaryColor)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .foregroundColor(.secondaryColor)
                            .frame(width: 10, height: 5)
                    }
                    .onTapGesture(perform: {
                        self.showPeriodSelection.toggle()
                    })
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    Spacer()
                }
                CustomText(text: "MYR 2,200.00", size: .h1, color: .secondaryColor, bold: true)
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]).fill(Color.primaryColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle().padding(.bottom, -20)))
    }
}

struct HomepageHeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageHeadingView(showPeriodSelection: .constant(false))
    }
}
