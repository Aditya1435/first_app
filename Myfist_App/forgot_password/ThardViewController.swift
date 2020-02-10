//
//  ThardViewController.swift
//  Myfist_App
//
//  Created by sonu on 08/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit


class ThardViewController: UIViewController ,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
 //   @IBOutlet weak var button: UIButton!
    @IBOutlet weak var btn_male: UIButton!
    @IBOutlet weak var btn_female: UIButton!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var txt_num: UITextField!
    @IBOutlet var txtDOB: UITextField!
    @IBOutlet var txtState: UITextField!
    
    var datePicker = UIDatePicker()
    var myPickerview = UIPickerView()
    var strGander = ""
    var pickerData = ["Andhra Pradesh(Hyderabad)","Arunachal Pradesh(Itanagar)","Assam(Dispur)","Bihar(Patna)","Chhattisgarh(Raipur)","Goa(Panaji)","Gujarat(Gandhinagar)","Haryana(Chandigarh)","Himachal Pradesh(Shimla)","Jammu & Kashmir(Srinagar,Jammu)","Jharkhand(Ranchi)","Karnataka(Bangalore)","Kerala(Thiruvananthapuram)","Madhya Pradesh(Bhopal)","Maharashtra(Mumbai)","Manipur(Imphal)","Meghalaya(Shillong)","Mizoram(Aizawl)","Nagaland(Kohima)","Odisha(Bhubaneshwar)","Punjab(Chandigarh)","Rajasthan(Jaipur)","Sikkim(Gangtok)","Tamil Nadu(Chennai)","Telangana(Hyderabad)","Tripura(Agartala)","Uttarakhand(Dehradun)","Uttar Pradesh(Lucknow)","West Bengal(Kolkata)"]
   
    override func viewDidLoad() {
            super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.btn_male.isSelected = true
        self.btn_female.isSelected = false
        self.txt_name.delegate = self
        self.txt_email.delegate = self
        self.txt_num.delegate = self
        self.txt_num.keyboardType = .numberPad
        self.txtState.delegate = self
        self.passwordTextField.delegate = self
        strGander = "Male"
        createdatepicker()
    }
    //MARK:- PickeView From State
    
    func pickup(_ textField: UITextField) {
        self.myPickerview = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.myPickerview.delegate = self
        self.myPickerview.dataSource = self
   //     self.myPickerview.backgroundColor = UIColor.white
        txtState.inputView = self.myPickerview
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancleButton = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: #selector(cancelClick))
        
        toolBar.setItems([cancleButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtState.text = pickerData[row]
    }
    
func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == txtState {
        self.pickup(txtState)
    }
}
    
    @objc func doneClick() {
           txtState.resignFirstResponder()
       }
      
       @objc func cancelClick() {
           txtState.resignFirstResponder()
       }
    
 
    //MARK:- UIDate Picker
  
    
    func createdatepicker()  {
          datePicker.datePickerMode = .date
          let tollbar = UIToolbar()
          tollbar.sizeToFit()
      
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doncac))
          tollbar.setItems([donebtn], animated: true)
          txtDOB.inputAccessoryView = tollbar
          txtDOB.inputView = datePicker
          
      }

      @objc func doncac()  {
          let formatter = DateFormatter()
          formatter.dateFormat = "dd/MM/yyyy"
          txtDOB.text = formatter.string(from: datePicker.date)
          self.view.endEditing(true)
      }
    

    //MARK:- Keybord Number Pad
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == self.txt_num  {
        
        let invalidCharacters = CharacterSet(charactersIn: "()+-0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    } else {
      return true
    }
    }
    //MARK:- Validate Email & All TextFiled
    
    func validateEmail(candidate: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z_%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,6}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
        func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK:- Singup Include Validate
    
    @IBAction func SingUp(_ sender: Any) {
            
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
        
            if txt_num.text == ""{
            self.showAlert(title: "Alert", message: "Please Enter Your Mobile Number!")
                
             }

            if txtDOB.text  == "" {
            self.showAlert(title: "Alert", message: "Please Enter Your Date of Birth !")
        }
     
            if txtState.text  == "" {
            self.showAlert(title: "Alert", message: "Please Enter Your State !")
        }

            if passwordTextField.text == ""{
            self.showAlert(title: "Alert", message: "Please Enter Your Password!")
            }
        
    // MARK:- Sinup API call http://192.168.1.83/bellezayofertas/api/customer/register
    
        var parameters = [String:Any]()
              
        
        parameters["first_name"] = self.txt_name.text
        parameters["email"] = self.txt_email.text
        parameters["phone_number"] = self.txt_num.text
        parameters["address"] = "central"
        parameters["latitude"] = -7.22555
        parameters["longitude"] = 11.5655
        parameters["password"] = self.passwordTextField.text
        parameters["confirm_password"] = 123456
        parameters["device_token"] = "524645"
        parameters["device_type"] = "iOS"

        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer/register")!)
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
                           print("register details = ",json["data"] as Any)
                       }
                   } catch {
                       print("error")
                   }
               })

               task.resume()
        
        
        let Thardvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBar_vc") as? TabBar_VC
        self.navigationController?.pushViewController(Thardvc!, animated: true)
       
    }
    
    @IBAction func singIn(_ sender: Any) {
        
        let login = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewController") as? ViewController
        self.navigationController?.pushViewController(login!, animated: true)
        
            }
    @IBAction func signIn_back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK:-  Button Selected Male
    
        @IBAction func btnMale(_ sender: Any) {
        if self.btn_male.isSelected == true{
        } else {
            self.btn_male.isSelected = true
            self.btn_female.isSelected = false
        }
    }
    
    //MARK:-  Button Selected Female
    
    @IBAction func btnFemale(_ sender: Any) {
        if self.btn_female.isSelected == true {
        }else{
            self.btn_female.isSelected = true
            self.btn_male.isSelected = false
        }
    }
    
    //MARK:- WebView
    
    @IBAction func goto_google(_ sender: Any) {
        
        let Thardvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "webview") as? WebView
            self.navigationController?.pushViewController(Thardvc!, animated: true)

    }
   
}
    

