//
//  ProfilePasswordChangeView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 14/04/2023.
//

import SwiftUI

struct ProfilePasswordChangeView: View {
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @Binding var showPasswordChange: Bool
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    
    func isFormComplete() -> Bool {
        
        return self.currentPassword == "" || self.newPassword == "" || self.confirmNewPassword == "" ||
        !self.isNewPasswordCorrect() || !self.isPasswordMatch()
    }
    
    var body: some View {
        ZStack {
            if (self.showPasswordChange) {
                Color.secondaryColor.opacity(0.7).transition(.opacity).ignoresSafeArea()
                VStack(spacing: 0) {
                    Rectangle().opacity(0.001).ignoresSafeArea()
                        .onTapGesture {
                            self.showPasswordChange.toggle()
                        }
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            CustomText(text: "Change Password", size: .h4, color: .secondaryColor)
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .foregroundColor(.secondaryColor)
                                .onTapGesture {
                                    self.showPasswordChange.toggle()
                                }
                        }
                        .padding(.bottom, 10)


                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .center, spacing: 20) {
                                VStack(alignment: .leading) {
                                    CustomText(text: "Current Password", size: .p1, color: .secondaryColor)
                                    SecureField("", text: self.$currentPassword)
                                        .font(.system(size: 13))
                                        .bold()
                                        .foregroundColor(.secondaryColor)
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color.secondaryColor)
                                    
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomText(text: "New Password", size: .p1, color: .secondaryColor)
                                    SecureField("", text: self.$newPassword)
                                        .font(.system(size: 13))
                                        .bold()
                                        .foregroundColor(.secondaryColor)
                                    Divider()
                                        .frame(height: 1)
                                        .background(self.isNewPasswordCorrect() ? Color.secondaryColor : Color.error)
                                    if !self.isNewPasswordCorrect() {
                                        CustomText(text: "-Length should be at least 8.\n-Should have Uppercase\n-Should have Lowercase\n-Should have special character allowed ($%!#&@)", size: .p1, color: .error)
                                    }
                                    
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomText(text: "Confirm New Password", size: .p1, color: .secondaryColor)
                                    SecureField("", text: self.$confirmNewPassword)
                                        .font(.system(size: 13))
                                        .bold()
                                        .foregroundColor(.secondaryColor)
                                    Divider()
                                        .frame(height: 1)
                                        .background(self.isPasswordMatch() ? Color.secondaryColor : Color.error)
                                    if !self.isPasswordMatch() {
                                        CustomText(text: "Password should match", size: .p1, color: .error)
                                    }
                                    
                                }
                                Spacer()
                                CustomButton(label: "Update Password", type: .primary, isDisabled: self.isFormComplete(), action: {
                                    
                                    self.showPasswordChange.toggle()
                                })
                                    .frame(height: 50)
                            }
                            .padding(.vertical, 10)
                        }
                    }

                    .frame(maxWidth: .infinity, maxHeight: (self.screenHeight * 60) / 100, alignment: .topLeading)
                    .padding()
                    .background(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]).fill(Color.bgColor).shadow(radius: 20, x: 0, y: 0).mask(Rectangle()))
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }.animation(.easeInOut(duration: 0.8), value: self.showPasswordChange)
    }
    
    func isNewPasswordCorrect() -> Bool {
        if self.newPassword == "" {
            return true
        }
        
        return self.newPassword.isPasswordValid()
    }
    
    func isPasswordMatch() -> Bool {
        if self.confirmNewPassword == "" || self.newPassword == "" {
            return true
        }
        
        return self.newPassword == self.confirmNewPassword
    }
}

struct ProfilePasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePasswordChangeView(showPasswordChange: .constant(true))
    }
}
