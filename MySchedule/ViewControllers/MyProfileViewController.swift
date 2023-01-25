//
//  MyProfileViewController.swift
//  MySchedule
//
//  Created by Apps2M on 20/1/23.
//

import UIKit

class MyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recentEventsTableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var emptyRecentListMessage: UILabel!
    
    var imagePicker: ImagePicker!
    
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
        
        print("recent events: ", EventsManager.recentEvents.count)
        
        recentEventsTableView.dataSource = self
        recentEventsTableView.delegate = self
        
        userNameLabel.text = UserManager.currentUser.userName
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        emptyRecentListMessage.isHidden = EventsManager.recentEvents.count > 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventsManager.recentEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventRow: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "recentEventRowID", for: indexPath) as! EventTableViewCell
        
        let event = EventsManager.recentEvents[indexPath.row]
        
        eventRow.eventTitleLabel.text = event.name
        
        eventRow.eventDateLabel.text = event.formatedDate
        
        eventRow.eventTimeLabel.text = event.formatedTime
        
        return eventRow
    }
    
    @IBAction func ChangeProfilePicture(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

extension MyProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.profilePicture.image = image
    }

}



