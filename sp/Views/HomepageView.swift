//
//  HomepageView.swift
//  sp
//
//  Created by Yuvaraj Naidu on 10/04/2023.
//

import SwiftUI
import Combine

struct HomepageView: View {
    
    @State var currModel: HomepageModels = .TRANSACTION_HOME
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @EnvironmentObject var modalControl: ModalControl
    

    init() {
//        UITabBar.appearance().backgroundColor = UIColor(red: 0.84, green: 0.90, blue: 0.89, alpha: 1.00)
    }
    
    func getColor(expectedModel: HomepageModels) -> Color {
        if (expectedModel == self.currModel) {
            return Color.white
        }
        return Color.white.opacity(0.4)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            if self.currModel == .TRANSACTION_HOME {
                TransactionHomepage()
                    .transition(.move(edge: .leading))
                    .gesture(DragGesture().onEnded { value in
                        let direction = self.detectDirection(value: value)
                        
                        if direction == .right {
                            self.currModel = .PROFILE_PAGE
                        }
                    })
            } else {
                ProfileHomepage()
                    .transition(.move(edge: .trailing))
                    .gesture(DragGesture().onEnded { value in
                        let direction = self.detectDirection(value: value)
                        
                        if direction == .left {
                            self.currModel = .TRANSACTION_HOME
                        }
                    })
            }
            if (!self.modalControl.isAnyModalOpen()) {
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        VStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(self.getColor(expectedModel: .TRANSACTION_HOME))
                                .frame(width: 10, height: 10)
    //                        CustomText(text: "Home", size: .p1, color: self.getColor(expectedModel: .TRANSACTION_HOME), bold: true)
                        }
                        .onTapGesture {
                            self.currModel = .TRANSACTION_HOME
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(self.getColor(expectedModel: .PROFILE_PAGE))
                                .frame(width: 10, height: 10)
    //                        CustomText(text: "Profile", size: .p1, color: self.getColor(expectedModel: .PROFILE_PAGE), bold: true)
                        }
                        .onTapGesture {
                            self.currModel = .PROFILE_PAGE
                        }
                    }
                    .frame(maxWidth: 250)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.bg_color)
                
            }
        }
        .animation(.easeInOut(duration: 0.4), value: self.currModel)
        .preferredColorScheme(.dark)
    }
    
    enum HomepageModels{
        case TRANSACTION_HOME
        case PROFILE_PAGE
    }
    
    enum SwipeHVDirection: String {
        case left, right, up, down, none
    }

    func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
        if value.startLocation.x < value.location.x - 24 {
            return .left
        }
        if value.startLocation.x > value.location.x + 24 {
            return .right
        }
        if value.startLocation.y < value.location.y - 24 {
            return .down
        }
        if value.startLocation.y > value.location.y + 24 {
            return .up
        }
        return .none
    }
    
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
            .environmentObject(ModalControl())
    }
}
