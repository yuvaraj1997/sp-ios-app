//
//  ModalControl.swift
//  sp
//
//  Created by Yuvaraj Naidu on 16/04/2023.
//

import Foundation


class ModalControl: ObservableObject {
    
    @Published var showCreateWalletView = false
    @Published var showTransactionForm = false
    @Published var showPasswordChangeForm = false
    @Published var showPeriodSelection = false
    
    func isAnyModalOpen() -> Bool {
        return self.showTransactionForm || self.showCreateWalletView || self.showPasswordChangeForm
    }
    
}
