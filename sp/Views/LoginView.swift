//
//  LoginView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authModel: AuthModel
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var showInvalidCredentialModal: Bool = false
    
    func isFormComplete() -> Bool {
        return ("" == self.emailAddress || "" == self.password || !self.emailAddress.isValidEmail())
    }
    
    func signIn(){
//        self.showInvalidCredentialModal.toggle()
        self.authModel.isAunthenticated.toggle()
    }
    
    var body: some View {
        VStack() {
            //Heading
            VStack(spacing: 7) {
                //Title
                CustomText(text: "Welcome Back!",
                           size: .h2,
                           bold: true)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                //Sub
                CustomText(text: "Please sign in to your account",
                           size: .p1)
            }
            //Content
            VStack(spacing: 22) {
                //Email Address
                CustomField(type: .TEXT_FIELD, label: "Email Address", val: self.$emailAddress)
                
                //Password
                CustomField(type: .SECURE_FIELD, label: "Password", val: self.$password)
                
                
                //Forgot Password Link
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordView()) {
                        CustomText(text: "Forgot Password?", size: .p2, color: .secondaryColor)
                            .frame(alignment: .trailing)
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .padding(EdgeInsets(top: 130, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            //Ending
            VStack(spacing: 20) {
                CustomButton(
                    label: "Sign In",
                    type: .primary,
                    isDisabled: self.isFormComplete(),
                    action: {
                        self.signIn()
                    }
                )
                
                HStack(spacing: 4) {
                    CustomText(text: "Don’t have account?",
                               size: .p1,
                               color: .secondaryColor)
                    NavigationLink(destination: {
                        SignUpView()
                    }, label: {
                        CustomText(text: "Sign Up",
                                   size: .p1,
                                   color: .primaryColor)
                    })
                    
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .preferredColorScheme(.dark)
        .overlay{
            CustomModal(
                title: "Invalid Credentials",
                description: "You entered an incorrect email address \nor password",
                type: .ALERT,
                show: self.$showInvalidCredentialModal
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
//        LoginView()
        ContentView()
            .environmentObject(ModalControl())
            .environmentObject(AuthModel())
    }
}
