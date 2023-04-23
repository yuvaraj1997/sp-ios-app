//
//  TransactionCategorySelectionView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionWalletSelectionView: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @Binding var showWalletSelection: Bool
    
    var body: some View {
        ZStack {
            if (self.showWalletSelection) {
                Color.bg_color.opacity(0.6).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    Rectangle().opacity(0.001).ignoresSafeArea()
                        .onTapGesture {
                            self.showWalletSelection.toggle()
                        }
                    VStack(alignment: .leading) {
                        CustomText(text: "Select Wallet", size: .h4)
                            .padding(.bottom, 10)


                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach((1..<10), id: \.self) { index in
                                    HStack(alignment: .center) {
                                        Image(systemName: "creditcard")
                                            .font(.system(size: 28))
                                            .foregroundColor(.white)
                                            .frame(width: 50)
                                        CustomText(text: "Wallet \(index)", size: .p1)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onTapGesture {
                                        self.showWalletSelection.toggle()
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }

                    .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 30) / 100, alignment: .topLeading)
                    .padding()
                    .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.tx_head_view).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }.animation(.easeInOut(duration: 0.8), value: self.showWalletSelection)
    }
}

struct TransactionWalletSelectionView_Previews: PreviewProvider {
    static var previews: some View {
//        TransactionWalletSelectionView(showWalletSelection: .constant(true))
        HomepageView()
            .environmentObject(ModalControl())
    }
}
