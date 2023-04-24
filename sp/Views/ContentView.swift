//
//  ContentView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 09/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var getStartedClicked: Bool = true
    
    
    @EnvironmentObject var authModel: AuthModel

    
    var body: some View {
        ZStack {
            if self.authModel.isAunthenticated {
                HomepageView()
                    
            } else {
                if !self.getStartedClicked {
                    GetStartedView(getStartedClicked: self.$getStartedClicked)
                } else {
                    LoginView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .keyboard){
                Spacer()
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    hideKeyboard()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .foregroundColor(.secondaryColor)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModalControl())
            .environmentObject(AuthModel())
    }
}
