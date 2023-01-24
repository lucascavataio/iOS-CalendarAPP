//
//  ViewController.swift
//  MySchedule
//
//  Created by Apps2M on 12/1/23.
//

import UIKit

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let userManager: UserManager = UserManager()
    
    let eventsManager: EventsManager = EventsManager()
    
    var sortedByRecentDate: Bool = true

    @IBOutlet weak var eventListTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DeviceManager.AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        DeviceManager.AppUtility.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        eventsManager.LoadEvents()
        
        for e in eventsManager.eventsList{
            print("Event:", e.name, "-", e.formatedDate)
        }
        
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsManager.eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eventRow: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "eventRowID", for: indexPath) as! EventTableViewCell
        
        let event = eventsManager.eventsList[indexPath.row]
        
        
        eventRow.eventTitleLabel.text = event.name
        
        eventRow.eventDateLabel.text = event.formatedDate
        
        eventRow.eventTimeLabel.text = event.formatedTime
        
        return eventRow
    }
    
    @IBAction func OnOrderButtonClick(_ sender: Any) {
        SortEventsList()
    }
    
    @IBAction func ReloadListOnButtonClick(_ sender: Any) {
        eventsManager.LoadEvents()
        eventListTableView.reloadData()
    }
    
    
    @IBAction func DeleteEventOnClick(_ sender: UIButton) {
        NetworkRequestService.DoDelete()
    }
    
    func SortEventsList(){
        sortedByRecentDate = !sortedByRecentDate
        
        eventsManager.OrderEventList(_byRecent: sortedByRecentDate)
        
        eventListTableView.reloadData()
    }
    
}

