//
//  LoginViewController.swift
//  MySchedule
//
//  Created by Apps2M on 16/1/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let userManager: UserManager = UserManager()
    
    let eventsManager: EventsManager = EventsManager()
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var usernameInputField: UITextField!
    
    @IBOutlet weak var passInputField: UITextField!
    
    @IBOutlet weak var usernameErrorMessage: UILabel!
    
    @IBOutlet weak var passErrorMessage: UILabel!
    
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    

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
        
        userManager.LoadUsers()
        
        for u in userManager.userList{
            print("User:", u.userName, "Password:", u.password)
        }
    }
    
    @IBAction func OnLoginSignup(_ sender: UIButton) {
        
        logInButton.isEnabled = false
        signUpButton.isEnabled = false
        
        if sender.accessibilityIdentifier == "login"{
            Login(_sender: sender)
        }else{
            Signup(_sender: sender)
        }
        
    }
    
    func Login(_sender: UIButton){
        if !CheckUserExists(){
            
            DisplayErrorMessage(_label: usernameErrorMessage, _message: "User not found...")
            
            return
        }
        
        
        DisplayLoadingIcon(_b: true)
        
        DispatchQueue.main.async {
            
            self.CheckPassword(_sender: _sender)
            
        }
        
    }
    
    func CheckUserExists() -> Bool{
        
        userManager.LoadUsers()
        
        var userFounded: Bool = false
        
        for u in userManager.userList{
            if u.userName == usernameInputField.text{
                userFounded = true
            }
        }
        
        return userFounded
    }
    
    func Signup(_sender: UIButton){
        
        if CheckUserExists(){
            
            DisplayErrorMessage(_label: usernameErrorMessage, _message: "That user already exists... Try to Login")
            
            return
        }
        
        DispatchQueue.main.async {
            
            self.CreateUser(_sender: _sender)
        }
        
    }
    
    
    @IBAction func OnInputFieldChange(_ sender: UITextField) {
        
        if sender.accessibilityIdentifier == "userField"{
            HideErrorMessage(_label: usernameErrorMessage)
        } else{
            HideErrorMessage(_label: passErrorMessage)
        }
        
        logInButton.isEnabled = usernameInputField.hasText && passInputField.hasText
        signUpButton.isEnabled = usernameInputField.hasText && passInputField.hasText
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)

    }
    
    func CheckPassword(_sender: UIButton){
        print("trying to log in...")
        
        let paramsDic: [String: Any] = [
            
            "user" : self.usernameInputField.text!,
            "pass" : self.passInputField.text!
            
        ]
        
        NetworkRequestService.DoPost(_paramsDic: paramsDic,  _url: self.userManager.urlLogin!)
        
        userManager.currentUser.userName = usernameInputField.text!
        userManager.currentUser.password = passInputField.text!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            if NetworkRequestService.loged{
                self.LoadHomeScreen(_sender: _sender)
                print("correct log")
            } else{
                self.DisplayErrorMessage(_label: self.passErrorMessage, _message: "The password or user are wrong...")
                print("pass error")
            }
            
            self.DisplayLoadingIcon(_b: false)
        }
    }
    
    
    
    func CreateUser(_sender: UIButton){
        
        print("trying to signup...")
        
        let paramsDic: [String: Any] = [
            
            "user" : self.usernameInputField.text!,
            "pass" : self.passInputField.text!
            
        ]
        
        NetworkRequestService.DoPost(_paramsDic: paramsDic,  _url: self.userManager.urlSignup!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            if NetworkRequestService.loged{
                self.LoadHomeScreen(_sender: _sender)
                print("correct log")
            } else{
                self.DisplayErrorMessage(_label: self.passErrorMessage, _message: "The password or user are wrong...")
                print("pass error")
            }
            
            self.DisplayLoadingIcon(_b: false)
        }
        
    }
    
    func DisplayErrorMessage(_label: UILabel,_message: String){
        DispatchQueue.main.async {
            _label.isHidden = false
            
            _label.text = _message
        }
        
    }
    
    func DisplayLoadingIcon(_b: Bool){
        DispatchQueue.main.async {
            self.loadingIcon.isHidden = !_b
        }
    }
    
    func HideErrorMessage(_label: UILabel){
        
        DispatchQueue.main.async {
            _label.isHidden = true
            
        }
        
    }
    
    func LoadHomeScreen(_sender: UIButton){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "home", sender: _sender)
        }
    }
}
