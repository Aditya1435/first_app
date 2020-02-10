//
//  ViewController.swift
//  Myfist_App
//
//  Created by sonu on 07/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   var sampleTextField =  UITextField()
    
    var sampleTextField1 = UITextField()
       override func viewDidLoad() {
        super.viewDidLoad()
               
       self.hideKeyboardWhenTappedAround()
      
        let label =  UILabel (frame: CGRect(x: 20,y: 80,width: UIScreen.main.bounds.width-40,height: 131))
        label.textAlignment = NSTextAlignment.left
        label.text = "Login"
        label.textColor = .darkGray
        label.font = label.font.withSize(30)
         self.view.addSubview(label)
        
        let label4 =  UILabel (frame: CGRect(x: 20,y: 250,width: UIScreen.main.bounds.width-40,height: 20))
        label4.textAlignment = NSTextAlignment.left
        label4.text = "Email Address"
        label4.textColor = .darkGray
        label4.font = label4.font.withSize(15)
        self.view.addSubview(label4)
        
       sampleTextField =  UITextField(frame: CGRect(x: 20, y: 280, width: UIScreen.main.bounds.width-40, height: 44))
       sampleTextField.placeholder = "Enter text here"
       sampleTextField.font = UIFont.systemFont(ofSize: 15)
       sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
       sampleTextField.autocorrectionType = UITextAutocorrectionType.no
       sampleTextField.keyboardType = UIKeyboardType.default
       sampleTextField.returnKeyType = UIReturnKeyType.done
       sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
       sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.keyboardType = .emailAddress
       sampleTextField.delegate = self
        sampleTextField.text = "1435@mailinator.com"
       self.view.addSubview(sampleTextField)
        
        
        let labelM =  UILabel (frame: CGRect(x: 20,y: 325,width: UIScreen.main.bounds.width-40,height: 1))
        labelM.backgroundColor = .gray
        self.view.addSubview(labelM)


                     
        let label5 =  UILabel (frame: CGRect(x: 20,y: 350,width: UIScreen.main.bounds.width-40,height: 20))
     
        label5.textAlignment = NSTextAlignment.left
        label5.text = "Password"
        label5.textColor = .darkGray
        label5.font = label5.font.withSize(15)
        
        self.view.addSubview(label5)
        
         sampleTextField1 =  UITextField(frame: CGRect(x: 20, y: 380, width: UIScreen.main.bounds.width-40, height: 40))
        sampleTextField1.placeholder = ".............."
        sampleTextField1.font = UIFont.systemFont(ofSize: 15)
        sampleTextField1.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField1.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField1.keyboardType = UIKeyboardType.default
        sampleTextField1.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField1.isSecureTextEntry = true
        sampleTextField1.delegate = self
        sampleTextField1.keyboardType = .emailAddress
        sampleTextField1.text = "123456" 
        self.view.addSubview(sampleTextField1)
        
        let labelp =  UILabel (frame: CGRect(x: 20,y: 421,width: UIScreen.main.bounds.width-40,height: 1))
        labelp.backgroundColor = .gray
        self.view.addSubview(labelp)
        
        let button1 = UIButton(frame: CGRect(x: 20, y: 435, width: UIScreen.main.bounds.width-40, height: 50))
               
                 button1.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                 button1.setTitleColor(.none, for: .normal)
                 button1.backgroundColor = UIColor.orange
                 button1.setTitle("LogIn", for: .normal)
                 button1.addTarget(self, action: #selector(button1Action), for: .touchUpInside)
                self.view.addSubview(button1)
        
        
          let button2 = UIButton(frame: CGRect(x: 20,y: 500,width: UIScreen.main.bounds.width-40, height: 50))
        
          button2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
          button2.setTitleColor(.gray, for: .normal)
          button2.setTitle("Forgat password ?", for: .normal)
          button2.addTarget(self, action: #selector(button2Action), for: .touchUpInside)
          self.view.addSubview(button2)
        
        
        
   
        let label3 =  UILabel (frame: CGRect(x: 85,y: 535,width: 150,height: 30))
        label3.textAlignment = NSTextAlignment.center
        label3.text = "Not account yet ?"
        label3.textColor = .darkGray
        label3.font = label3.font.withSize(15)
        self.view.addSubview(label3)
        
        let button = UIButton(frame: CGRect(x: 200, y: 535, width: 140, height: 30))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.orange, for: .normal)
        button.setTitle("Create One", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        
         }
    
    //MARK:- validate & showAlert 
   
    func validateEmail(candidate: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
       }

    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
   
  
      @objc func button2Action(sender: UIButton!) {
        
        let vc1 = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "2viewcontroller") as? SecondViewController)!
        self.navigationController?.pushViewController(vc1, animated: true)
      print("Forgat Password")
    
      }
    
    @objc func buttonAction(sender: UIButton!) {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "3thViewController") as? ThardViewController
           self.navigationController?.pushViewController(vc!, animated: true)
          print("Create one")
        }
  
    // MARK:- UITextField Show Alert
    
    @objc func button1Action(sender: UIButton!) {
        
        let email = sampleTextField.text
                    if email == ""{
                       self.showAlert(title: "Alert", message: "Please Enter Your Email!")
                    }
        
        if self.validateEmail(candidate: sampleTextField.text!){
                   } else{
                        self.showAlert(title: "Alert", message: "Please Enter Valid Email!")
                    }
                if sampleTextField1.text == ""{
                    
                   self.showAlert(title: "Alert", message: "Please Enter Your Password!")

                   }
       
                    
       // MARK:- login API call http://xsdemo.com/bellezayofertas/api/users/login
       
     var parameters = [String:Any]()
        parameters["device_token"] = "524645"
        parameters["email"] = self.sampleTextField.text
        parameters["password"] = self.sampleTextField1.text
        parameters["device_type"] = "iOS"
        parameters["user_type"] = "User"
      
    
        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/users/login")!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        
            print(response!)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)

                if json["status"]! as! String == "error"{

                    DispatchQueue.main.async {
                         self.showAlert(title: "Alert", message: json["message"]! as! String)
                    }
                    }else{
                   DispatchQueue.main.async {
                   self.showAlert(title: "Login", message: json["message"]! as! String)
                    let token = json["data"]!["token"] as! String
                    UserDefaults.standard.setValue(token, forKey: "LoginToken")
                    UserDefaults.standard.synchronize()
                    
                    let UserToken = UserDefaults.standard.value(forKey: "LoginToken")
                    print("Login user token = ",UserToken!)
                    }
                    print("Login details = ",json["data"] as Any)
                   
                }
            } catch {
                print("error")
            }
      
        })

   task.resume()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBar_vc") as? TabBar_VC
            self.navigationController?.pushViewController(vc!, animated: true)
       
        }
    
    }

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


