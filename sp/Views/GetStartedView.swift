//
//  GetStartedView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct GetStartedView: View {
    
    @Binding var getStartedClicked: Bool
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                Image("GetStarted/bg")
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.7)
                
                VStack(alignment: .center, spacing: 22) {
                    //Title
                    CustomText(text: "EZ. PZ.",
                               size: .h1,
                               bold: true)
                    
                    
                    //Sub
                    CustomText(text: "Start tracking your spending now.\nHassle free.",
                               size: .p1)
                    .multilineTextAlignment(.center)
                 
                    //Button
                    CustomButton(
                        label: "Get Started",
                        type: .primary,
                        action: {
                            self.getStartedClicked.toggle()
                        }
                    )
                    .padding(EdgeInsets(top: 35, leading: 0, bottom: 60, trailing: 0))
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView(getStartedClicked: .constant(false))
    }
}
