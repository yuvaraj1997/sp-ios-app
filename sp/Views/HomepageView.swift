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
    
    @State private var selectedTab = 0
    
    private let screenWidth: Double = UIScreen.main.bounds.width
    private let screenHeight: Double = UIScreen.main.bounds.height
    
    @EnvironmentObject var modalControl: ModalControl
    

    init() {
    }
    
    func getColor(expectedModel: HomepageModels) -> Color {
        if (expectedModel == self.currModel) {
            return Color.white
        }
        return Color.white.opacity(0.4)
    }
    
    
    var body: some View {
        TabView(selection: self.$selectedTab) {
            TransactionHomepage()
                .transition(.move(edge: .leading))
                .gesture(DragGesture().onEnded { value in
                    let direction = self.detectDirection(value: value)

                    if direction == .right {
                        self.selectedTab = 1
                    }
                })
                 .tabItem {
                    Image(systemName: "house.fill")
                  }
                 .tag(0)
            
            ProfileHomepage()
                .transition(.move(edge: .trailing))
                .gesture(DragGesture().onEnded { value in
                    let direction = self.detectDirection(value: value)

                    if direction == .left {
                        self.selectedTab = 0
                    }
                })
                .tabItem {
                    Image(systemName: "person.circle.fill")
                }
                .tag(1)
        }
        .animation(.easeInOut(duration: 1), value: self.selectedTab) // 2
        .transition(.slide) // 3
        .overlay {
//            CreateWalletView()
//            TransactionFormView()
//            TransactionFrequencySelection()
            CustomModal(
                title: self.modalControl.notificationModal.title,
                description: self.modalControl.notificationModal.message,
                type: .ALERT,
                decisionProceedAction: {
                },
                show: self.$modalControl.notificationModal.show
            )
        }
        .sheet(isPresented: self.$modalControl.showCreateWalletView, content: {
            CreateWalletView()
                .frame(alignment: .topLeading)
                .preferredColorScheme(.dark)
                .presentationDetents([.height(350)])
        })
        .sheet(isPresented: self.$modalControl.showTransactionForm, content: {
            TransactionFormView()
                .preferredColorScheme(.dark)
                .presentationDetents([.height(700)])
        })
        .accentColor(.white)
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
            .environmentObject(WalletService())
            .environmentObject(CategoryService())
    }
}
