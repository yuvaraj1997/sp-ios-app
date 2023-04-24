//
//  SignUpView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var fullName: String = ""
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var verificationCode: String = ""
    
    @State private var errorModal: Bool = false
    
    @State private var signUpStep: SignUpStep = .INITIAL_STEP
    
    func isFormComplete() -> Bool {
        return ("" == self.fullName || "" == self.emailAddress ||
                "" == self.password || "" == self.confirmPassword ||
                !self.emailAddress.isValidEmail())
    }
    
    func signUp() {
//        self.errorModal.toggle()
//        self.navigationController?.pushViewController(verificationCodeView, animated: true)
        self.signUpStep = .VERIFICATION

    }
    
    func verify(){
        self.dismiss()
    }
    
    func dismiss(oneStepBack: Bool = false) {
        if (oneStepBack) {
            self.signUpStep = .INITIAL_STEP
            return;
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                if self.signUpStep == .INITIAL_STEP {
                    initialStepView
                }
                
                if (self.signUpStep == .VERIFICATION) {
                    verificationCodeView
                }
            }
        }
        .preferredColorScheme(.dark)
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
        VStack() {
            //Top Navigation Menu
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .onTapGesture(perform:  {
                        self.dismiss()
                    })
                Spacer()
            }
            //Heading
            VStack(spacing: 7) {
                //Title
                CustomText(text: "Create new account",
                           size: .h2,
                           bold: true)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                //Sub
                CustomText(text: "Please fill in the form to continue",
                           size: .p1)
            }
            //Content
            VStack(spacing: 22) {
                //Fullname
                CustomField(type: .TEXT_FIELD, label: "Full Name",
                            isError: self.fullName == "" ? false : !self.fullName.isValidFullname(),
                            errorMessage: self.fullName == "" || self.fullName.isValidFullname() ? "" : "Fullname is invalid",
                            val: self.$fullName)

                //Email Address
                CustomField(type: .TEXT_FIELD, label: "Email Address",
                            isError: self.emailAddress == "" ? false : !self.emailAddress.isValidEmail(),
                            errorMessage: self.emailAddress == "" || self.emailAddress.isValidEmail() ? "" : "Email is invalid",
                            val: self.$emailAddress)

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

            }
            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            //Ending
            VStack(spacing: 20) {
                CustomButton(
                    label: "Sign Up",
                    type: .primary,
                    isDisabled: self.isFormComplete(),
                    action: {
                        self.signUp()
                    }
                )

                HStack(spacing: 4) {
                    CustomText(text: "Have an account?",
                               size: .p1)
                    CustomText(text: "Sign In",
                               size: .p1,
                               color: .blue)
                    .onTapGesture(perform: {
                        self.presentationMode.wrappedValue.dismiss()
                    })

                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        
    }
    
    var verificationCodeView: some View {
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
                CustomText(text: "Verify Your Email",
                           size: .h2,
                           color: .secondaryColor,
                           bold: true)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                //Sub
                CustomText(text: "Verifcation code has been sent to your email",
                           size: .p1,
                           color: .secondaryColor)
            }
            //Content
            VStack {
                //Verification Code
                CustomField(type: .TEXT_FIELD, label: "Verification Code",
                            val: self.$verificationCode)

            }
            .padding(EdgeInsets(top: 250, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            //Ending
            VStack(spacing: 20) {
                VStack {
                    HStack(spacing: 4) {
                        CustomText(text: "Click",
                                   size: .p1)
                        CustomText(text: "here",
                                   size: .p1,
                                   color: .blue)
                        .onTapGesture(perform: {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                        CustomText(text: " to request new code.",
                                   size: .p1)
                    }
                    CustomText(text: "If not yet receive",
                               size: .p1)
                }
                CustomButton(
                    label: "Verify",
                    type: .primary,
                    isDisabled: self.verificationCode == "",
                    action: {
                        self.verify()
                    }
                )
                

            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

enum SignUpStep {
    case INITIAL_STEP
    case VERIFICATION
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
