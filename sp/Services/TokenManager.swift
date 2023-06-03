//
//  TokenManager.swift
//  sp
//
//  Created by Yuvaraj Naidu on 31/05/2023.
//

import SwiftUI
import Security

class TokenManager {
    private let serviceIdentifier   = "com.yourapp.tokens"
    
    private let userId              = "userId"
    private let refreshTokenKey     = "refreshToken"
    private let sessionTokenKey     = "sessionToken"
    private let generationTimestamp = "generationTimestamp"
    private let timeToLiveInMs      = "timeToLiveInMs"
    private let generationDate      = "generationDate"
    
    func saveRefreshToken(_ token: TokenResponse) {
        saveToken(token.userId, forKey: userId)
        saveToken(token.token, forKey: refreshTokenKey)
        saveToken(String(token.generationTimestamp), forKey: refreshTokenKey + "_" + generationTimestamp)
        saveToken(String(token.timeToLiveInMs), forKey: refreshTokenKey + "_" + timeToLiveInMs)
        saveToken(token.generationDate, forKey: refreshTokenKey + "_" + generationDate)
    }
    
    func saveSessionToken(_ token: TokenResponse) {
        saveToken(token.userId, forKey: userId)
        saveToken(token.token, forKey: sessionTokenKey)
        saveToken(String(token.generationTimestamp), forKey: sessionTokenKey + "_" + generationTimestamp)
        saveToken(String(token.timeToLiveInMs), forKey: sessionTokenKey + "_" + timeToLiveInMs)
        saveToken(token.generationDate, forKey: sessionTokenKey + "_" + generationDate)
    }
    
    func getRefreshToken() -> String? {
        return validateAndReturnToken(key: refreshTokenKey)
    }
    
    func getSessionToken() -> String? {
        return validateAndReturnToken(key: sessionTokenKey)
    }
    
    func getUserId() -> String? {
        return getToken(forKey: userId)
    }
    
    func deleteTokens() {
        deleteToken(forKey: userId)
        deleteToken(forKey: refreshTokenKey)
        deleteToken(forKey: sessionTokenKey)
        deleteToken(forKey: refreshTokenKey + "_" + generationTimestamp)
        deleteToken(forKey: refreshTokenKey + "_" + timeToLiveInMs)
        deleteToken(forKey: refreshTokenKey + "_" + generationDate)
        deleteToken(forKey: sessionTokenKey + "_" + generationTimestamp)
        deleteToken(forKey: sessionTokenKey + "_" + timeToLiveInMs)
        deleteToken(forKey: sessionTokenKey + "_" + generationDate)
    }
    
    func isAvailable() -> Bool {
        
        if (nil != getRefreshToken()) {
            return true
        }
        
        if (nil != getSessionToken()) {
            return true
        }
        
        if (nil != getUserId()) {
            return true
        }
        
        return false
        
    }
    
    private func validateAndReturnToken(key: String) -> String? {
        let token = getToken(forKey: key)
        
        if (nil == token) {
            return nil
        }
        
        let timeToLiveInMs = getToken(forKey: key + "_" + timeToLiveInMs)
        
        if (nil == timeToLiveInMs) {
            return nil
        }
        
        if (timeToLiveInMs == "-1") {
            return token
        }
        
        let generationTimestamp = getToken(forKey: key + "_" + generationTimestamp)
        
        if (nil == generationTimestamp) {
            return nil
        }
        
        let expiryTimestamp = Int(generationTimestamp!)! + Int(timeToLiveInMs!)!
        
        if (expiryTimestamp < getCurrentTimestamp()) {
            return token
        }
        
        print("Refresh Token expired")
        return nil
    }
    
    private func saveToken(_ token: String, forKey key: String) {
        let data = token.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Failed to save token with key: \(key)")
        }
    }
    
    private func getToken(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    private func deleteToken(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("Failed to delete token with key: \(key)")
        }
    }
}

// Usage
//let tokenManager = TokenManager()
//tokenManager.saveRefreshToken("refresh_token")
//tokenManager.saveSessionToken("session_token")
//let refreshToken = tokenManager.getRefreshToken() // Retrieves the refresh token
//let sessionToken = tokenManager.getSessionToken() // Retrieves the session token
//tokenManager.deleteTokens() // Deletes both tokens from the Keychain


func getCurrentTimestamp() -> Int {
     let currentDate = Date()
     let timestamp = currentDate.timeIntervalSince1970
     
     return Int(timestamp)
 }
