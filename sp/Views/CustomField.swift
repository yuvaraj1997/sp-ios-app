//
//  CustomField.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct CustomField: View {
    
    var type: FieldType
    var label: String
    var isError: Bool = false
    var errorMessage: String = ""
    @Binding var val: String
    var hint: String = ""
    
    func renderField() -> some View {
        let prompt = Text(self.label).foregroundColor(.black)
        var view: AnyView = AnyView(TextField(self.label, text: self.$val, prompt: prompt).textCase(.none))
        
        if type == .SECURE_FIELD {
            view = AnyView(SecureField(self.label, text: self.$val, prompt: prompt).textCase(.none))
        }
        
        return view.padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(colorBackground()))
            .overlay {
                errorOverlayBorder()
            }
            .foregroundColor(textColor())
            .frame(height: 52)
            .disableAutocorrection(true)
    }
    
    func errorOverlayBorder() -> some View {
        var view: AnyView = AnyView(RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 2)
            .blur(radius: 4))
                            
        if self.isError {
            return view.foregroundColor(Color.error)
        }
        
        return view.foregroundColor(.white)
    }
    
    func colorBackground() -> Color {
        if self.isError {
            return Color.error
        }
        return Color.white
    }
    
    func textColor() -> Color {
        if self.isError {
            return Color.secondaryColor
        }
        return Color.black
    }
    
    var body: some View {
        VStack {
            self.renderField()
            
            if self.isError {
                CustomText(text: self.errorMessage, size: .p2, color: .error)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            }
            
            if self.hint != "" {
                CustomText(text: self.hint, size: .p2, color: .white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            }
            
        }
    }
}

enum FieldType {
    case TEXT_FIELD
    case SECURE_FIELD
}

struct CustomField_Previews: PreviewProvider {
    static var previews: some View {
        CustomField(
            type: .TEXT_FIELD,
            label: "Label",
            isError: false,
            errorMessage: "Error Message",
            val: .constant("1200,00"),
            hint: "test"
        )
        .preferredColorScheme(.dark)
    }
}
