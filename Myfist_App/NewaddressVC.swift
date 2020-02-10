//
//  NewaddressVC.swift
//  Myfist_App
//
//  Created by sonu on 24/01/20.
//  Copyright © 2020 sonu. All rights reserved.
//

import UIKit

class NewaddressVC: UIViewController ,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var btn_saturday: UIButton!
    @IBOutlet var btn_sunday: UIButton!
    @IBOutlet var select_country: UITextField!
    @IBOutlet var txt_name: UITextField!
    @IBOutlet var txt_number: UITextField!
    @IBOutlet var txt_address1: UITextField!
    @IBOutlet var txt_address2: UITextField!
    @IBOutlet var txt_city: UITextField!
    @IBOutlet var txt_state: UITextField!
    @IBOutlet var txt_zipCoad: UITextField!
    @IBOutlet var additional_info: UITextField!
    @IBOutlet var btnSaveAddress: UIButton!
    
    var strSunday = "No"
    var strSaturday = "No"
    var strSelectedCountryName = ""
    var strSelectedCountryId = ""
    
    var myPickerview = UIPickerView()
    var dictcountry = [String:Any]()
    var arrcountry = [[String:Any]]()
    var dictedit = [String:Any] ()
    
//  var dictadd = [String:Any]()
     var isFrom = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txt_name.delegate = self
        self.txt_number.delegate = self
        self.txt_number.keyboardType = .numberPad
        self.txt_address1.delegate = self
        self.txt_address2.delegate = self
        self.txt_city.delegate = self
        self.txt_state.delegate = self
        self.txt_zipCoad.delegate = self
        self.txt_zipCoad.keyboardType = .numberPad
        self.select_country.delegate = self
        self.additional_info.delegate = self
        self.getCountryList()
        self.btn_saturday.isSelected = false
        self.btn_sunday.isSelected = false
        print("aditya =", dictedit)
        
        if self.isFrom == "Add"{
            //do nothing...
            self.btnSaveAddress.setTitle("Add New Address", for: .normal)
        }else{
            self.txt_name.text = dictedit["name"] as? String
            self.txt_number.text = dictedit["mobile_number"] as? String
            self.txt_address1.text = dictedit["address_line_1"] as? String
            self.txt_address2.text = dictedit["address_line_2"] as? String
            self.txt_city.text = dictedit["city"] as? String
            self.txt_state.text = dictedit["state"] as? String
            self.txt_zipCoad.text = dictedit["zip_code"] as? String
            self.select_country.text = dictedit["country_name"] as? String
            self.additional_info.text = dictedit["delivery_instruction"] as? String

            if dictedit["is_saturday"] as! String == "Yes"{
                self.btn_saturday.isSelected = true
                self.btn_saturday.setImage(UIImage(named: "checkBox_filled"), for: .selected)
            }else{
                self.btn_saturday.isSelected = false
                self.btn_saturday.setImage(UIImage(named: "checkBox_unfilled"), for: .normal)
            }
            
            if dictedit["is_sunday"] as! String == "Yes"{
                self.btn_sunday.isSelected = true
                self.btn_sunday.setImage(UIImage(named: "checkBox_filled"), for: .selected)
            }else{
                self.btn_sunday.isSelected = false
                self.btn_sunday.setImage(UIImage(named: "checkBox_unfilled"), for: .normal)
            }
            self.btnSaveAddress.setTitle("Update Address", for: .normal)
        }
    }

    func showAlert(title: String, message: String)  {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
 
    //MARK:- Selcete UIButton Saturday & Sunday
    
    @IBAction func selecte_saturday(_ sender: Any) {

        if btn_saturday.isSelected == false {
            self.btn_saturday.isSelected = true
            btn_saturday.setImage(UIImage.init(named: "checkBox_filled"), for: .selected)
            self.strSaturday = "Yes"
        } else {
            self.btn_saturday.isSelected = false
            self.strSaturday = "No"
        }
    }
    
    @IBAction func selecte_sunday(_ sender: Any) {
        if btn_sunday.isSelected == false {
            self.btn_sunday.isSelected = true
            btn_sunday.setImage(UIImage.init(named: "checkBox_filled"), for: .selected)
            self.strSunday = "Yes"
        } else {
            self.btn_sunday.isSelected = false
            self.strSunday = "No"
        }
    }
    
    //MARK:- Country Packer View
    
     func pickup(_ textField: UITextField) {
            self.myPickerview = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
            self.myPickerview.delegate = self
            self.myPickerview.dataSource = self
            self.myPickerview.backgroundColor = UIColor.white
            select_country.inputView = self.myPickerview
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewaddressVC.doneClick))
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
            return arrcountry.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.arrcountry[row]["country_name"] as? String
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.strSelectedCountryName = self.arrcountry[row]["country_name"] as! String
            self.strSelectedCountryId = self.arrcountry[row]["id"] as! String

            self.select_country.text = self.strSelectedCountryName
        }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == select_country {
            self.pickup(select_country)
        }
    }

        @objc func doneClick() {
               select_country.resignFirstResponder()
           }
          
    @objc func cancelClick() {
               select_country.resignFirstResponder()
           }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       if textField == self.txt_number  {
           
           let allowedCharater = "()+-0123456789"
           let allowedCharaterSet = CharacterSet(charactersIn: allowedCharater)
           let typedCharcterSet = CharacterSet(charactersIn: string)
             return allowedCharaterSet.isSuperset(of: typedCharcterSet)
        }
        else if (textField == self.txt_zipCoad ){

        let allowedCharater = "()+-0123456789"
        let allowedCharaterSet = CharacterSet(charactersIn: allowedCharater)
        let typedCharcterSet = CharacterSet(charactersIn: string)
          return allowedCharaterSet.isSuperset(of: typedCharcterSet)
           
        }
          return true
       }
    
    @IBAction func back_btn(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }
   
    // MARK:- API To Get Country List
    func getCountryList() {
    let parameters = [String:Any]()
        
       let UserToken:String = UserDefaults.standard.value(forKey: "LoginToken") as! String
       print("Login user token = ",UserToken)
      
       var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/country/country_list")!)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.setValue(UserToken, forHTTPHeaderField: "token")

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
            self.arrcountry.removeAll()
            let countryArray = json["data"] as! [[String:Any]]
                        self.arrcountry = countryArray
                        self.myPickerview.reloadAllComponents()
                      }
                  } catch {
                      print("error")
                  }
              })
              task.resume()
      }
    
    @IBAction func addNewAddress(_ sender: Any) {

        let name = txt_name.text
               if name == ""{
                   self.showAlert(title: "Alert", message: "Please Enter Your Name!")
               }
               if txt_number.text == "" {
                   self.showAlert(title: "Alert", message: "Please Enter Youe Contact Number")
               }
               if txt_address1.text == "" {
                   self.showAlert(title: "Alert", message: "Please Enter Your Address")
               }
               if txt_city.text == "" {
                   self.showAlert(title: "Alert", message: "Please Select Your City")
               }
               if txt_state.text == "" {
                   self.showAlert(title: "Alert", message: "Please Select Your State")
               }
               if txt_zipCoad.text == "" {
                   self.showAlert(title: "Alert", message: "Please Enter Your Pin NUmber")
               }
              if select_country.text == "" {
                   self.showAlert(title: "Alert", message: "Please Select Country")
               }

        var parameters = [String:Any]()
            parameters["name"] = self.txt_name.text
            parameters["mobile_number"] = self.txt_number.text
            parameters["address_line_1"] = self.txt_address1.text
            parameters["address_line_2"] = self.txt_address2.text
            parameters["city"] = self.txt_city.text
            parameters["state"] = self.txt_state.text
            parameters["zip_code"] = self.txt_zipCoad.text
            parameters["country_id"] = self.strSelectedCountryId
            parameters["delivery_instruction"] = self.additional_info.text
            parameters["is_saturday"] = self.strSaturday
            parameters["is_sunday"] = self.strSunday
        
//        if self.isFrom == "Add"{
//
//        }else{
//
//        }
        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer/add_address")!)

        let UserToken:String = UserDefaults.standard.value(forKey: "LoginToken") as! String
                     print("Login user token = ",UserToken)
        
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( UserToken, forHTTPHeaderField: "token")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        //print(response!)
        do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            print(json)
                                   
        if json["status"]! as! String == "error"{
           print("add address error details = ",json["message"] as Any)
        let alertController = UIAlertController(title: "ALERT", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else{
                    
            print("add address success details = ",json["message"] as Any)
            DispatchQueue.main.async {
                        
        let alertController = UIAlertController(title: "ALERT", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
                
            }
            }
            } catch {
            print("error")
                }
                })
            task.resume()

        let addaddress : My_Address = self.storyboard?.instantiateViewController(withIdentifier: "MyAddress") as! My_Address
        
        self.navigationController?.popViewController(animated: true)
    }
}
