//
//  User.swift
//  MySchedule
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class User: Codable {

    var userName: String
    
    var password: String
    
    init(json: [String: Any]) {
        
        self.userName = json["user"] as? String ?? ""
        
        self.password = json["pass"] as? String ?? ""
    }

}
