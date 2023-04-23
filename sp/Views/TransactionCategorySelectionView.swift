//
//  TransactionCategorySelectionView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionCategorySelectionView: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @Binding var showCategorySelection: Bool
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            if (self.showCategorySelection) {
                Color.bg_color.opacity(0.6).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    Rectangle().opacity(0.001).ignoresSafeArea()
                        .onTapGesture {
                            self.showCategorySelection.toggle()
                        }
                    VStack(alignment: .leading) {
                        CustomText(text: "Select Category", size: .h4)
                            .padding(.bottom, 10)

                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                LazyVGrid(columns: columns) {
                                    ForEach((1..<40), id: \.self) { index in
                                        VStack(alignment: .center) {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 45, height: 45)
                                                .overlay {

                                                Image(systemName: "creditcard")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.bgColor)
                                                }
                                            CustomText(text: "Category \(index)", size: .p1)
                                        }
                                        .padding(.vertical, 5)
                                        .onTapGesture {
                                            self.showCategorySelection.toggle()
                                        }
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
        }.animation(.easeInOut(duration: 0.8), value: self.showCategorySelection)
    }
}

struct TransactionCategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
//        TransactionCategorySelectionView(showCategorySelection: .constant(true))
        HomepageView()
            .environmentObject(ModalControl())
    }
}
