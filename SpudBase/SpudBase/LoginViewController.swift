//
//  LoginViewController.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 6/30/22.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    @IBAction func onLoginTap(_ sender: Any) {
        let scheme = "spudbase"
        let state = UUID()
        
        var authURL = URLComponents()
        authURL.scheme = "https"
        authURL.host = "github.com"
        authURL.path = "/login/oauth/authorize"
        authURL.queryItems = [URLQueryItem(name: "client_id", value: "f287e04ce5fa9553455f"), URLQueryItem(name: "state", value: state.uuidString)]
        guard let url = authURL.url else {
            return
        }
        
        let session = ASWebAuthenticationSession.init(url: url, callbackURLScheme: scheme, completionHandler: { (url: URL?, error: Error?) -> () in
            print("complete session")
            if let url = url {
                print("url is \(url)")
                if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    print(url.absoluteString)
                    if let qi = urlComponents.queryItems {
                        print(qi[0])
                        var newComp = URLComponents()
                        newComp.queryItems = [URLQueryItem(name: "code", value: qi[0].value)]
                        newComp.host = "shielded-badlands-00728.herokuapp.com"
                        newComp.scheme = "https"
                        newComp.path = "/oauth/authorizemobile"
                        if let newurl = newComp.url {
                            print("newurl is: \(newurl)")
                            let task = URLSession.shared.dataTask(with: newurl) { data, response, error in
                                if let data = data{
                                    print(data)
                                    do {
                                        let json = try JSONSerialization.jsonObject(with: data)
                                        print("json is :\(json)")
                                    }catch{ print("Uh oh")}
                                    
                                }
                                if let response = response {
                                    print(response)
                                }
                                if let error = error {
                                    print(error)
                                }
                            }
                            task.resume()
                        }

                    }
                    
                }
            }
            
            if let error = error {
                print(error)
            }
        })
        session.presentationContextProvider = self
        session.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
