//
//  Profile_Edit.swift
//  Myfist_App
//
//  Created by sonu on 26/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Profile_Edit: UIViewController, UITextFieldDelegate {

    @IBOutlet var Edit_Name: UITextField!
    @IBOutlet var Edit_Email: UITextField!
    @IBOutlet var Edit_Number: UITextField!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()

        self.Edit_Name.delegate = self
        self.Edit_Email.delegate = self
        self.Edit_Number.delegate = self
        self.Edit_Number.keyboardType = .numberPad
        
       
    }
    
    //MARK:- Validate And Alert
    
    func validateEmail(candidate: String ) -> Bool {
        let emailRegex = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        
    }
    
    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
  override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           Edit_Name.text = UserDefaults.standard.string(forKey: "name")
           Edit_Email.text = UserDefaults.standard.string(forKey: "email")
           Edit_Number.text = UserDefaults.standard.string(forKey: "number")
       }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.Edit_Number {
        let invalidCharacters = CharacterSet(charactersIn: "()+-0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
        }   else {
            return true
        }
    }

    @IBAction func User_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func SaveBack(_ sender: Any) {
        
        let name = Edit_Name.text
                    if name == ""{
                        self.showAlert(title: "Alert", message: "Please Enter Your Name!")
                    }
                    if Edit_Email.text == ""{
                            self.showAlert(title: "Alert", message: "Please Enter Your Email!")
                    }
                    if self.validateEmail(candidate: Edit_Email.text!){
                    }else{
                        self.showAlert(title: "Alert", message: "Please Enter Valid Email!")
                    }
               
                   if Edit_Number.text == ""{
                       
                   self.showAlert(title: "Alert", message: "Please Enter Your Mobile Number!")
                       
                    }
   
    let profile : ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "profilevc") as! ProfileVC
         
        profile.Name = Edit_Name.text!
        profile.Email = Edit_Email.text!
        profile.Number = Edit_Number.text!

        UserDefaults.standard.setValue(Edit_Name.text!, forKey: "name")
        UserDefaults.standard.setValue(Edit_Email.text!, forKey: "email")
        UserDefaults.standard.setValue(Edit_Number.text!, forKey: "number")
        
        self.navigationController?.popViewController(animated: true)
    
   
        }
   
    }
 
    

