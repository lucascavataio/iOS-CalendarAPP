//
//  ViewController.swift
//  MySchedule
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class MyEventsViewController: UIViewController {
    
    let userManager: UserManager = UserManager()
    
    let eventsManager: EventsManager = EventsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userManager.LoadUsers()
        eventsManager.LoadEvents()
        
        for e in eventsManager.eventsList{
            print("Event:", e.name, "-", e.formatedDate)
        }
        
        for u in userManager.userList{
            print("User:", u.userName, "Password:", u.password)
        }
    }


}

