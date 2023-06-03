//
//  APIClient.swift
//  sp
//
//  Created by Yuvaraj Naidu on 30/05/2023.
//

import Foundation

class ApiClient {
    
    
    func post(url: URL, body: [String: Any], headers: [String: String]? = nil , completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (nil != headers) {
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = data
        } catch {
            completion(nil, nil, error)
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            completion(data, response, error)
        }

        task.resume()
    }
    
    func put(url: URL, body: [String: Any], headers: [String: String]? = nil , completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (nil != headers) {
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = data
        } catch {
            completion(nil, nil, error)
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            completion(data, response, error)
        }

        task.resume()
    }
    
    func get(url: URL, headers: [String: String]? = nil , completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if (nil != headers) {
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            completion(data, response, error)
        }

        task.resume()
    }
}
