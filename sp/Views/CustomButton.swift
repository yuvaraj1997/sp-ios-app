//
//  CustomButton.swift
//  sp
//
//  Created by Yuvaraj Naidu on 09/04/2023.
//

import SwiftUI

struct CustomButton: View {
    
    var label: String
    var type: ButtonType
    var isDisabled: Bool = false
    var isLoading: Bool = false
    var isNavigationButton: Bool = false
    var textSize: Size? = .h5
    var action: (() -> Void) /// use closure for callback
    
    func isDisabledOpacityValue() -> Double {
        if (self.isDisabledValue() && !self.isNavigationButton) {
            return 0.6
        }
        return 1
    }
    
    func backgroundColor() -> Color {
        if (self.type == .primary) {
            return Color.white
        } else if (self.type == .secondary) {
            return Color.black
        }
        return Color.error
    }
    
    func textForegroundColor() -> Color {
        if (self.type == .primary) {
            return Color.black
        } else if (self.type == .secondary) {
            return Color.white
        }
        return Color.secondaryColor
    }
    
    func isDisabledValue() -> Bool {
        if (self.isDisabled || self.isLoading || self.isNavigationButton) {
            return true
        }
        return false
    }
    
    var body: some View {
        Button(action: self.action) {
            ZStack {
                if self.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: self.textForegroundColor()))
                        .scaleEffect(1)
                } else {
                    CustomText(text: self.label, size: self.textSize!, color: self.textForegroundColor(), bold: true)
                    
                }
            }
            .frame(maxWidth: 350, maxHeight: 30)
        }
        .padding(12)
        .disabled(self.isDisabledValue())
        .background(self.backgroundColor())
        .opacity(self.isDisabledOpacityValue())
//        .tint(.indigo)
        .overlay{
            if (self.type == .secondary) {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(.white, lineWidth: 1)
            }
        }
        .cornerRadius(13)
    }
}

enum ButtonType {
  case primary
  case secondary
  case error
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(label: "Save changes",
                     type: .primary,
                     isDisabled: false,
                     isLoading: false,
                     isNavigationButton: false)
        {
            print("Clicked")
        }
        .preferredColorScheme(.dark)
    }
}
