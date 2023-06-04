//
//  WalletService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 03/06/2023.
//

import Foundation

class WalletService: ObservableObject {
    
    let tokenManager = TokenManager()
    let authService = AuthService()
    let authModel = AuthModel()
    
    @Published var wallets: [GetWalletResponse] = []
    @Published var isLoading = false

    func create(body: [String: Any], completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            self.authModel.isAunthenticated.toggle()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/wallet")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: body, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
//                        let res = try! decoder.decode(ProfileResponse.self, from: data)
                        completion(.success(data))
                        return
                    }
                }
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func update(body: [String: Any], completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/wallet")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().put(url: url, body: body, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
//                        let res = try! decoder.decode(ProfileResponse.self, from: data)
                        completion(.success(data))
                        return
                    }
                }
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func delete(walletId: String, completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/wallet/\(walletId)")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().delete(url: url, body: nil, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
//                        let res = try! decoder.decode(ProfileResponse.self, from: data)
                        completion(.success(data))
                        return
                    }
                }
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
                completion(.failure(errorRes))
                
            } else if let error = error {
                print(error)
                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
    
    func getUserWallets() {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
//            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/wallet/list")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().get(url: url, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(GetAllWalletResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.wallets = res.wallets
                        }
//                        print(res)
//                        completion(.success(res))
                        return
                    }
                }
                let errorRes = try! decoder.decode(ErrorResponse.self, from: data)
//                completion(.failure(errorRes))
                
            } else if let error = error {
                print(error)
//                completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 500, message: error.localizedDescription))))
            }
        }
    }
}


struct GetAllWalletResponse: Decodable {
    
    var wallets: [GetWalletResponse]
}

struct GetWalletResponse: Decodable {
    var id: String
    var name: String
    var initialBalance: Int
    var dateCreated: String
    var dateUpdated: String
    
    init() {
        id = ""
        name = ""
        initialBalance = 0
        dateCreated = ""
        dateUpdated = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case initialBalance
        case dateCreated
        case dateUpdated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Attempt to decode each property, ignoring missing keys
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.initialBalance = try container.decodeIfPresent(Int.self, forKey: .initialBalance) ?? 0
        self.dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated) ?? ""
        self.dateUpdated = try container.decodeIfPresent(String.self, forKey: .dateUpdated) ?? ""
    }
}
