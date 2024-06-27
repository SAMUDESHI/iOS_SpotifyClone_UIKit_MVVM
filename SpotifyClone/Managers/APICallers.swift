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
    
    public func getNewReleases(completionHandler:@escaping(Result<NewReleases,HUNetworkError>)->Void){
        let utility = HttpUtility.shared
        
        utility.authenticationToken = AuthManager.shared.accessToken
        let requestUrl = URL(string: constant.baseAPIUrl + "/browse/new-releases")
        
        utility.request(url: requestUrl!, method: .get, completionHandler: {
            (response) in
            
            switch response{
                
            case .success(let data):
                if let response = self.decodeJsonResponse(data: data as! Data, responseType: NewReleases.self){
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
    
    public func getFeaturedPlaylist(completionHandler:@escaping(Result<FeaturedPlaylist,HUNetworkError>)->Void){
        let utility = HttpUtility.shared
        
        utility.authenticationToken = AuthManager.shared.accessToken
        let requestUrl = URL(string: constant.baseAPIUrl + "/browse/featured-playlists?locale=in_hi&limit=3")
        
        utility.request(url: requestUrl!, method: .get, completionHandler: {
            (response) in
            
            switch response{
                
            case .success(let data):
                if let response = self.decodeJsonResponse(data: data as! Data, responseType: FeaturedPlaylist.self){
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
    
    
    public func getRecommendations(genres : String,completionHandler:@escaping(Result<Recommendation,HUNetworkError>)->Void){
        let utility = HttpUtility.shared
        
        utility.authenticationToken = AuthManager.shared.accessToken
        let requestUrl = URL(string: constant.baseAPIUrl + "/recommendations?limit=40&seed_genres=\(genres)")
        
        utility.request(url: requestUrl!, method: .get, completionHandler: {
            (response) in
            
            switch response{
                
            case .success(let data):
//                print("data is \(String(data: data as! Data, encoding: .utf8))")
                if let response = self.decodeJsonResponse(data: data as! Data, responseType: Recommendation.self){
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
    
    public func getRecommendationsGenres(completionHandler:@escaping(Result<Genres,HUNetworkError>)->Void){
        let utility = HttpUtility.shared
        
        utility.authenticationToken = AuthManager.shared.accessToken
        let requestUrl = URL(string: constant.baseAPIUrl + "/recommendations/available-genre-seeds")
        
        utility.request(url: requestUrl!, method: .get, completionHandler: {
            (response) in
            
            switch response{
                
            case .success(let data):
                if let response = self.decodeJsonResponse(data: data as! Data, responseType: Genres.self){
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
