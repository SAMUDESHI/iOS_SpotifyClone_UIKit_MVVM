//
//  APICallers.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

final class APICallers{
    static let shared = APICallers()
    
    private init(){}
    
    struct constant {
        static let baseAPIUrl = "https://api.spotify.com/v1"
    }
    
    private func decodeJsonResponse<T: Decodable>(data: Data,responseType: T.Type) -> T?{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
            return try decoder.decode(responseType, from: data)
        }catch let error{
            print("Parsing Failed \(error)")
        }
        return nil
    }
    
    public func getCurrentUserProfile(completionHandler:@escaping(Result<UserProfile,HUNetworkError>)->Void){
        let utility = HttpUtility.shared
        
        utility.authenticationToken = AuthManager.shared.accessToken
        let requestUrl = URL(string: constant.baseAPIUrl + "/me")
        
        utility.request(url: requestUrl!, method: .get, completionHandler: {
            (response) in
            
            switch response{
                
            case .success(let data):
                if let response = self.decodeJsonResponse(data: data as! Data, responseType: UserProfile.self){
                    completionHandler(.success(response))
                }else{
                    completionHandler(.failure(HUNetworkError(forRequestUrl: requestUrl!, errorMessage: "Unable To Parse Data", forStatusCode: 0)))
                }
                break
            
            case .failure(let err):
                completionHandler(.failure(err))
                break
            }
            
            
        })
    }
}
