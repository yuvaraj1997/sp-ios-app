//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct HomepageView: View {
    
    @State private var showPeriodSelection = false
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.accentColor.edgesIgnoringSafeArea(.all)
                
                //Heading Card
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
                            .sheet(isPresented: self.$showPeriodSelection,
                                   onDismiss: didDismiss) {
                                ZStack(alignment: .leading) {
                                    Color.accentColor.presentationDetents([.height(150)])
                                    VStack(alignment: .leading){
                                        CustomText(text: "Select Period", size: .p1, color: .secondaryColor, bold: true)
                                        
                                        ScrollView {
                                            VStack(alignment: .leading, spacing: 20) {
                                                CustomText(text: "Current Month", size: .p1, color: .secondaryColor)
                                                CustomText(text: "Previous Month", size: .p1, color: .secondaryColor)
                                                CustomText(text: "Year", size: .p1, color: .secondaryColor)
                                                CustomText(text: "Custom", size: .p1, color: .secondaryColor)
                                            }
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        }
                                            
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 30, leading: 33, bottom: 30, trailing: 33))
                                }
                                .ignoresSafeArea()
                            }
                            Spacer()
                        }
                        CustomText(text: "MYR 2,200.00", size: .h1, color: .secondaryColor, bold: true)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 75, leading: 33, bottom: 30, trailing: 33))
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.primaryColor).shadow(radius: 20))
                .ignoresSafeArea(.all, edges: .top)
            }
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
