//
//  Event.swift
//  MySchedule
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class Event: Decodable {
    
    var name: String
    
    var date: Int64
    
    var formatedDateTime: String
    
    var formatedDate: String = ""
    
    var formatedTime: String = ""
    
    var dateInDateFormat: Date = Date()
    
    init(json: [String: Any]) {
        
        name = json["name"] as? String ?? ""
        date = json["date"] as? Int64 ?? 0
        
        dateInDateFormat = DateFormatManager.GetDateInDateFormat(_date: Double(date))
        
        formatedDateTime = DateFormatManager.FormatDate(_date: Double(date))
        
        formatedDate = DateFormatManager.ExtractDateFormDate(_dateTime: formatedDateTime)
        
        formatedTime = DateFormatManager.ExtractTimeFormDate(_dateTime: formatedDateTime)

    }
}
