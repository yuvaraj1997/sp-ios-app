//
//  ForgotPasswordService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 31/05/2023.
//

import Foundation

class ForgotPasswordService {
    
    let FINANCIAL_MANAGEMENT_API = "http://localhost:8080"
    
    func initForgotPassword(emailAddress: String, completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/forgot-password")!
        
        let body = ["emailAddress" : emailAddress]
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
    
    func updatePassword(body: [String: Any], completion: @escaping (Result<Data?, ErrorResponse>) -> Void) {
        let url = URL(string: "\(Constants.FINANCIAL_MANAGEMENT_API)/v1/forgot-password/password")!
        
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
