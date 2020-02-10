//
//  SecondViewController.swift
//  Myfist_App
//
//  Created by sonu on 07/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate  {
    
    var sample_TextField = UITextField()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

            
//        programme UIImage
//        let imageName = "back_arrow"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//
//        imageView.frame = CGRect(x: 20, y: 74, width: 44, height: 44)
//            self.view.addSubview(imageView)

        let button = UIButton(frame: CGRect(x: 20, y: 74, width: 44, height: 44))

        button.setImage(UIImage(named: "back_arrow"), for: UIControl.State.init())
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)

        let label =  UILabel (frame: CGRect(x: 20,y: 130,width: UIScreen.main.bounds.width-40,height: 30))

        label.textAlignment = NSTextAlignment.left
        label.text = "Forgot Password"
        label.textColor = .darkGray
        label.font = label.font.withSize(30)
         self.view.addSubview(label)
        
        
        let labelT =  UILabel (frame: CGRect(x: 20,y: 170,width: UIScreen.main.bounds.width-40,height: 36))

          labelT.textAlignment = NSTextAlignment.left
          labelT.text = "Quisque sit amet lectus vitae neque bibendum feugiat ac in sapien."
          labelT.textColor = .darkGray
          labelT.numberOfLines = 0
          labelT.font = labelT.font.withSize(15)
          self.view.addSubview(labelT)
        
        
        let label2 =  UILabel (frame: CGRect(x: 20,y: 325,width: UIScreen.main.bounds.width-40,height: 20))
        label2.textAlignment = NSTextAlignment.left
        label2.text = "Email Address"
        label2.textColor = .darkGray
        label2.font = label2.font.withSize(15)
        self.view.addSubview(label2)
        
        
         sample_TextField =  UITextField(frame: CGRect(x: 20, y: 350, width: UIScreen.main.bounds.width-40, height: 40))
         sample_TextField.placeholder = "Enter text here"
        sample_TextField.font = UIFont.systemFont(ofSize: 15)
        sample_TextField.borderStyle = UITextField.BorderStyle.none
        sample_TextField.autocorrectionType = UITextAutocorrectionType.no
        sample_TextField.keyboardType = UIKeyboardType.default
        sample_TextField.returnKeyType = UIReturnKeyType.done
        sample_TextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sample_TextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
         sample_TextField.keyboardType = .emailAddress
        sample_TextField.delegate = self
        self.view.addSubview(sample_TextField)
        
        
        let label3 =  UILabel (frame: CGRect(x: 20,y: 391,width: UIScreen.main.bounds.width-40,height: 1))
        label3.backgroundColor = .gray
        self.view.addSubview(label3)
        
        
        let button1 = UIButton(frame: CGRect(x: 20, y: 420, width: UIScreen.main.bounds.width-40, height: 50))
           
             button1.titleLabel?.font = UIFont.systemFont(ofSize: 30)
             button1.setTitleColor(.none, for: .normal)
             button1.backgroundColor = UIColor.orange
             button1.setTitle("Reset Password", for: .normal)
             button1.addTarget(self, action: #selector(button1Action), for: .touchUpInside)

        self.view.addSubview(button1)
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
    
    
   @objc func btn1Action(sender: UIButton!) {
    
     print("Button LogIn")
    
      }

    @objc func buttonAction(sender: UIButton!) {
    
        self.navigationController?.popViewController(animated: true)
        
    print("Back ")
        }

    @objc func button1Action(sender: UIButton!) {
        
        let email = sample_TextField.text

        if self.validateEmail(candidate: sample_TextField.text!){
        } else{
            self.showAlert(title: "Alert", message: "Please Enter Valid Email!")
                           }
    
        var parameters = [String:Any]()

               parameters["email"] = self.sample_TextField.text


               var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/users/forgot_password")!)
               request.httpMethod = "POST"
               request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")

               let session = URLSession.shared
               let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                 //  print(response!)
                   do {
                       let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                       print(json)
                       
                       if json["status"]! as! String == "error"{
                           
                           DispatchQueue.main.async {
                                  self.showAlert(title: "Alert", message: json["message"]! as! String)
                              }
                           
                           
                       }else{
                           print("Login details = ",json["data"] as Any)
                       }
                   } catch {
                       print("error")
                   }
               })

               task.resume()
        

    }
    
    
}
