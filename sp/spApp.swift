//
//  spApp.swift
//  sp
//
//  Created by Yuvaraj Naidu on 09/04/2023.
//

import SwiftUI

@main
struct spApp: App {

    @StateObject var modalControl = ModalControl()
    @StateObject var authModel = AuthModel()
    @StateObject var walletService = WalletService()
    @StateObject var categoryService = CategoryService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modalControl)
                .environmentObject(authModel)
                .environmentObject(walletService)
                .environmentObject(categoryService)
        }
    }
}
