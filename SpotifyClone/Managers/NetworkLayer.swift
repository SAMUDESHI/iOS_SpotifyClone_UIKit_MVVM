//
//  NetworkLayer.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 07/06/24.
//

import Foundation

enum HUHttpMethods : String
{
    case get = "GET"
    case post = "POST"
}

public struct HUNetworkError : Error
{
    public let reason: String
    public let httpStatusCode: Int?
    let requestUrl: URL?
    let requestBody: String?
    let serverResponse: String?

    init(withServerResponse response: Data? = nil, forRequestUrl url: URL, withHttpBody body: Data? = nil, errorMessage message: String, forStatusCode statusCode: Int)
    {
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        self.reason = message
    }
}

protocol Request {
    var url: URL { get set }
    var method: HUHttpMethods { get set }
}

struct HURequest: Request {
    var url: URL
    var method: HUHttpMethods
    var requestBody: Data? = nil
    var completion: HttpUtility.DataTaskCompletion? = nil
    
     init(withUrl url: URL, forHttpMethod method: HUHttpMethods, requestBody: Data? = nil,completion: HttpUtility.DataTaskCompletion? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
         self.completion = completion != nil ? completion : nil
    }
}


class HttpUtility
{
    

   
     typealias DataTaskCompletion = (Result<Any, HUNetworkError>) -> Void
    
     static let shared = HttpUtility()
     var authenticationToken : String? = nil
     var customJsonDecoder : JSONDecoder? = nil
    private let AuthRequestsQueue = DispatchQueue( label: "HttpUtility.AuthRequestsQueue", attributes: .concurrent)
    private var unsafeAuthRequests = Array<Any>()
    
    
     func request(url : URL,method: HUHttpMethods,body : Data? = nil, completionHandler:@escaping(Result<Any, HUNetworkError>)-> Void)
    {
        
        var huRequest = HURequest(withUrl: url, forHttpMethod: method,requestBody: body)
            //Check if token valid
        if !AuthManager.shared.shouldRefreshToken{
                switch huRequest.method
                {
                case .get:
                    getData(requestUrl: huRequest.url) { completionHandler($0)}
                    break

                case .post:
                    postData(request: huRequest) { completionHandler($0)}
                    break
                }
            }else{
                //Add Data to unsafeArray
                huRequest.completion = completionHandler
                unsafeAuthRequests.append(huRequest)
                
                if AuthManager.shared.isTokenRefreshInProcess{
                    
                }else{
                    // Refresh Token
                    AuthManager.shared.refreshAccessToken(completion: {
                        (response) in
                        if response{
                            self.safelySendAllRequests()
                        }else{
                            // Handle for later
                            print("Failed to refresh token")
                        }
                    })
                }
                
               
            }
        
        
        
    }

    //For Token and login api only
     func priorityRequest(huRequest: HURequest, completionHandler:@escaping(Result<Any, HUNetworkError>)-> Void)
   {
       switch huRequest.method
       {
       case .get:
           getData(requestUrl: huRequest.url) { completionHandler($0)}
           break

       case .post:
           postData(request: huRequest) { completionHandler($0)}
           break
       }
   }

    // MARK: - Private functions
    private func createJsonDecoder() -> JSONDecoder
    {
        let decoder =  customJsonDecoder != nil ? customJsonDecoder! : JSONDecoder()
        if(customJsonDecoder == nil) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    private func createUrlRequest(requestUrl: URL) -> URLRequest
    {
        var urlRequest = URLRequest(url: requestUrl)
        if(authenticationToken != nil) {
            urlRequest.setValue("Bearer \(AuthManager.shared.accessToken!)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }

    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T?
    {
        let decoder = createJsonDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        }catch let error {
            print("Error \(error)")
            //debugPrint("error while decoding JSON response =>\(error.localizedDescription)")
        }
        return nil
    }

    // MARK: - GET Api
    private func getData(requestUrl: URL, completionHandler:@escaping(Result<Any, HUNetworkError>)-> Void)
    {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HUHttpMethods.get.rawValue

        performOperation(requestUrl: urlRequest) { (result) in
            completionHandler(result)
        }
    }

    // MARK: - POST Api
    private func postData(request: HURequest, completionHandler:@escaping(Result<Any, HUNetworkError>)-> Void)
    {
        var urlRequest = self.createUrlRequest(requestUrl: request.url)
        urlRequest.httpMethod = HUHttpMethods.post.rawValue
        urlRequest.httpBody = request.requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        performOperation(requestUrl: urlRequest) { (result) in
            completionHandler(result)
        }
    }

    // MARK: - Perform data task
    private func performOperation(requestUrl: URLRequest, completionHandler:@escaping(Result<Any, HUNetworkError>) -> Void)
    {
        
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if statusCode == 200{
                //handle it
                if let data = data{
                    completionHandler(.success(data))
                }
                
            }else if statusCode == 401  ||  statusCode == 403 || statusCode == 429{
                //handle it
            }else{
                let networkError = HUNetworkError(withServerResponse: data, forRequestUrl: URL(string: "Sotify Clone")!, errorMessage: "Something Went Wrong", forStatusCode: statusCode ?? 99)
                completionHandler(.failure(networkError))
            }
                
        }.resume()
           

       
    }
    
     // safely sends all saved OAuthRequests
      func safelySendAllRequests() {
          AuthRequestsQueue.async(flags: .barrier) { [weak self] in
                self?.unsafeAuthRequests.forEach { (AuthRequest) in
                 
                    if let huRequest = AuthRequest as? HURequest {
                        switch huRequest.method
                        {
                        case .get:
                            self!.getData(requestUrl: huRequest.url , completionHandler: huRequest.completion!)
                            break

                        case .post:
                            self!.postData(request: huRequest,completionHandler: huRequest.completion!)
                            break
                        }
                    }
                    
                }
                self?.unsafeAuthRequests.removeAll()
              }
       
     }
}
