//
//  WalletView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 11/04/2023.
//

import SwiftUI

struct WalletView: View {
    
    @State private var index = 0
    
    @State private var isLoading: Bool = false
    
    @EnvironmentObject var modalControl: ModalControl
    @EnvironmentObject var walletService: WalletService
    
//    func renderWallets() {
//        self.isLoading.toggle()
//        walletService.getUserWallets() { result in
//            switch result {
//            case .success(let result):
//                self.wallets = result.wallets
//            case .failure(let error):
//                var message = ""
//
//                if (error.error != nil) {
//                    if (error.additionalProperties != nil) {
//                        for (key, value) in error.additionalProperties! {
//                            message += "\(key) : \(value)\n"
//                        }
//                    } else {
//                        message = error.error!.message
//                    }
//                }
//
////                self.showInvalidCredentialModal.toggle()
//
//                self.isLoading.toggle()
//            }
//        }
//    }
    
    var body: some View {
        ZStack {
            //Wallets & Transactions
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    //Wallets
                    VStack(alignment: .leading) {
                        if self.walletService.isLoading {
                            CustomText(text: "loading", size: .h2)
                        }
                        CustomText(text: "Wallets \(self.walletService.isLoading.description)", size: .p1, bold: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        Spacer()
                        VStack {
                            TabView(selection: $index) {
                                        ForEach((0..<self.walletService.wallets.count), id: \.self) { index in
                                             CardView(
                                                walletDetails: self.walletService.wallets[index],
                                                emptyCard: false,
                                                action: {
//                                                    print(self.walletService.wallets[index])
                                                })
                                         }
                                        CardView(emptyCard: true, action: {
                                            self.modalControl.showCreateWalletView.toggle()
                                        })
                                        .tag(self.walletService.wallets.count)
                                     }
                                     .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            
                            HStack(spacing: 2) {
                                ForEach((0..<self.walletService.wallets.count + 1), id: \.self) { index in
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
                            CustomText(text: "Transactions", size: .p1, bold: true)
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
                                        
                                        CustomText(text: "Shopping", size: .p1, bold: true)
                                        CustomText(text: "11 Jan 2022", size: .p2, bold: false)
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
        .onAppear {
//            renderWallets()
//            self.walletService.getUserWallets()
        }
        //End Scroll View
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
//        WalletView()
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(WalletService())
    }
}
