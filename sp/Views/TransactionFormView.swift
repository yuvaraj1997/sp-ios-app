//
//  TransactionFormView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 16/04/2023.
//

import SwiftUI

struct TransactionFormView: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @Binding var showWalletSelection: Bool
    
    //Transaction Form
    @State private var showTransactionForm = false
    @State private var tesSheetOverlay = false
    @State private var showCategorySelection = false
    @State private var showTransactionDateSelection = false
    @State private var date = Date.now
    
    @State private var isEditForm = false
    
    @FocusState private var focusedField: FocusedField?
    
    @State private var transactionAmount: String = ""
    @State private var note: String = "Write a note"
    
    enum FocusedField {
        case dec
        case note
    }
    
    @State private var showPeriodSelection = false
    
    func onSelectionPeriod(val: String) {
        print(val)
        self.showPeriodSelection = false
    }
    
    enum TransactionFormInputType {
        case WALLET_SELECTION
        case CATEGORY_SELECTION
        case CALENDAR_SELECTION
        case NOTE_INPUT
    }
    
    func formInput(prependIcon: String, label: String, appendIcon: String, onClickOpenModal: TransactionFormInputType) -> AnyView {
        return AnyView(
            HStack(alignment: .center) {
                Image(systemName: prependIcon)
                    .font(.system(size: 28))
                    .foregroundColor(.bgColor)
                    .frame(width: 50)
                if onClickOpenModal == .NOTE_INPUT {
                    NavigationView {
                        TextEditor(text: self.$note)
                            .focused($focusedField, equals: .note)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    HStack {
                                        Button(action: {
                                        }) { Text("").foregroundColor(.white) }
                                        Spacer()
                                        Button(action: {
                                            if (self.note == "") {
                                                self.note = "Write a note"
                                            }
                                            hideKeyboard()
                                        }) { Text("Done").foregroundColor(.white) }
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden) // <- Hide it
                            .background(Color.secondaryColor) // To see this
                            .foregroundColor(.bgColor)
                            .autocorrectionDisabled()
                            .onTapGesture {
                                if (self.note == "Write a note") {
                                    self.note = ""
                                }
                            }
                    }
                } else {
                    CustomText(text: label, size: .p1, color: .bgColor, bold: true)
                        .padding(.horizontal, 8)
                }
                Spacer()
                if appendIcon != "" {
                    Image(systemName: appendIcon)
                        .font(.system(size: 28))
                        .foregroundColor(.bgColor)
                }
            }
                .frame(maxWidth: .infinity, maxHeight: onClickOpenModal == .NOTE_INPUT ? 100 : 40, alignment: .leading)
            .padding(.vertical, 3)
            .background(Color.secondaryColor)
            .onTapGesture() {
                if (onClickOpenModal == .WALLET_SELECTION) {
                    self.showWalletSelection.toggle()
                }
                if (onClickOpenModal == .CATEGORY_SELECTION) {
                    self.showCategorySelection.toggle()
                }
                if (onClickOpenModal == .CALENDAR_SELECTION) {
                    self.showTransactionDateSelection.toggle()
                }
            }
        )
    }
    
    var body: some View {
        ZStack {
            if (self.showWalletSelection) {
                Color.secondaryColor.opacity(0.7).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    Rectangle().opacity(0.001).ignoresSafeArea()
                        .onTapGesture {
                            self.showWalletSelection.toggle()
                        }
                    VStack(alignment: .leading) {
                        CustomText(text: "Select Wallet", size: .h4, color: .secondaryColor)
                            .padding(.bottom, 10)


                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach((1..<10), id: \.self) { index in
                                    HStack(alignment: .center) {
                                        Image(systemName: "creditcard")
                                            .font(.system(size: 28))
                                            .foregroundColor(.secondaryColor)
                                            .frame(width: 50)
                                        CustomText(text: "Wallet \(index)", size: .p1, color: .secondaryColor)
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
                    .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.bgColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }.animation(.easeInOut(duration: 0.8), value: self.showWalletSelection)
    }
}

struct TransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFormView(showWalletSelection: .constant(true))
    }
}
