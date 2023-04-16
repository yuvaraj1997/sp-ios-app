//
//  WalletView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

struct WalletView: View {
    
    @State private var index = 0
    
    @EnvironmentObject var modalControl: ModalControl
    
    var body: some View {
        ZStack {
            //Wallets & Transactions
            ScrollView(.vertical) {
                Group {
                    //Wallets
                    VStack(alignment: .leading) {
                        CustomText(text: "Wallets", size: .p1, color: .secondaryColor, bold: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        Spacer()
                        VStack {
                            TabView(selection: $index) {
                                         ForEach((0..<3), id: \.self) { index in
                                             CardView(action: {})
                                         }
                                        CardView(emptyCard: true, action: {
                                            self.modalControl.showCreateWalletView.toggle()
                                        })
                                        .tag(3)
                                     }
                                     .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            HStack(spacing: 2) {
                                ForEach((0..<4), id: \.self) { index in
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
                            CustomText(text: "Transactions", size: .p1, color: .secondaryColor, bold: true)
                        }
                        .padding(EdgeInsets(top: -120, leading: 0, bottom: 0, trailing: 0))

                        VStack {
                            ForEach((0..<10), id: \.self) { index in
                                
                                HStack(alignment: .center) {
                                    Circle()
                                        .fill(Color.secondaryColor)
                                        .frame(width: 35, height: 35)
                                        .overlay{
                                            Image(systemName: "cart.fill")
                                                .foregroundColor(Color.bgColor)
                                        }
                                    VStack(alignment: .leading) {
                                        
                                        CustomText(text: "Shopping", size: .p1, color: .secondaryColor, bold: true)
                                        CustomText(text: "11 Jan 2022", size: .p2, color: .secondaryColor, bold: false)
                                    }.padding(.horizontal, 8)
                                    Spacer()
                                    
                                    if index % 2 == 0 {
                                        CustomText(text: "- MYR 20.00", size: .p1, color: .error, bold: true)
                                    } else {
                                        CustomText(text: "+ MYR 20.00", size: .p1, color: .success, bold: true)
                                    }
                                }
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(EdgeInsets(top: -120, leading: 0, bottom: 20, trailing: 0))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
        }
        //End Scroll View
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
//        WalletView()
        HomepageView()
            .environmentObject(ModalControl())
    }
}
