//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct HomepageView: View {
    
    
    init() {
         UITableView.appearance().backgroundColor = UIColor(.red)
     }
    
    @State private var showPeriodSelection = false
    
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
                
                VStack(spacing: 0) {
                    //Heading Card
                    HomepageHeadingView(showPeriodSelection: self.$showPeriodSelection)
                    
                    //Wallet
                    WalletView()
                   
                }
            }
        }
        .sheet(isPresented: self.$showPeriodSelection,
               onDismiss: didDismiss) {
            ZStack(alignment: .leading) {
                Color.accentColor.presentationDetents([.height(200)])
                PeriodSelectionView(buttonCallBack: self.onSelectionPeriod)
            }
            .ignoresSafeArea()
        }
    }
    
    func onSelectionPeriod(val: String) {
        print(val)
        self.showPeriodSelection = false
    }
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
