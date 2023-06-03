//
//  AuthService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 31/05/2023.
//

import Foundation
import Network
import UIKit

struct TokenResponse: Decodable {
    let userId: String
    let token: String
    let generationTimestamp: Int
    let timeToLiveInMs: Int
    let generationDate: String
}

class AuthService {
    
    
    
    let tokenManager = TokenManager()
    
    func signIn(emailAddress: String, password: String, completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/api/user/login")!
        
        let body = ["emailAddress" : emailAddress, "password": password, "deviceType": getDeviceName(), "ipAddress": "127.0.0.1"]
        
        print(body)
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: body) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(TokenResponse.self, from: data)
                        self.tokenManager.saveRefreshToken(res)
                        completion(.success(data))
                        return
                    }
                }
                self.tokenManager.deleteTokens()
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                self.tokenManager.deleteTokens()
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func sessionToken(completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let userId = tokenManager.getUserId()
        let refreshToken = tokenManager.getRefreshToken()
        
        if (nil == userId || nil == refreshToken) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/api/user/session?userId=\(userId!)")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: [:], headers: ["Authorization": refreshToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(TokenResponse.self, from: data)
                        self.tokenManager.saveSessionToken(res)
                        completion(.success(data))
                        return
                    }
                }
                self.tokenManager.deleteTokens()
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                self.tokenManager.deleteTokens()
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/api/user/logout")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: [:], headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        self.tokenManager.deleteTokens()
                        completion(.success(data))
                        return
                    }
                }
                self.tokenManager.deleteTokens()
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                self.tokenManager.deleteTokens()
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func getDeviceName() -> String {
        return getDeviceModel() + " " + getSystemName() + " " + getSystemVersion()
    }
    
    
       func getSystemName() -> String {
           return UIDevice.current.systemName
       }
       
       func getSystemVersion() -> String {
           return UIDevice.current.systemVersion
       }
       
       func getDeviceModel() -> String {
           return UIDevice.current.model
       }
    
//    func getIPAddress() -> String {
//        var ipAddressInput: String = "";
//        let monitor = NWPathMonitor()
//        let queue = DispatchQueue(label: "Monitor")
//
//        monitor.start(queue: queue)
//
//        monitor.pathUpdateHandler = { path in
//            if let interface = path.availableInterfaces.first(where: { $0.type == .wifi || $0.type == .wiredEthernet }),
//               let endpoint = interface.name.first {
//                DispatchQueue.main.async {
//                    print(endpoint)
//                }
//            } else {
//                DispatchQueue.main.async {
////                    self.ipAddress = "Unknown"
//                }
//            }
//        }
//        return ipAddressInput
//    }
    
}
