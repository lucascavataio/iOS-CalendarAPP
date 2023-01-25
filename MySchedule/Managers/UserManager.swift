//
//  UserManager.swift
//  MySchedule
//
//  Created by Apps2M on 13/1/23.
//

import UIKit

class UserManager {

    static var userList: [User] = []
    
    static var currentUser: User = User(json: [:])
    
    static let urlUsers = URL(string:"https://superapi.netlify.app/api/db/users")
    
    static let urlLogin = URL(string:"https://superapi.netlify.app/api/login")
    
    static let urlSignup = URL(string:"https://superapi.netlify.app/api/register")

    static func LoadUsers(){
        
        userList.removeAll()
        
        let tempJson = NetworkRequestService.DoGet(_url: urlUsers!)
            
        for user in tempJson as! [[String : Any]] {
                userList.append(User(json: user))
        }

    }
    
}
