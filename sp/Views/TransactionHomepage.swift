//
//  TransactionHomepage.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct TransactionHomepage: View {
    
    enum FocusedField {
        case dec
        case note
    }
    
    @Environment(\.colorScheme) var colorScheme

    @State private var showDetails = false
    
    @State private var showPeriodSelection = false
    
    //Transaction Form
    @State private var showTransactionForm = false
    @State private var showWalletSelection = false
    @State private var showCategorySelection = false
    @State private var showTransactionDateSelection = false
    @State private var date = Date.now
    
    @State private var isEditForm = false
    
    @FocusState private var focusedField: FocusedField?
    
    @State private var transactionAmount: String = ""
    @State private var note: String = "Write a note"
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
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
                    TextEditor(text: self.$note)
                        .focused($focusedField, equals: .note)
                        .scrollContentBackground(.hidden) // <- Hide it
                        .background(Color.secondaryColor) // To see this
                        .foregroundColor(.bgColor)
                        .onTapGesture {
                            if (self.note == "Write a note") {
                                self.note = ""
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
        NavigationView {
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
                            self.showTransactionForm.toggle()
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
        }
        .sheet(isPresented: self.$showPeriodSelection, onDismiss: didDismiss) {
            ZStack(alignment: .leading) {
                Color.accentColor.presentationDetents([.height(200)])
                PeriodSelectionView(buttonCallBack: self.onSelectionPeriod)
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: self.$showTransactionForm, onDismiss: didDismiss) {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.bgColor)
                            .bold()
                            .onTapGesture {
                                self.showTransactionForm.toggle()
                            }
                            .frame(width: 50)
                        Spacer()
                        CustomText(text: self.isEditForm ? "Edit" : "Add a transaction", size: .h4, color: .bgColor, bold: true)
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Image(systemName: self.isEditForm ? "trash.circle.fill" : "")
                            .foregroundColor(.bgColor)
                            .bold()
                            .onTapGesture {
                                if (self.isEditForm) {
                                    //                                            self.showTransactionForm.toggle()
                                    //Delete
                                }
                            }
                            .frame(width: 50)
                    }
                    
                    TextField("MYR 0", text: self.$transactionAmount, prompt: Text("MYR 0").foregroundColor(.accentColor))
                        .numbersOnly(self.$transactionAmount, includeDecimal: true)
                        .focused($focusedField, equals: .dec)
                        .bold()
                        .foregroundColor(.bgColor)
                        .font(.system(size: 32))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 40)
                        .toolbar {
                            ToolbarItem(placement: .keyboard){
                                Spacer()
                            }
                            ToolbarItem(placement: .keyboard) {
                                Button {
                                    self.focusedField = nil
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundColor(.secondaryColor)
                                }
                            }
                        }
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.bgColor)
                        .frame(maxWidth: 250)
                        .padding(.vertical, -40)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            
                            //Wallet Selection
                            self.formInput(prependIcon: "creditcard", label: "Wallet", appendIcon: "chevron.right", onClickOpenModal: .WALLET_SELECTION)
                            //Category
                            self.formInput(prependIcon: "menucard", label: "Category", appendIcon: "chevron.right", onClickOpenModal: .CATEGORY_SELECTION)
                            //Calendar
                            self.formInput(prependIcon: "calendar", label: "Today", appendIcon: "", onClickOpenModal: .CALENDAR_SELECTION)
                            //Note
                            self.formInput(prependIcon: "pencil", label: "Write a note", appendIcon: "", onClickOpenModal: .NOTE_INPUT)
                        }
                        
                    }
                    Spacer()
                    CustomButton(label: "Add Transaction", type: .primary, action: {})
                    
                }
                .padding()
                .background(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]).fill(Color.secondaryColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                
                .overlay {
                    TransactionWalletSelectionView(showWalletSelection: self.$showWalletSelection)
                    TransactionCategorySelectionView(showCategorySelection: self.$showCategorySelection)
                    TransactionDateSelectionView(showTransactionDateSelection:  self.$showTransactionDateSelection, date: self.$date)

                }
            }
            .presentationDetents([.height( (self.screenHeight * 75) / 100)])
            .ignoresSafeArea()
        }
    }
}

struct TransactionHomepage_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHomepage()
    }
}
