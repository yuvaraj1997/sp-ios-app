//
//  ProfileHomepage.swift
//  sp
//
//  Created by Yuvaraj Naidu on 13/04/2023.
//

import SwiftUI

struct ProfileHomepage: View {
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @State var profileHeightCalculator: Double = 0
    
    @EnvironmentObject var modalControl: ModalControl
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        VStack(spacing: 5) {
            Avatar(image: "profile_picture", width: 125, height: 125)
            CustomText(text: "Preffered Name", size: .h3, bold: true)
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                profileForm
                    .frame(minHeight: self.profileHeightCalculator)
            }
            .overlay(
                     GeometryReader { proxy in
                         Color.clear.onAppear {
                             self.profileHeightCalculator = proxy.size.height
                         }
                     }
                 )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .overlay {
            ProfilePasswordChangeView()
        }
        .preferredColorScheme(.dark)
    }
    
    var profileForm: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomText(text: "Personal Information", size: .p1, bold: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            //Email Address
            HStack(alignment: .center) {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.secondaryColor)
                CustomText(text: "Email Address", size: .p1, bold: true)
                    .frame(width: 140, alignment: .leading)
                Spacer()
                TextField("", text: .constant("yuvaraj.naidu@gmail.com"))
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryColor.opacity(0.6))
                    .multilineTextAlignment(.trailing)
                    .disabled(true)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .background(Color.black.opacity(0.5))
            
            //Preffered Name
            HStack(alignment: .center) {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(.secondaryColor)
                CustomText(text: "Preferred Name", size: .p1, bold: true)
                    .frame(width: 140, alignment: .leading)
                Spacer()
                TextField("", text: .constant("Name"))
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryColor)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .background(Color.black.opacity(0.5))
            
            //Full Name
            HStack(alignment: .center) {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.secondaryColor)
                CustomText(text: "Full Name", size: .p1, bold: true)
                    .frame(width: 140, alignment: .leading)
                Spacer()
                TextField("", text: .constant("Name"))
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryColor)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
            .background(Color.black.opacity(0.5))
            
            
            CustomText(text: "Security", size: .p1, bold: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            //Change Password
            HStack(alignment: .center) {
                Image(systemName: "lock.circle.fill")
                    .foregroundColor(.secondaryColor)
                CustomText(text: "Change Password", size: .p1, bold: true)
                    .frame(width: 140, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondaryColor)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.gray), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)
            .background(Color.black.opacity(0.5))
            .onTapGesture() {
                self.modalControl.showPasswordChangeForm.toggle()
            }
            Spacer()
            CustomButton(label: "Save Changes", type: .primary, action: {})
                .frame(width: self.screenWidth, height: 60)
                .padding(.vertical, 3)
            CustomButton(label: "Logout", type: .error, action: {
                self.authModel.isAunthenticated.toggle()
            })
            .frame(width: self.screenWidth, height: 60)
            .padding(.vertical, 3)
        }
    }
}

struct ProfileHomepage_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(ModalControl())
            .environmentObject(AuthModel())
    }
}
