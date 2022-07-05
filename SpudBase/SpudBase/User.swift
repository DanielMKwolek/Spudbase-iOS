//
//  User.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 7/4/22.
//

import UIKit

class User: NSObject {
    let _userName: String
    let _userID: String
    let _sessionID: String
    
    init(withName: String, id: String, sessionID: String) {
        self._userName = ""
        self._userID = ""
        self._sessionID = ""
        super.init()
    }
}
