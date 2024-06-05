//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    struct constant{
        static let appID : String = "a35e8ede10dd44a187ee71f0ca21f65a"
        static let appSecret : String = "d4981151aecc4626aeda7997508ef470"
        static let tokenAPIURL : String = "https://accounts.spotify.com/api/token"
        static let basicToken = constant.appID+":"+constant.appSecret
        static let scope = "user-read-private%20playlist-read-private%20playlist-modify-private%20playlist-modify-public%20user-follow-modify%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    private init(){}
    
    public var signInURL : URL? {
        let redirectURI = "https://samudeshi.github.io/"
        let string = "https://accounts.spotify.com/authorize?response_type=code&client_id=\(constant.appID)&scope=\(constant.scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn : Bool{
        return accessToken != nil
    }
    
    private var accessToken : String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken : String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpiratinDate : Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken : Bool{
        guard let date = tokenExpiratinDate else{
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMinutes) >= date
    }
    
    public func excahngeCodeForToken(code : String,completion: @escaping ((Bool) -> Void)){
        
        guard let url = URL(string: constant.tokenAPIURL) else{
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://samudeshi.github.io/")
        ]
        
        guard let base64String = constant.basicToken.data(using: .utf8)?.base64EncodedString() else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            
            do{
                //                let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments)
                //                print("Sucess \(json)")
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(authToken: result)
                completion(true)
                
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshAccessToken(completion: @escaping ((Bool) -> Void)){
        guard shouldRefreshToken else{
            completion(true)
            return
        }
        guard let url = URL(string: constant.tokenAPIURL) else{
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        guard let base64String = constant.basicToken.data(using: .utf8)?.base64EncodedString() else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            
            do{
                //                let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments)
                //                print("Sucess \(json)")
                
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Token is now Refreshed")
                self.cacheToken(authToken: result)
                completion(true)
                
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
    }
    
    private func cacheToken(authToken : AuthResponse){
        UserDefaults.standard.setValue(authToken.access_token, forKey: "access_token")
        if let refresh_token = authToken.refresh_token{
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(authToken.expires_in, forKey: "expire_in")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(authToken.expires_in)), forKey: "expirationDate")
    }
}
