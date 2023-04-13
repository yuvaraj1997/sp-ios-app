//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI
import Combine

struct HomepageView: View {
    

    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.84, green: 0.90, blue: 0.89, alpha: 1.00)
    }
    
    
    var body: some View {
        TabView {
            TransactionHomepage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileHomepage()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .accentColor(.primaryColor)
    }
    
    
    
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
