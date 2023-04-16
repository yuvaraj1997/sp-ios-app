//
//  CreateWalletView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 14/04/2023.
//

import SwiftUI

struct CreateWalletView: View {
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @EnvironmentObject var modalControl: ModalControl
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @State private var name: String = ""
    @State private var initialBalance: String = ""
    
    func isFormComplete() -> Bool {
        return self.name == "" || self.initialBalance == ""
    }
    
    var body: some View {
        ZStack {
            if (self.modalControl.showCreateWalletView) {
                Color.secondaryColor.opacity(0.2).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack {

                        Rectangle().opacity(0.001).ignoresSafeArea()
                            .onTapGesture {
                                self.modalControl.showCreateWalletView.toggle()
                            }
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                CustomText(text: "Create a New Wallet", size: .h4, color: .secondaryColor)
                                Spacer()
                                Image(systemName: "xmark")
                                    .font(.system(size: 20))
                                    .foregroundColor(.secondaryColor)
                                    .onTapGesture {
                                        self.modalControl.showCreateWalletView.toggle()
                                    }
                            }
                            .padding(.bottom, 10)


                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .center, spacing: 20) {
                                    VStack(alignment: .leading) {
                                        CustomText(text: "Name", size: .p1, color: .secondaryColor)
                                        TextField("", text: self.$name)
                                            .font(.system(size: 13))
                                            .bold()
                                            .foregroundColor(.secondaryColor)
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color.secondaryColor)
                                        
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        CustomText(text: "Initial Balance", size: .p1, color: .secondaryColor)
                                        TextField("", text: self.$initialBalance)
                                            .numbersOnly(self.$initialBalance, includeDecimal: true)
                                            .font(.system(size: 13))
                                            .bold()
                                            .foregroundColor(.secondaryColor)
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color.secondaryColor)
                                        
                                    }
                                    Spacer()
                                    CustomButton(label: "Create a new wallet", type: .primary, isDisabled: self.isFormComplete(), action: {
                                        
                                        self.modalControl.showCreateWalletView.toggle()
                                    })
                                        .frame(height: 50)
                                }
                                .padding(.vertical, 10)
                            }
                        }
                        
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 40) / 100, alignment: .topLeading)
                        
                        .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.bgColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, keyboardHandler.keyboardHeight)
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }
        .animation(.easeInOut(duration: 0.8), value: self.modalControl.showCreateWalletView)
            .zIndex(4)
    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
//        CreateWalletView(showCreateWallet: .constant(true))
        
        HomepageView()
            .environmentObject(ModalControl())
    }
}
