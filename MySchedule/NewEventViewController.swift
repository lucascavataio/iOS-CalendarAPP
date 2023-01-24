//
//  NewEventViewController.swift
//  MySchedule
//
//  Created by Apps2M on 19/1/23.
//

import UIKit

class NewEventViewController: UIViewController {
    
    let eventManager: EventsManager = EventsManager()
    
    @IBOutlet weak var eventNameInputField: UITextField!
    
    @IBOutlet weak var addEventButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        
    }
    
    @IBAction func OnInputFieldChanged(_ sender: Any) {
        
        addEventButton.isEnabled = eventNameInputField.hasText
        
        
    }
    
    @IBAction func OnButtonPressed(_ sender: Any) {
        SubmitNewEvent()
    }
    
    func SubmitNewEvent(){
        
        eventManager.UploadEvents(_name: eventNameInputField.text ?? "", _date: datePicker.date)

    }
}
