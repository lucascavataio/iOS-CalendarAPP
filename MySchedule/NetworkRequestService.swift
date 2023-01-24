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
    
        let userManager: UserManager = UserManager()
        
        let eventManager: EventsManager = EventsManager()
        
        userManager.LoadUsers()
        
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
            
            userManager.LoadUsers()
            eventManager.LoadEvents()
            
            self.loged = successOperation
        }
        task.resume()
        
        // perform the task
        
        

    }
    
    static func DoGet(){
        
    }
    
    static func DoDelete(){
        
        let userManager: UserManager = UserManager()
        
        let eventManager: EventsManager = EventsManager()
        
                // Create the request
        var request = URLRequest(url: eventManager.GET_URL!)
                request.httpMethod = "DELETE"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling DELETE")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
    }
}





