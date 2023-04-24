//
//  CustomModal.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI

struct CustomModal: View {
    
    var title: String
    var description: String
    var type: Type
    var alertText: String?
    var decisionCancelText: String?
    var decisionProceedText: String?
    var decisionProceedAction: Void?
    
    @Binding var show: Bool
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    var body: some View {
        if self.show {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all).opacity(0.65)
                
                VStack {
                    CustomText(text: self.title, size: .p1, bold: true)
                    Divider()
                    CustomText(text: self.description, size: .p2)
                        .multilineTextAlignment(.center)
                    Divider()
                    
                    if(self.type == .ALERT) {
                        CustomButton(
                            label: self.alertText ?? "Okay",
                            type: .primary,
                            textSize: .p1,
                            action: {
                                self.show.toggle()
                            }
                        )
                        .frame(width: 110, height: 28)
                    }
                    
                    if(self.type == .DECISION) {
                        HStack {
                            CustomButton(
                                label: self.decisionCancelText ?? "Cancel",
                                type: .secondary,
                                textSize: .p1,
                                action: {
                                    self.show.toggle()
                                }
                            )
                            .frame(width: 110, height: 28)
                            Spacer()
                            CustomButton(
                                label: self.decisionProceedText ?? "Okay",
                                type: .primary,
                                textSize: .p1,
                                action: {
                                    if (nil != decisionProceedAction) {
                                        decisionProceedAction
                                        return
                                    }
                                }
                            )
                            .frame(width: 110, height: 28)
                        }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
     
                }
                .padding()
                .background(Color.tx_head_view)
                .frame(width: screenWidth - 80)
                .cornerRadius(20) /// make the background rounded
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.tx_head_view, lineWidth: 2)
                )
            }
        }
    }
}

enum Type {
    case DECISION
    case ALERT
}

struct CustomModal_Previews: PreviewProvider {
    static var previews: some View {
        CustomModal(title: "Development",
                    description: "Description",
                    type: .DECISION,
                    show: .constant(true))
    }
}
