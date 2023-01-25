//
//  NetworkRequestService.swift
//  MySchedule
//
//  Created by Apps2M on 19/1/23.
//

import UIKit

class NetworkRequestService: NSObject {
    
    static var loged: Bool = false
    
    static func DoPost(_paramsDic: [String: Any], _url: URL){
        
        var successOperation: Bool = false

        let eventManager: EventsManager = EventsManager()
        
        UserManager.LoadUsers()
        
        eventManager.LoadEvents()
        
        let _userParams: [String: Any] = _paramsDic

        print(_userParams)
        
        
        let url = _url // change server url accordingly
        
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            request.httpBody = try JSONSerialization.data(withJSONObject: _userParams, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            successOperation = false
        }
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                successOperation = false
                
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                successOperation = false
                print("Invalid Response received from the server")
                return
            }
            
            // ensure there is data returned
            if data != nil{
                
                successOperation = true
                
            }
            
            print("Success Operation:", successOperation)
            
            UserManager.LoadUsers()
            eventManager.LoadEvents()
            
            self.loged = successOperation
        }
        task.resume()
        
        // perform the task
        
        

    }
    
    static func DoGet(_url: URL)-> [Any]{
        var data = Data()
        
        var tempJsonList: [Any] = []
        
        do {
            data = try Data(contentsOf: _url)
        } catch {
            print("Error was ocurred")
        }
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            

            
            
            for e in json as! [Any] {
                
                
                if type(of: e) != NSNull.self{
                    tempJsonList.append(e)
                }
                
            }
            
            
        } catch let errorJson {
            print(errorJson)
        }
        
        return tempJsonList
    }
    
    
}





