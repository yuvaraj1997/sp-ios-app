//
//  TransactionCategorySelectionView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionWalletSelectionView: View {
    
    @EnvironmentObject var walletService: WalletService
    @EnvironmentObject var modalControl: ModalControl

    @Binding var showWalletSelection: Bool
    @Binding var selectedWallet: GetWalletResponse
    
    var selectedValue: ()
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomText(text: "Select Wallet", size: .h4)
                .padding(.bottom, 10)

            if (self.walletService.wallets.count == 0) {
                CustomText(text: "Ohho. Wallet is empty. Click me to create new wallet.", size: .p1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        self.showWalletSelection.toggle()
                        self.modalControl.showTransactionForm.toggle()
                        self.modalControl.showCreateWalletView.toggle()
                    }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach((0..<self.walletService.wallets.count), id: \.self) { index in
                            HStack(alignment: .center) {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                    .frame(width: 50)
                                CustomText(text: self.walletService.wallets[index].name, size: .p1)
                            }
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                self.selectedWallet = self.walletService.wallets[index]
                                self.showWalletSelection.toggle()
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
        }
//        .background(.red)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct TransactionWalletSelectionView_Previews: PreviewProvider {
    static var previews: some View {
//        TransactionWalletSelectionView(showWalletSelection: .constant(true))
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(WalletService())
    }
}
