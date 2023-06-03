//
//  ProfileService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 03/06/2023.
//

import Foundation

class ProfileService: ObservableObject {
    
    let tokenManager = TokenManager()
    let authService = AuthService()

    func get(completion: @escaping (Result<ProfileResponse, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/profile")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().get(url: url, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(ProfileResponse.self, from: data)
                        completion(.success(res))
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
    
    func update(profileResponse: ProfileResponse, completion: @escaping (Result<ProfileResponse, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/profile")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        let body = ["fullName" : profileResponse.fullName, "preferredName" : profileResponse.preferredName]

        ApiClient().put(url: url, body: body, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(ProfileResponse.self, from: data)
                        completion(.success(res))
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
    
    func updatePassword(body: [String : String], completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        
        let sessionToken = tokenManager.getSessionToken()
        
        if (sessionToken == nil) {
            self.tokenManager.deleteTokens()
            completion(.failure(ErrorResponse(status: ErrorResponse.CommonResponse(code: 403, message: "Session ended."))))
            return
        }
        
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/profile/password")!
        
        // Decode the response
        let decoder = JSONDecoder()

        ApiClient().put(url: url, body: body, headers: ["Authorization": sessionToken!]) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
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
}

struct ProfileResponse: Decodable {
    let id: String
    let type: String
    let subtype: String
    var preferredName: String = ""
    var fullName: String = ""
    let email: String
    let userCreatedDate: String
    let status: String
    let dateCreated: String
    let dateUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case subtype
        case preferredName
        case fullName
        case email
        case userCreatedDate
        case status
        case dateCreated
        case dateUpdated
    }
    
    init() {
        id = ""
        type = ""
        subtype = ""
        preferredName = ""
        fullName = ""
        email = ""
        userCreatedDate = ""
        status = ""
        dateCreated = ""
        dateUpdated = ""
     }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Attempt to decode each property, ignoring missing keys
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.subtype = try container.decodeIfPresent(String.self, forKey: .subtype) ?? ""
        self.preferredName = try container.decodeIfPresent(String.self, forKey: .preferredName) ?? ""
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.userCreatedDate = try container.decodeIfPresent(String.self, forKey: .userCreatedDate) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated) ?? ""
        self.dateUpdated = try container.decodeIfPresent(String.self, forKey: .dateUpdated) ?? ""
    }
}
