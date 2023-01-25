//
//  UserManager.swift
//  MySchedule
//
//  Created by Apps2M on 13/1/23.
//

import UIKit

class UserManager {

    var userList: [User] = []
    
    var currentUser: User = User(json: [:])
    
    let urlUsers = URL(string:"https://superapi.netlify.app/api/db/users")
    
    let urlLogin = URL(string:"https://superapi.netlify.app/api/login")
    
    let urlSignup = URL(string:"https://superapi.netlify.app/api/register")

    func LoadUsers(){
        
        userList.removeAll()
        
        let tempJson = NetworkRequestService.DoGet(_url: urlUsers!)
            
        for user in tempJson as! [[String : Any]] {
                userList.append(User(json: user))
        }

    }
    
}
