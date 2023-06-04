//
//  CreateWalletView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 14/04/2023.
//

import SwiftUI

struct CreateWalletView: View {
    
    @EnvironmentObject var modalControl: ModalControl
    @EnvironmentObject var walletService: WalletService
    
    @State private var name: String = ""
    @State private var initialBalance: String = ""
    
    @State private var isLoading: Bool = false
    @State private var errorMessages: String = ""
    
    func isFormComplete() -> Bool {
        return self.name == "" || self.initialBalance == ""
    }
    
    func create() {
        self.errorMessages = ""
        self.isLoading.toggle()
        let val = Int(Double(self.initialBalance)! * 100)
        walletService.create(body: ["name": self.name, "initialBalance": val]) { result in
            switch result {
            case .success(_):
                self.isLoading.toggle()
                DispatchQueue.main.async {
                    self.modalControl.showCreateWalletView.toggle()
                    self.walletService.getUserWallets()
                    self.modalControl.showSuccessModal(message: "Successfully created wallet")
                }
            case .failure(let error):
                var message = ""
                
                if (error.error != nil) {
                    if (error.additionalProperties != nil) {
                        message = ""
                        for (key, value) in error.additionalProperties! {
                            message += "\(key) : \(value)\n"
                        }
                    } else {
                        message = error.error!.message
                    }
                }
                self.errorMessages = message
                self.isLoading.toggle()
            }
        }
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    CustomText(text: "Create a New Wallet", size: .h4)
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
                            CustomText(text: "Name", size: .p1)
                            TextField("", text: self.$name)
                                .font(.system(size: 13))
                                .bold()
                                .foregroundColor(.secondaryColor)
                            Divider()
                                .frame(height: 1)
                                .background(Color.secondaryColor)
                            
                        }
                        
                        VStack(alignment: .leading) {
                            CustomText(text: "Initial Balance", size: .p1)
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
                        CustomText(text: self.errorMessages, size: .p2, color: .error)
                        CustomButton(label: "Create a new wallet", type: .primary, isDisabled: self.isFormComplete(),
                                     isLoading: self.isLoading,
                                     action: {
                            
                            create()
                        })
                            .frame(height: 50)
                    }
                    .padding(.vertical, 10)
                }
            }
            .padding()
    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
//        CreateWalletView(showCreateWallet: .constant(true))
        
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(WalletService())
    }
}
