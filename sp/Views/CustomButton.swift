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
    var action: (() -> Void) /// use closure for callback
    
    func isDisabledOpacityValue() -> Double {
        if (self.isDisabledValue() && !self.isNavigationButton) {
            return 0.6
        }
        return 1
    }
    
    func backgroundColor() -> Color {
        if (self.type == .primary) {
            return Color.primaryColor
        } else if (self.type == .secondary) {
            return Color.secondaryColor
        }
        return Color.error
    }
    
    func textForegroundColor() -> Color {
        if (self.type == .primary) {
            return Color.secondaryColor
        } else if (self.type == .secondary) {
            return Color.primaryColor
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
                    Text(self.label)
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(self.textForegroundColor())
                    
                }
            }
            .frame(maxWidth: 350, maxHeight: 60)
        }
        .disabled(self.isDisabledValue())
        .background(self.backgroundColor())
        .opacity(self.isDisabledOpacityValue())
        .cornerRadius(15)
    }
}

enum ButtonType {
  case primary
  case secondary
  case error
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(label: "Label",
                     type: .primary,
                     isDisabled: false,
                     isLoading: false,
                     isNavigationButton: false)
        {
            print("Clicked")
        }
    }
}
