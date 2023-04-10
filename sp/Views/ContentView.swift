//
//  ContentView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 09/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var getStartedClicked: Bool = false

    
    var body: some View {
        if !self.getStartedClicked {
            GetStartedView(getStartedClicked: self.$getStartedClicked)
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
