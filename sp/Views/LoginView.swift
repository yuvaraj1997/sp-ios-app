//
//  LoginView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authModel: AuthModel
    
    @State private var emailAddress: String = "new_user_6@gmail.com"
    @State private var password: String = "Abc@123++"
    @State private var showInvalidCredentialModal: Bool = false
    
    @State private var isLoading: Bool = false
    
    func isFormComplete() -> Bool {
        return ("" == self.emailAddress || "" == self.password || !self.emailAddress.isValidEmail())
    }
    
    let authService = AuthService()
    
    func signIn(){
        self.isLoading.toggle()
        authService.signIn(emailAddress: self.emailAddress, password: self.password) { result in
            switch result {
            case .success(_):
                retriveSessionToken()
            case .failure(let error):
                var message = ""
                
                if (error.error != nil) {
                    if (error.additionalProperties != nil) {
                        for (key, value) in error.additionalProperties! {
                            message += "\(key) : \(value)\n"
                        }
                    } else {
                        message = error.error!.message
                    }
                }
                
                self.showInvalidCredentialModal.toggle()
                
                self.isLoading.toggle()
            }
        }
    }
    
    func retriveSessionToken() {
        authService.sessionToken() { result in
            switch result {
            case .success(_):
                self.isLoading.toggle()
                self.authModel.isAunthenticated.toggle()
            case .failure(let error):
                var message = ""
                
                if (error.error != nil) {
                    if (error.additionalProperties != nil) {
                        for (key, value) in error.additionalProperties! {
                            message += "\(key) : \(value)\n"
                        }
                    } else {
                        message = error.error!.message
                    }
                }
                
                self.showInvalidCredentialModal.toggle()
                
                self.isLoading.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationView {
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
                        isLoading: self.isLoading,
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
        }
        .preferredColorScheme(.dark)
        .overlay{
            CustomModal(
                title: "Invalid Credentials",
                description: "You entered an incorrect email address \nor password",
                type: .ALERT,
                decisionProceedAction: {
                    
                },
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
