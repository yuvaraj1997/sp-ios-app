//
//  ForgotPasswordView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var verificationCode: String = ""
    
    @State private var errorModal: Bool = false
    
    @State private var forgotPasswordStep: ForgotPasswordStep = .INITIAL_STEP
    
    func isFormComplete() -> Bool {
        return ("" == self.password ||
                "" == self.confirmPassword ||
                "" == self.verificationCode)
    }
    
    func submit(){
        self.forgotPasswordStep = .VERIFICATION
    }
    
    func reset(){
        dismiss()
    }
    
    func dismiss(oneStepBack: Bool = false) {
        if (oneStepBack) {
            self.forgotPasswordStep = .INITIAL_STEP
            return;
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                if self.forgotPasswordStep == .INITIAL_STEP {
                    initialStepView
                }
                
                if (self.forgotPasswordStep == .VERIFICATION) {
                    verificationCodeView
                }
            }
        }
        .overlay{
            CustomModal(
                title: "Email already exist",
                description: "If you happen to forgot password, please proceed to do forgot password.",
                type: .ALERT,
                show: self.$errorModal
            )
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var initialStepView: some View {
            ZStack {
                Color.accentColor.edgesIgnoringSafeArea(.all)
                
                VStack() {
                    //Top Navigation Menu
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.secondaryColor)
                            .onTapGesture(perform:  {
                                self.dismiss()
                            })
                        Spacer()
                    }
                    //Heading
                    VStack(spacing: 7) {
                        //Title
                        CustomText(text: "Forgot Password?",
                                   size: .h2,
                                   color: .secondaryColor,
                                   bold: true)
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        //Sub
                        CustomText(text: "Don’t worry! It happens. Please enter the address \nassociated with your account.",
                                   size: .p1,
                                   color: .secondaryColor)
                        .multilineTextAlignment(.center)
                    }
                    //Content
                    VStack {
                        
                        //Email Address
                        CustomField(type: .TEXT_FIELD, label: "Email Address",
                                    isError: self.emailAddress == "" ? false : !self.emailAddress.isValidEmail(),
                                    errorMessage: self.emailAddress == "" || self.emailAddress.isValidEmail() ? "" : "Email is invalid",
                                    val: self.$emailAddress)

                    }
                    .padding(EdgeInsets(top: 250, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    //Ending
                    VStack(spacing: 20) {
                        CustomButton(
                            label: "Submit",
                            type: .primary,
                            isDisabled: self.emailAddress == "" || !self.emailAddress.isValidEmail(),
                            action: {
                                self.submit()
                            }
                        )
                        
  
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            }
        }
    
    var verificationCodeView: some View {
            ZStack {
                Color.accentColor.edgesIgnoringSafeArea(.all)

                VStack() {
                    //Top Navigation Menu
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.secondaryColor)
                            .onTapGesture(perform:  {
                                self.dismiss(oneStepBack: true)
                            })
                        Spacer()
                    }
                    //Heading
                    VStack(spacing: 7) {
                        //Title
                        CustomText(text: "Reset Password",
                                   size: .h2,
                                   color: .secondaryColor,
                                   bold: true)
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        //Sub
                        CustomText(text: "Verification code has been sent to your email.\nPlease fill in the form to reset password.",
                                   size: .p1,
                                   color: .secondaryColor)
                        .multilineTextAlignment(.center)
                    }
                    //Content
                    VStack(spacing: 22) {


                        //Password
                        CustomField(type: .SECURE_FIELD, label: "Password",
                                    isError: self.password == "" ? false : !self.password.isPasswordValid(),
                                    errorMessage: self.password == "" || self.password.isPasswordValid() ? "" : "Password is invalid",
                                    val: self.$password,
                                    hint: "-Length should be at least 8.\n-Should have Uppercase\n-Should have Lowercase\n-Should have special character allowed ($%!#&@)")

                        //Password
                        CustomField(type: .SECURE_FIELD, label: "Confirm Password",
                                    isError: self.password == "" || self.confirmPassword == "" || !self.password.isPasswordValid() ? false :
                                        self.password != self.confirmPassword,
                                    errorMessage: self.password == "" || self.confirmPassword == "" || !self.password.isPasswordValid() ? "" : "Password should match",
                                    val: self.$confirmPassword)
                        
                        //Verification Code
                        CustomField(type: .TEXT_FIELD, label: "Verification Code",
                                    val: self.$verificationCode)

                    }
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    //Ending
                    VStack(spacing: 20){
                        VStack {
                            HStack(spacing: 4) {
                                CustomText(text: "Click",
                                           size: .p1,
                                           color: .secondaryColor)
                                CustomText(text: "here",
                                           size: .p1,
                                           color: .primaryColor)
                                .onTapGesture(perform: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                CustomText(text: " to request new code.",
                                           size: .p1,
                                           color: .secondaryColor)
                            }
                            CustomText(text: "If not yet receive",
                                       size: .p1,
                                       color: .secondaryColor)
                        }
                        CustomButton(
                            label: "Reset",
                            type: .primary,
                            isDisabled: self.isFormComplete(),
                            action: {
                                self.reset()
                            }
                        )
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            }
        
    }
}

enum ForgotPasswordStep {
    case INITIAL_STEP
    case VERIFICATION
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
