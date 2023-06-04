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
    
    @Published var notificationModal = NotificationModal(show: false, title: "", message: "")
    
    func isAnyModalOpen() -> Bool {
        return self.showTransactionForm || self.showCreateWalletView || self.showPasswordChangeForm
    }
    
    func showModal(title: String, message: String) {
        self.notificationModal.title = title
        self.notificationModal.message = message
        self.notificationModal.show.toggle()
    }

    func showSuccessModal(message: String) {
        showModal(title: "Success", message: message)
    }
    
    func showErroModal(message: String) {
        showModal(title: "Error", message: message)
    }
}

struct NotificationModal {
    var show: Bool = false
    var title: String = ""
    var message: String = ""
}
