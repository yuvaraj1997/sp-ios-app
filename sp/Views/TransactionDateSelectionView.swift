//
//  TransactionDateSelectionView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionDateSelectionView: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @Binding var showTransactionDateSelection: Bool
    @Binding var date: Date
    
    var body: some View {
            ZStack {
                if (self.showTransactionDateSelection) {
                    Color.secondaryColor.opacity(0.7).transition(.opacity).ignoresSafeArea()
                    VStack(spacing: 0) {
                        Rectangle().opacity(0.001).ignoresSafeArea()
                            .onTapGesture {
                                self.showTransactionDateSelection.toggle()
                            }
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                CustomText(text: "Select Transaction Date", size: .h4, color: .secondaryColor)
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondaryColor)
                                    .onTapGesture {
                                        self.showTransactionDateSelection.toggle()
                                    }
                            }

                            DatePicker(
                                "Start Date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .accentColor(.primaryColor)
                        }
                        .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 50) / 100, alignment: .topLeading)
                        .padding()
                        .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.bgColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                    }
                    .transition(.move(edge: .bottom))
                    .ignoresSafeArea()
                }
            }.animation(.easeInOut(duration: 0.8), value: self.showTransactionDateSelection)
    }
}

struct TransactionDateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDateSelectionView(showTransactionDateSelection: .constant(true), date: .constant(Date.now))
    }
}
