//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    private init(){}
    
    var isSignedIn : Bool{
        return false
    }

    private var accessToken : String?{
        return nil
    }
    
    private var refreshToken : String?{
        return nil
    }
    
    private var tokenExpiratinDate : Date?{
        return nil
    }
    
    private var shouldRefreshToken : Bool{
        return false
    }
    
}
