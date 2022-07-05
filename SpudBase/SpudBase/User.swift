//
//  User.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 7/4/22.
//

import UIKit

struct SessionData: Codable {
    var _userName: String?
    var _userID: String?
    var _sessionID: String?
    
    init(withPlistAt url: URL) {
        do {
            let plistData = try Data(contentsOf: url)
            self = try PropertyListDecoder().decode(SessionData.self, from: plistData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    init(with userName: String, userID: String, sessionID: String) {
        _userName = userName
        _userID = userID
        _sessionID = sessionID
    }
    
    func save() {
        let saveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SessionData")
            .appendingPathExtension("plist")
        do {
            let encodedData = try PropertyListEncoder().encode(self)
            try encodedData.write(to: saveURL)
        }catch {
            print(error.localizedDescription)
        }
    }
}
