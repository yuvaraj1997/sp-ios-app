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
                Color.primaryColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
            Color.bgColor.edgesIgnoringSafeArea([.bottom])
            
            
            VStack {
                Spacer()
                Circle()
                    .fill(Color.primaryColor)
                    .frame(width: 50, height: 50)
                    .overlay{
                        Image(systemName: "plus")
                            .foregroundColor(.secondaryColor)
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
        }
        .overlay {
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
