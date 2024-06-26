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
    @Binding var selectedCategory: DropdownOption
    
    @EnvironmentObject var categoryService: CategoryService
    
    @State var currentTab: Int = 0
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                CustomText(text: "Select Category", size: .h4)
                    .padding(.bottom, 10)
                
                VStack{
                    TabBarView(currentTab: self.$currentTab, tabBarOptions: self.categoryService.types)
                    TabView(selection: self.$currentTab) {
                        ForEach((0..<self.categoryService.types.count), id: \.self) { index in
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    LazyVGrid(columns: columns) {
                                        ForEach((0..<(self.categoryService.options[self.categoryService.types[index]]?.count ?? 0)), id: \.self) { idx in
                                            VStack(alignment: .center) {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 45, height: 45)
                                                    .overlay {

                                                    Image(systemName: "creditcard")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.bgColor)
                                                    }
                                                CustomText(text: self.categoryService.options[self.categoryService.types[index]]![idx].text, size: .p2)
                                            }
                                            .padding(.vertical, 5)
                                            .onTapGesture {
                                                self.selectedCategory = self.categoryService.options[self.categoryService.types[index]]![idx]
                                                self.showCategorySelection.toggle()
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                            .tag(index)
                        }
                    }
                }

                
            }
            .padding()
        }
//        ZStack {
//            if (self.showCategorySelection) {
//                Color.bg_color.opacity(0.6).transition(.opacity).ignoresSafeArea()
//                VStack(spacing: 0) {
//                    Rectangle().opacity(0.001).ignoresSafeArea()
//                        .onTapGesture {
//                            self.showCategorySelection.toggle()
//                        }
//                    VStack(alignment: .leading) {
//                        CustomText(text: "Select Category", size: .h4)
//                            .padding(.bottom, 10)
//
//                        ScrollView(.vertical, showsIndicators: false) {
//                            VStack {
//                                LazyVGrid(columns: columns) {
//                                    ForEach((1..<40), id: \.self) { index in
//                                        VStack(alignment: .center) {
//                                            Circle()
//                                                .fill(Color.white)
//                                                .frame(width: 45, height: 45)
//                                                .overlay {
//
//                                                Image(systemName: "creditcard")
//                                                    .font(.system(size: 20))
//                                                    .foregroundColor(.bgColor)
//                                                }
//                                            CustomText(text: "Category \(index)", size: .p1)
//                                        }
//                                        .padding(.vertical, 5)
//                                        .onTapGesture {
//                                            self.showCategorySelection.toggle()
//                                        }
//                                    }
//                                }
//                            }
//                            .padding(.vertical, 10)
//                        }
//                    }
//
//                    .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 30) / 100, alignment: .topLeading)
//                    .padding()
//                    .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.tx_head_view).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
//                }
//                .transition(.move(edge: .bottom))
//                .ignoresSafeArea()
//            }
//        }.animation(.easeInOut(duration: 0.8), value: self.showCategorySelection)
    }
}

struct TabBarView: View {
    
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["1", "2"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)),
                        id: \.0,
                        content: {
                            index, name in
                    TabBarItem(currentTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index)
                        }
                )
            }
        }
        .foregroundColor(.white)
        .frame(height: 30)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                    .font(.system(size: 14))
                if currentTab == tab {
                    Color.gray.frame(height: 1)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(height: 1)
                    
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
    }
}

struct TransactionCategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
//        TransactionCategorySelectionView(showCategorySelection: .constant(true))
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(WalletService())
            .environmentObject(CategoryService())
    }
}
