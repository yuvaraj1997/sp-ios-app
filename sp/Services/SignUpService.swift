//
//  SignUpService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 29/05/2023.
//

import Foundation

struct SignUpRequest: Codable {
    let fullName: String
    let emailAddress: String
    let password: String
}

struct SignUpResponse: Codable {
    let userId: String
    let status: String
    let dateCreated: String
    let dateUpdated: String
}

class SignUpService {
    
    let FINANCIAL_MANAGEMENT_API = "http://localhost:8080"
    
    func signUp(signUpRequest: SignUpRequest, completion: @escaping (Result<SignUpResponse, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/signup")!
        
        let body = ["fullName" : signUpRequest.fullName, "emailAddress" : signUpRequest.emailAddress, "password" : signUpRequest.password]
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: body) { data, response, error in
            if let data = data {
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        let res = try! decoder.decode(SignUpResponse.self, from: data)
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
    
    func resendVerification(userId: String, completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/signup/resend/verification")!
        
        let body = ["userId" : userId]
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: body) { data, response, error in
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
    
    func verifyCode(body: [String: Any], completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/signup/verify")!
        
        // Decode the response
        let decoder = JSONDecoder()
        
        ApiClient().post(url: url, body: body) { data, response, error in
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
