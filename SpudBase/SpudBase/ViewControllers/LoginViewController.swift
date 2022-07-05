//
//  LoginViewController.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 6/30/22.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    var sessionData: SessionData?
    
    @IBAction func onLoginTap(_ sender: Any) {
        performSegue(withIdentifier: "loginToProfile", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let sessionDataURL = Bundle.main.url(forResource: "SessionData", withExtension: "plist") else { return }
        sessionData = SessionData(withPlistAt: sessionDataURL)
    }
    
    func runLogin() {
        NetworkHandler.handleLogin(presContextProvider: self)
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
