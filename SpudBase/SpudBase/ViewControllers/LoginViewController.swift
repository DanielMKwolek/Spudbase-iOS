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
        runLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let user = NSKeyedUnarchiver.value(forKey: "userInfo") as? User else {
            runLogin()
            return
        }
        print(user)
    }
    
    func runLogin() {
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
