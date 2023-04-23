//
//  TransactionHomepage.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionHomepage: View {
    
    @EnvironmentObject var modalControl: ModalControl
    
    @State private var showPeriodSelection = false
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { reader in
                Color.tx_head_view
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
            Color.bg_color.opacity(0.8).edgesIgnoringSafeArea([.bottom])
            
            
            VStack {
                Spacer()
                Circle()
                    .fill(Color.tx_head_view)
                    .frame(width: 50, height: 50)
                    .overlay{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        self.modalControl.showTransactionForm.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .padding()
            .zIndex(1)
            
            VStack(spacing: 0) {
                //Heading Card
                HomepageHeadingView(showPeriodSelection: self.$showPeriodSelection)
                
                //Wallet
                WalletView()
                
            }
        }.overlay {
            CreateWalletView()
            TransactionFormView()
        }
    }
}

struct TransactionHomepage_Previews: PreviewProvider {
    static var previews: some View {
//        TransactionHomepage()
        HomepageView()
            .environmentObject(ModalControl())
    }
}
