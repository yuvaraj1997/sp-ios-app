//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct HomepageView: View {
    
    
    init() {
         UITableView.appearance().backgroundColor = UIColor(.red)
     }
    
    @State private var showPeriodSelection = false
    @State private var index = 0
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GeometryReader { reader in
                             Color.primaryColor
                            .frame(height: reader.safeAreaInsets.top, alignment: .top)
                                 .ignoresSafeArea()
                         }
                Color.bgColor.edgesIgnoringSafeArea([.bottom])
                
                VStack(spacing: 0) {
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
                                Spacer()
                            }
                            CustomText(text: "MYR 2,200.00", size: .h1, color: .secondaryColor, bold: true)
                        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]).fill(Color.primaryColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle().padding(.bottom, -20)))
                
                    
                    //Wallets & Transactions
                    ScrollView(.vertical) {
                        Group {
                            //Wallets
                            VStack(alignment: .leading) {
                                CustomText(text: "Wallets", size: .h4, color: .secondaryColor, bold: true)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack {
                                Spacer()
                                VStack {
                                    TabView(selection: $index) {
                                                 ForEach((0..<3), id: \.self) { index in
                                                     cardView
                                                 }
                                             }
                                             .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    
                                    HStack(spacing: 2) {
                                        ForEach((0..<3), id: \.self) { index in
                                            Circle()
                                                .fill(index == self.index ? Color.secondaryColor : Color.secondaryColor.opacity(0.5))
                                                .frame(width: 10, height: 10)
                                                .padding(.horizontal, 3)
                                                .padding(.vertical, -120)

                                        }
                                    }
                                    .padding()
                                }
                            }
                            .padding(EdgeInsets(top: -130, leading: 0, bottom: 0, trailing: 0))
                            .frame(height: 340)
                            
                            //Transactions
                            Group {
                                VStack(alignment: .leading) {
                                    CustomText(text: "Transactions", size: .h4, color: .secondaryColor, bold: true)
                                }
                                .padding(EdgeInsets(top: -120, leading: 0, bottom: 0, trailing: 0))

                                VStack {
                                    ForEach((0..<10), id: \.self) { index in
                                        
                                        HStack(alignment: .center) {
                                            Circle()
                                                .fill(Color.secondaryColor)
                                                .frame(width: 46, height: 46)
                                                .overlay{
                                                    Image(systemName: "cart.fill")
                                                        .foregroundColor(Color.bgColor)
                                                }
                                            VStack(alignment: .leading) {
                                                
                                                CustomText(text: "Shopping", size: .p1, color: .secondaryColor, bold: true)
                                                CustomText(text: "11 Jan 2022", size: .p1, color: .secondaryColor, bold: false)
                                            }.padding(.horizontal, 8)
                                            Spacer()
                                            
                                            if index % 2 == 0 {
                                                CustomText(text: "- MYR 20.00", size: .p1, color: .error, bold: true)
                                            } else {
                                                CustomText(text: "+ MYR 20.00", size: .p1, color: .success, bold: true)
                                            }
                                        }
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding(EdgeInsets(top: -120, leading: 0, bottom: 20, trailing: 0))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        }
                    }
                    //End Scroll View
                }
            }
        }
        .sheet(isPresented: self.$showPeriodSelection,
               onDismiss: didDismiss) {
            ZStack(alignment: .leading) {
                Color.accentColor.presentationDetents([.height(200)])
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scrollIndicators(.never)
                    Spacer()
                }
                .padding()
            }
            .ignoresSafeArea()
        }
    }
    
    var cardView: some View {
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

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
