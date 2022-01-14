//
//  ConnectToBackend.swift
//  fefuactivity
//

//

import Foundation

class ConnectToBackend {
    static private let registerEndpoint: String = "https://fefu.t.feip.co/api/auth/register"
    static private let loginEndpoint: String = "https://fefu.t.feip.co/api/auth/login"
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    init() {
        ConnectToBackend.decoder.keyDecodingStrategy = .convertFromSnakeCase
        ConnectToBackend.encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    static func register(_ body: Data,
                         completion: @escaping ((AuthUserModel) -> Void),
                         onError :@escaping((ApiError) -> Void)) {
        
        guard let url = URL(string: registerEndpoint) else {
            print("Invalid URL")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "POST"
        urlReq.httpBody = body
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlReq) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let res = response as? HTTPURLResponse {
                switch res.statusCode {
                case 422:
                    do {
                        let errData = try ConnectToBackend.decoder.decode(ApiError.self, from: data)
                        onError(errData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                case 201:
                    do {
                        let userData = try ConnectToBackend.decoder.decode(AuthUserModel.self, from: data)
                        completion(userData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
    }
    
    static func login(_ body: Data,
                      completion: @escaping ((AuthUserModel) -> Void),
                      onError :@escaping((ApiError) -> Void)) {
        guard let url = URL(string: loginEndpoint) else {
            print("Invalid URL")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "POST"
        urlReq.httpBody = body
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlReq) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let res = response as? HTTPURLResponse {
                switch res.statusCode {
                case 422:
                    do {
                        let errData = try ConnectToBackend.decoder.decode(ApiError.self, from: data)
                        onError(errData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                case 200:
                    do {
                        let userData = try ConnectToBackend.decoder.decode(AuthUserModel.self, from: data)
                        completion(userData)
                        return
                    } catch let e {
                        print("Decode error: \(e)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
    }
}
