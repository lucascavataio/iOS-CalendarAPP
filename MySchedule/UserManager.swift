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
        
        var data = Data()
        
        do {
            data = try Data(contentsOf: urlUsers!)
        } catch {
            print("Error was ocurred")
        }
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            userList.removeAll()

            var tempJsonList: [Any] = []
            
            for e in json as! [Any] {
                
                
                if type(of: e) != NSNull.self{
                    tempJsonList.append(e)
                }
                
            }
            
            for user in tempJsonList as! [[String : Any]] {
                userList.append(User(json: user))
            }
            
            
        } catch let errorJson {
            print(errorJson)
        }
        
    }
    
    func UploadUsers(){
        
    }
    
    func ReloadUsers(){
        
    }
}
