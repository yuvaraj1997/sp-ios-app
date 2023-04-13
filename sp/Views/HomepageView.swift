//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI
import Combine

struct HomepageView: View {
    
    enum FocusedField {
        case dec
    }
    
    @Environment(\.colorScheme) var colorScheme

    @State private var showDetails = false
    
    @State private var showPeriodSelection = false
    @State private var showTransactionForm = true
    @State private var showWalletSelection = false
    @State private var showCategorySelection = false
    @State private var showTransactionDateSelection = false
    @State private var isEditForm = false
    @FocusState private var focusedField: FocusedField?
    
    @State private var transactionAmount: String = ""
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    func didDismiss() {
        // Handle the dismissing action.
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
        }.overlay {
            ZStack {
                if (self.showTransactionForm) {
                    Color.bgColor.opacity(0.7).transition(.opacity).ignoresSafeArea()
                    VStack {
                        Spacer()
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
                            
                            //Wallet Selection
                            self.formInput(prependIcon: "creditcard", label: "Wallet", appendIcon: "chevron.right", onClickOpenModal: .WALLET_SELECTION)
                            //Category
                            self.formInput(prependIcon: "menucard", label: "Category", appendIcon: "chevron.right", onClickOpenModal: .CATEGORY_SELECTION)
                            //Calendar
                            self.formInput(prependIcon: "calendar", label: "Today", appendIcon: "", onClickOpenModal: .CALENDAR_SELECTION)
                            //Note
                            self.formInput(prependIcon: "pencil", label: "Write a note", appendIcon: "", onClickOpenModal: .CATEGORY_SELECTION)
                            
                            Spacer()
                            CustomButton(label: "Add Transaction", type: .primary, action: {})
                            
                        }
                        
                        .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 88) / 100, alignment: .topLeading)
                        .padding()
                        .background(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]).fill(Color.secondaryColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                    }
                    .transition(.move(edge: .bottom))
                    .ignoresSafeArea()
                }
            }
            .animation(.easeInOut(duration: 0.8), value: self.showTransactionForm)
        }
        .overlay {
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
                if (self.showCategorySelection) {
                    Color.secondaryColor.opacity(0.7).transition(.opacity).ignoresSafeArea()
                    VStack(spacing: 0) {
                        Rectangle().opacity(0.001).ignoresSafeArea()
                            .onTapGesture {
                                self.showCategorySelection.toggle()
                            }
                        VStack(alignment: .leading) {
                            CustomText(text: "Select Category", size: .h4, color: .secondaryColor)
                                .padding(.bottom, 10)

                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    LazyVGrid(columns: columns) {
                                        ForEach((1..<40), id: \.self) { index in
                                            VStack(alignment: .center) {
                                                Circle()
                                                    .fill(Color.secondaryColor)
                                                    .frame(width: 45, height: 45)
                                                    .overlay {
                                                        
                                                    Image(systemName: "creditcard")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.bgColor)
                                                    }
                                                CustomText(text: "Category \(index)", size: .p1, color: .secondaryColor)
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
                        .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.bgColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                    }
                    .transition(.move(edge: .bottom))
                    .ignoresSafeArea()
                }
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
            }.animation(.easeInOut(duration: 0.8), value: self.showWalletSelection || self.showCategorySelection || self.showTransactionDateSelection)
        }
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    func onSelectionPeriod(val: String) {
        print(val)
        self.showPeriodSelection = false
    }
    
    enum TransactionFormInputType {
        case WALLET_SELECTION
        case CATEGORY_SELECTION
        case CALENDAR_SELECTION
    }
    @State private var date = Date.now
    
    func formInput(prependIcon: String, label: String, appendIcon: String, onClickOpenModal: TransactionFormInputType) -> AnyView {
        return AnyView(
            HStack(alignment: .center) {
                Image(systemName: prependIcon)
                    .font(.system(size: 28))
                    .foregroundColor(.bgColor)
                    .frame(width: 50)
                CustomText(text: label, size: .p1, color: .bgColor, bold: true)
                    .padding(.horizontal, 8)
                Spacer()
                if appendIcon != "" {
                    Image(systemName: appendIcon)
                        .font(.system(size: 28))
                        .foregroundColor(.bgColor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
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
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
