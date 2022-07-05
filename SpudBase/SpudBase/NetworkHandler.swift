//
//  NetworkHandler.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 7/4/22.
//

import UIKit
import AuthenticationServices

class NetworkHandler {
    
    private static let APP_CALLBACK_SCHEME = "spudbase"
    
    private static let SPUDBASE_SCHEME = "https"
    private static let SPUDBASE_HOST = "shielded-badlands-00728.herokuapp.com"
    private static let SPUDBASE_OAUTH_PATH = "/oauth/authorizemobile"
    
    private static let GITHUB_SCHEME = "https"
    private static let GITHUB_HOST = "github.com"
    private static let GITHUB_OAUTH_PATH = "/login/oauth/authorize"
    private static let GITHUB_CLIENTID_KEY = "client_id"
    private static let GITHUB_CLIENTID_VALUE = "f287e04ce5fa9553455f"
    private static let GITHUB_STATE_KEY = "state"
    private static let GITHUB_STATE_VALUE = UUID().uuidString
    
    public static func sessionIsValid(sessionID: String) -> Bool {
        return false
    }
    
    public static func handleLogin(presContextProvider: ASWebAuthenticationPresentationContextProviding) {
        var newComp = URLComponents()
        newComp.scheme = GITHUB_SCHEME
        newComp.host = GITHUB_HOST
        newComp.path = GITHUB_OAUTH_PATH
        newComp.queryItems = []
        newComp.queryItems?.append(URLQueryItem(name: GITHUB_CLIENTID_KEY, value: GITHUB_CLIENTID_VALUE))
        newComp.queryItems?.append(URLQueryItem(name: GITHUB_STATE_KEY, value: GITHUB_STATE_VALUE))
        
        guard let sessionURL = newComp.url else {
            print("Error in creation of url from newComp URLComponents.\n val is \(newComp.description)")
            return
        }
        
        func sessionCompletionHandler(url: URL?, error: Error?) -> Void {
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let url = url else {
                print("error and url are both nil in session completion handler")
                return
            }
            
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                print("Unable to extract URLComponents from session completion handler")
                return
            }
            
            guard let qi = urlComponents.queryItems else {
                print("Unable to extract query items from urlComponents in session completion handler")
                return
            }
            
            guard let i = qi.firstIndex(where: {$0.name == "code"}) else {
                print("No code in response within session completion handler, cannot proceed")
                return
            }
            
            var newComp = URLComponents()
            newComp.scheme = SPUDBASE_SCHEME
            newComp.host = SPUDBASE_HOST
            newComp.path = SPUDBASE_OAUTH_PATH
            newComp.queryItems = [qi[i]]
            
            guard let newURL = newComp.url else {
                print("Unable to create url from URLComponent newComp \(newComp.description)")
                return
            }
            
            let task = URLSession.shared.dataTask(with: newURL) { data, response, error in
                guard (error == nil) else {
                    print(error.debugDescription)
                    return
                }
                
                guard let data = data else {
                    print("Unable to retrieve data \(data.debugDescription) or response \(response.debugDescription)")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    // #TODO
                    print("json is\(json)")
                }catch{ print("error in JSONSerialization of data \(data.description)")}
            }
            task.resume()
        }
        let session = ASWebAuthenticationSession.init(url: sessionURL, callbackURLScheme: APP_CALLBACK_SCHEME, completionHandler: sessionCompletionHandler)
        session.presentationContextProvider = presContextProvider
        session.start()
        // authURL.queryItems = [URLQueryItem(name: "client_id", value: "f287e04ce5fa9553455f"), URLQueryItem(name: "state", value: state.uuidString)]
    }
    
}

