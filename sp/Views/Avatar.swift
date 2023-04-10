//
//  Avatar.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct Avatar: View {
    
    var image: String
    
    var body: some View {
        Image(self.image)
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color.secondaryColor, lineWidth: 2)
            }
            .shadow(radius: 7)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(image: "profile_picture")
    }
}
