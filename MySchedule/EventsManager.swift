//
//  EventsManager.swift
//  MySchedule
//
//  Created by Apps2M on 13/1/23.
//

import UIKit

class EventsManager {
    
    var eventsList: [Event] = []
    
    static var recentEvents: [Event] = []
    
    let GET_URL = URL(string:"https://superapi.netlify.app/api/db/eventos")
    
    let POST_URL = URL(string:"https://superapi.netlify.app/api/db/eventos")
    
    func LoadEvents(){
        
        eventsList.removeAll()
        
        let tempJson = NetworkRequestService.DoGet(_url: GET_URL!)
        
        for event in tempJson as! [[String : Any]] {
            eventsList.append(Event(json: event))
        }
        
    }
    
    func UploadEvents(_name: String, _date: Date){
        
        let params: [String : Any] = [
            
            "name": _name,
            "date": _date.timeIntervalSince1970
            
        ]
        
        EventsManager.recentEvents.append(Event(json: params))
        
        print(EventsManager.recentEvents[0])
        
        NetworkRequestService.DoPost(_paramsDic: params, _url: GET_URL!)
    }
    
    func OrderEventList(_byRecent: Bool){
        
        if _byRecent{
            eventsList = eventsList.sorted(by: { $0.dateInDateFormat.compare($1.dateInDateFormat) == .orderedAscending })
        } else{
            eventsList = eventsList.sorted(by: { $0.dateInDateFormat.compare($1.dateInDateFormat) == .orderedDescending })
        }
        
    }
    
    
}
