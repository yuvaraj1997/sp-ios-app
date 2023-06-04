//
//  TransactionFormView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 16/04/2023.
//

import SwiftUI

struct TransactionFormView: View {
    
    
    @EnvironmentObject var modalControl: ModalControl
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    //Transaction Form
    @State private var showWalletSelection = false
    @State private var showCategorySelection = false
    @State private var showTransactionDateSelection = false
    @State private var date = Date.now
    
    @State private var selectedWallet:GetWalletResponse = GetWalletResponse()
    @State private var selectedCategory:DropdownOption = DropdownOption()
    
    @State private var isEditForm = false
    
    @State private var isLoading = false
    
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
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: self.date)
        let nowDateFormat = dateFormatter.string(from: Date.now)
        
        if (formattedDate == nowDateFormat) {
            return "Today"
        }
        
        return formattedDate
    }
    
    func isFormInomplete() -> Bool {
        if(self.transactionAmount == "") {
            return true
        }
        
        if (Double(self.transactionAmount)! == 0.0) {
            return true
        }
        
        if (self.selectedWallet.id == "") {
           return true
        }
        
        if (self.selectedCategory.value == "") {
           return true
        }
        
        return false
    }
    
    var body: some View {
        VStack(alignment: .center) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .bold()
                        .onTapGesture {
                            self.modalControl.showTransactionForm.toggle()
                        }
                        .frame(width: 50)
                    Spacer()
                    CustomText(text: self.isEditForm ? "Edit" : "Add a transaction", size: .h4, bold: true)
                        .frame(width: 250)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Image(systemName: self.isEditForm ? "trash.circle.fill" : "")
                        .foregroundColor(.white)
                        .bold()
                        .onTapGesture {
                            if (self.isEditForm) {
                                //                                            self.showTransactionForm.toggle()
                                //Delete
                            }
                        }
                        .frame(width: 50)
                }
                
                TextField("MYR 0", text: self.$transactionAmount, prompt: Text("MYR 0").foregroundColor(.white))
                    .numbersOnly(self.$transactionAmount, includeDecimal: true)
                    .focused($focusedField, equals: .dec)
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 40)
//                                .toolbar {
//                                    ToolbarItem(placement: .keyboard){
//                                        Spacer()
//                                    }
//                                    ToolbarItem(placement: .keyboard) {
//                                        Button {
//                                            self.focusedField = nil
//                                        } label: {
//                                            Image(systemName: "keyboard.chevron.compact.down")
//                                                .foregroundColor(.secondaryColor)
//                                        }
//                                    }
//                                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.white)
                    .frame(maxWidth: 250)
                    .padding(.vertical, -40)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        //Wallet Selection
                        self.formInput(prependIcon: "creditcard",
                                       label: self.selectedWallet.name != "" ? self.selectedWallet.name : "Select Wallet",
                                       appendIcon: "chevron.right", onClickOpenModal: .WALLET_SELECTION)
                        //Category
                        self.formInput(prependIcon: "menucard",
                                       label: self.selectedCategory.text != "" ? self.selectedCategory.text : "Select Category",
                                       appendIcon: "chevron.right", onClickOpenModal: .CATEGORY_SELECTION)
                        //Calendar
                        self.formInput(prependIcon: "calendar", label: getFormattedDate(), appendIcon: "", onClickOpenModal: .CALENDAR_SELECTION)
                        //Note
                        self.formInput(prependIcon: "pencil", label: "Write a note", appendIcon: "", onClickOpenModal: .NOTE_INPUT)
                        
                    }.padding(.bottom, keyboardHandler.keyboardHeight)
                }
                Spacer()
            CustomButton(label: "Add Transaction", type: .primary, isDisabled: isFormInomplete(), isLoading: self.isLoading, action: {})
                    .frame(height: 60)
        }
        .padding()
        .sheet(isPresented: self.$showWalletSelection, content: {
            TransactionWalletSelectionView(showWalletSelection: self.$showWalletSelection, selectedWallet: self.$selectedWallet)
                .preferredColorScheme(.dark)
                .presentationDetents([.height(300)])
        })
        .sheet(isPresented: self.$showCategorySelection, content: {
            TransactionCategorySelectionView(showCategorySelection: self.$showCategorySelection, selectedCategory: self.$selectedCategory)
                .preferredColorScheme(.dark)
                .presentationDetents([.height(300)])
        })
        .sheet(isPresented: self.$showTransactionDateSelection, content: {
            TransactionDateSelectionView(showTransactionDateSelection:  self.$showTransactionDateSelection, date: self.$date)
                .preferredColorScheme(.dark)
                .presentationDetents([.height(450)])
        })
//        ZStack {
//            if (self.modalControl.showTransactionForm) {
//                Color.bg_color.opacity(0.6).transition(.opacity).ignoresSafeArea()
//                VStack(spacing: 0) {
//                    Rectangle().opacity(0.001).ignoresSafeArea()
//                        .onTapGesture {
//                            self.modalControl.showTransactionForm.toggle()
//                        }
//                    VStack(alignment: .center) {
//                            HStack {
//                                Image(systemName: "xmark.circle.fill")
//                                    .foregroundColor(.white)
//                                    .bold()
//                                    .onTapGesture {
//                                        self.modalControl.showTransactionForm.toggle()
//                                    }
//                                    .frame(width: 50)
//                                Spacer()
//                                CustomText(text: self.isEditForm ? "Edit" : "Add a transaction", size: .h4, bold: true)
//                                    .frame(width: 250)
//                                    .multilineTextAlignment(.center)
//                                Spacer()
//                                Image(systemName: self.isEditForm ? "trash.circle.fill" : "")
//                                    .foregroundColor(.white)
//                                    .bold()
//                                    .onTapGesture {
//                                        if (self.isEditForm) {
//                                            //                                            self.showTransactionForm.toggle()
//                                            //Delete
//                                        }
//                                    }
//                                    .frame(width: 50)
//                            }
//
//                            TextField("MYR 0", text: self.$transactionAmount, prompt: Text("MYR 0").foregroundColor(.white))
//                                .numbersOnly(self.$transactionAmount, includeDecimal: true)
//                                .focused($focusedField, equals: .dec)
//                                .bold()
//                                .foregroundColor(.white)
//                                .font(.system(size: 32))
//                                .multilineTextAlignment(.center)
//                                .padding(.vertical, 40)
////                                .toolbar {
////                                    ToolbarItem(placement: .keyboard){
////                                        Spacer()
////                                    }
////                                    ToolbarItem(placement: .keyboard) {
////                                        Button {
////                                            self.focusedField = nil
////                                        } label: {
////                                            Image(systemName: "keyboard.chevron.compact.down")
////                                                .foregroundColor(.secondaryColor)
////                                        }
////                                    }
////                                }
//
//                            Divider()
//                                .frame(height: 1)
//                                .overlay(Color.white)
//                                .frame(maxWidth: 250)
//                                .padding(.vertical, -40)
//
//                            ScrollView(.vertical, showsIndicators: false) {
//                                VStack {
//
//                                    //Wallet Selection
//                                    self.formInput(prependIcon: "creditcard", label: "Wallet", appendIcon: "chevron.right", onClickOpenModal: .WALLET_SELECTION)
//                                    //Category
//                                    self.formInput(prependIcon: "menucard", label: "Category", appendIcon: "chevron.right", onClickOpenModal: .CATEGORY_SELECTION)
//                                    //Calendar
//                                    self.formInput(prependIcon: "calendar", label: "Today", appendIcon: "", onClickOpenModal: .CALENDAR_SELECTION)
//                                    //Note
//                                    self.formInput(prependIcon: "pencil", label: "Write a note", appendIcon: "", onClickOpenModal: .NOTE_INPUT)
//
//                                }.padding(.bottom, keyboardHandler.keyboardHeight)
//                            }
//                            Spacer()
//                            CustomButton(label: "Add Transaction", type: .primary, action: {})
//                                .frame(height: 60)
//                    }
//                    .padding()
//                    .background(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]).fill(Color.bg_color).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
//                    .frame(height: (self.screenHeight * 85) / 100, alignment: .topLeading)
//                    .overlay {
//                        TransactionWalletSelectionView(showWalletSelection: self.$showWalletSelection)
//                        TransactionCategorySelectionView(showCategorySelection: self.$showCategorySelection)
//                        TransactionDateSelectionView(showTransactionDateSelection:  self.$showTransactionDateSelection, date: self.$date)
//
//                    }
//                }
//                .transition(.move(edge: .bottom))
//                .ignoresSafeArea()
//            }
//        }.animation(.easeInOut(duration: 0.8), value: self.modalControl.showTransactionForm)
    }
    
    func formInput(prependIcon: String, label: String, appendIcon: String, onClickOpenModal: TransactionFormInputType) -> AnyView {
        return AnyView(
            HStack(alignment: .center) {
                Image(systemName: prependIcon)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 50)
                if onClickOpenModal == .NOTE_INPUT {
                    NavigationView {
                        TextEditor(text: self.$note)
                            .focused($focusedField, equals: .note)
                            .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                    HStack {
//                                        Button(action: {
//                                        }) { Text("").foregroundColor(.white) }
//                                        Spacer()
//                                        Button(action: {
//                                            if (self.note == "") {
//                                                self.note = "Write a note"
//                                            }
//                                            hideKeyboard()
//                                        }) { Text("Done").foregroundColor(.white) }
//                                    }
//                                }
                                ToolbarItem(placement: .keyboard){
                                    Spacer()
                                }
                                ToolbarItem(placement: .keyboard) {
                                    Button {
                                        if (self.note == "") {
                                            self.note = "Write a note"
                                        }
                                        hideKeyboard()
                                    } label: {
                                        Image(systemName: "keyboard.chevron.compact.down")
                                            .foregroundColor(.secondaryColor)
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden) // <- Hide it
                            .preferredColorScheme(.dark)
                            .autocorrectionDisabled()
                            .onTapGesture {
                                if (self.note == "Write a note") {
                                    self.note = ""
                                }
                            }
                    }
                } else {
                    CustomText(text: label, size: .p1, bold: true)
                        .padding(.horizontal, 8)
                }
                Spacer()
                if appendIcon != "" {
                    Image(systemName: appendIcon)
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
                .frame(maxWidth: .infinity, maxHeight: onClickOpenModal == .NOTE_INPUT ? 100 : 40, alignment: .leading)
            .padding(.vertical, 3)
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
}

struct TransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(WalletService())
            .environmentObject(CategoryService())
//        TransactionFormView(showWalletSelection: .constant(true))
    }
}
