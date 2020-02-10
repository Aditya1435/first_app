//
//  Your_Ddetail.swift
//  Myfist_App
//
//  Created by sonu on 20/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Your_Ddetail: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_address: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.txt_name.delegate = self
        self.txt_email.delegate = self
        self.txt_mobile.delegate = self
        self.txt_address.delegate = self
        self.txt_mobile.keyboardType = .numberPad

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.txt_mobile {
            let allowedCharater = "()+-0123456789"
            let allowedCharaterSet = CharacterSet(charactersIn: allowedCharater)
            let typedCharcterSet = CharacterSet(charactersIn: string)
            return allowedCharaterSet.isSuperset(of: typedCharcterSet)
        }
        else {
            return true
        }
    }
    func validateEmail(candidate: String) -> Bool {
              let emailRegex = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
              return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
          }
       func showAlert(title: String, message: String)  {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
           self.present(alertController, animated: true, completion: nil)

       }
      
    @IBAction func Pay_Now(_ sender: UIButton) {
       let name = txt_name.text
             if name == ""{
                 self.showAlert(title: "Alert", message: "Please Enter Your Name!")
             }
             if txt_email.text == ""{
                     self.showAlert(title: "Alert", message: "Please Enter Your Email!")
             }
             if self.validateEmail(candidate: txt_email.text!){
             }else{
                 self.showAlert(title: "Alert", message: "Please Enter Valid Email!")
             }
        
            if txt_mobile.text == ""{
                
            self.showAlert(title: "Alert", message: "Please Enter Your Mobile Number!")
                
             }

            if txt_address.text == ""{
            self.showAlert(title: "Alert", message: "Please Enter Your Password!")
            }

//        let vc = UIStoryboard.init(name: "main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBar_vc") as! TabBar_VC

    }
    

  }
