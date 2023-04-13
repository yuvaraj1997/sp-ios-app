//
//  ProfileHomepage.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct ProfileHomepage: View {
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { reader in
                Color.bgColor
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
            Color.bgColor.edgesIgnoringSafeArea([.bottom])
            
            
                
//                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        Avatar(image: "profile_picture", width: 125, height: 125)
                        CustomText(text: "Preffered Name", size: .h3, color: .secondaryColor, bold: true)
                        
                        Group {
                            
                        }
                        
                        Spacer()
                        CustomButton(label: "Save Changes", type: .primary, action: {})
                        CustomButton(label: "Logout", type: .error, action: {})
                    }
                
//                }
        }
    }
}

struct ProfileHomepage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHomepage()
    }
}
