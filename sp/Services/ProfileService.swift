//
//  ProfileService.swift
//  sp
//
//  Created by Yuvaraj Naidu on 03/06/2023.
//

import Foundation

class ProfileService: ObservableObject {
    
    @Published var profileRes: ProfileResponse?
    
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
                        DispatchQueue.main.async {
                            self.profileRes = res
                        }
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
}

struct ProfileResponse: Codable {
    let id: String
    let type: String
    let subtype: String
    let fullName: String
    let email: String
    let userCreatedDate: String
    let status: String
    let dateCreated: String
    let dateUpdated: String
}
