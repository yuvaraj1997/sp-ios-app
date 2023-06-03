//
//  TransactionFrequencySelection.swift
//  sp
//
//  Created by Yuvaraj Naidu on 25/04/2023.
//

import SwiftUI

struct TransactionFrequencySelection: View {
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @EnvironmentObject var modalControl: ModalControl

    var body: some View {
        ZStack {
            if (self.modalControl.showPeriodSelection) {
                Color.bg_color.opacity(0.6).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    Rectangle().opacity(0.001).ignoresSafeArea()
                        .onTapGesture {
                            self.modalControl.showPeriodSelection.toggle()
                        }
                    VStack(alignment: .leading) {
                        CustomText(text: "Select Frequency", size: .h4)
                            .padding(.bottom, 10)


                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                CustomText(text: "This Month", size: .p1)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    self.modalControl.showPeriodSelection.toggle()
                                }
                                CustomText(text: "Previous Month", size: .p1)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    self.modalControl.showPeriodSelection.toggle()
                                }
                                CustomText(text: "This Year", size: .p1)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    self.modalControl.showPeriodSelection.toggle()
                                }
                                CustomText(text: "Custom", size: .p1)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    self.modalControl.showPeriodSelection.toggle()
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
        }.animation(.easeInOut(duration: 0.8), value: self.modalControl.showPeriodSelection)
    }
}

struct TransactionFrequencySelection_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(ModalControl())
    }
}
