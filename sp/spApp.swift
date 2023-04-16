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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modalControl)
        }
    }
}
