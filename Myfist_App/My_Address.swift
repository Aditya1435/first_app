//
//  My_Address.swift
//  Myfist_App
//
//  Created by sonu on 24/01/20.
//  Copyright © 2020 sonu. All rights reserved.
//

import UIKit

class My_Address: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet var btn_deliver: UIButton!
    var dictaddress = [String:Any]()
    var arraddress = [[String:Any]]()
    var arrCheckUncheck = [String]()
     var arrcelldelete = [[String:Any]]()
     
//    var saturdayCheckUncheck = [String]()
//    var sundayCheckUncheck = [String]()
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_deliver.isSelected = false
        self.arrCheckUncheck.removeAll()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.callApi()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyAddresssCell
        cell.lbl_name.text = self.arraddress[indexPath.row]["name"] as? String
        cell.lbl_address.text = self.arraddress[indexPath.row]["address_line_1"] as? String
        cell.address2.text = self.arraddress[indexPath.row]["address_line_2"] as? String
        cell.lbl4.text = self.arraddress[indexPath.row]["city"] as? String
        cell.lbl5.text = self.arraddress[indexPath.row]["state"] as? String
        cell.ZipCode.text = self.arraddress[indexPath.row]["pincoad"] as? String
        cell.lbl6.text = self.arraddress[indexPath.row]["country_name"] as? String
        cell.lbl7.text = self.arraddress[indexPath.row]["delivery_instruction"] as? String
        
        
        
        // MARK:- Remove index in tableviewcell
        
        cell.btn_delete.addTarget(self, action: #selector(self.btn_remove), for: .touchUpInside)
        cell.btn_delete.tag = indexPath.row
        
        cell.edit_address.addTarget(self, action: #selector(self.add_newaddress), for: .touchUpInside)
        cell.edit_address.tag = indexPath.row
        
        //MARK:- Button Check in tableviewcell
        
        if self.arrCheckUncheck[indexPath.row] == "Uncheck"{
            cell.btn_check.setImage(UIImage(named: "unchecked-radio-button"), for: .normal)
        }else{
            cell.btn_check.setImage(UIImage(named: "checked-radio-button"), for: .normal)
        }
        
        cell.btn_check.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
        cell.btn_check.tag = indexPath.row
        
        //MARK:- SaturdayButton Check Unchek in tableviewcell

        if self.arraddress[indexPath.row]["is_saturday"] as! String == "No"{
            cell.btn_saturday.setImage(UIImage(named: "checkBox_unfilled"), for: .normal )
        }else{
            
            cell.btn_saturday.setImage(UIImage(named: "checkBox_filled"), for: .normal)
        }
        
        cell.btn_saturday.addTarget(self, action: #selector(self.button_saturday), for: .touchUpInside)
        cell.btn_saturday.tag = indexPath.row
        
        //MARK:- SundayButton Check Uncheck in tableviewcell
        
        if self.arraddress[indexPath.row]["is_sunday"] as! String == "No"{
            cell.btn_sunday.setImage(UIImage(named: "checkBox_unfilled"), for: .normal )
        }else{
            
            cell.btn_sunday.setImage(UIImage(named: "checkBox_filled"), for: .normal)
        }
        
        cell.btn_sunday.addTarget(self, action: #selector(self.button_sunday), for: .touchUpInside)
        cell.btn_sunday.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
    
    
    @objc func btn_remove(_ sender: UIButton) {

        let addressId = self.arraddress[sender.tag]["id"] as! String
        self.delete_addressapi(selectedAddressId: addressId)
    }
    @objc func add_newaddress(_ sender: UIButton) {
    
        let vc1 = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "newaddressvc") as? NewaddressVC)!
        vc1.dictedit = self.arraddress[sender.tag]
        vc1.isFrom = "Edit"
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    //MARK:- Button Check Action
    
    @objc func buttonClick (sender : UIButton) {
        
        for i in 0..<self.arrCheckUncheck.count{
            self.arrCheckUncheck[i] = "Uncheck"
        }
        self.arrCheckUncheck[sender.tag] = "Check"
        self.btn_deliver.isSelected = true
        self.btn_deliver.layer.backgroundColor = CGColor(srgbRed: 0.782, green: 0.301, blue: 0.049, alpha: 1.0)
        self.tableview.reloadData()
    }

    //MARK:- SaturdayButton Action

    @objc func button_saturday (sender : UIButton) {

//        if self.saturdayCheckUncheck[sender.tag] == "Check"{
//            self.saturdayCheckUncheck[sender.tag] = "Uncheck Staurday"
//        }else{
//            for i in 0..<self.arraddress.count{
//                self.saturdayCheckUncheck[i] = "Uncheck Staurday"
//            }
//            self.saturdayCheckUncheck[sender.tag] = "Check"
//        }
//        self.tableview.reloadData()

    }
    //MARK:- SundayButton Action

    @objc func button_sunday (sender : UIButton) {

//        if self.sundayCheckUncheck[sender.tag] == "Check"{
//            self.sundayCheckUncheck[sender.tag] = "Uncheck Sunday"
//        }else{
//            for i in 0..<self.arrCheckUncheck.count{
//                self.sundayCheckUncheck[i] = "Uncheck Sunday"
//            }
//            self.sundayCheckUncheck[sender.tag] = "Check"
//        }
//        self.tableview.reloadData()
    }
    
//MARK:- API call manage_address
    
    func callApi(){
        var params = [String:Any]()
    
   let UserToken:String = UserDefaults.standard.value(forKey: "LoginToken") as! String
        print("Login user token = ",UserToken)

        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer/manage_address")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserToken, forHTTPHeaderField: "token")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        print(response!)
        do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
         //  print(json)
        if json["status"]! as! String == "error"{
        print("Error = ",json["message"]! as Any)

        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "ALERT", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            }
            }else{
            print("Data = ",json["data"] as Any)
                    
        self.arrCheckUncheck.removeAll()
//        self.saturdayCheckUncheck.removeAll()
//        self.sundayCheckUncheck.removeAll()
        self.arraddress.removeAll()
                    
        let addressArray = json["data"] as! [[String:Any]]
        self.arraddress = addressArray
            for i in 0..<self.arraddress.count{
                self.arrCheckUncheck.append("Uncheck")
//                let saturday = self.arraddress[i]["is_saturday"] as! String
//                if saturday == "Yes"{
//                    self.saturdayCheckUncheck[i] = "Check"
//                }else{
//                    self.saturdayCheckUncheck[i] = "Uncheck Staurday"
//                }
//
//                self.saturdayCheckUncheck.append("Uncheck Staurday")
//                self.sundayCheckUncheck.append("Uncheck Sunday")
            }
        DispatchQueue.main.async {
        self.tableview.reloadData()
        }
           }
            } catch {
                print("error")
            }
        })
        task.resume()
        }

    func showAlert(title: String, message: String)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
           self.present(alertController, animated: true, completion: nil)
       }
       
    
    //MARK:- Delete address API
    
    func delete_addressapi(selectedAddressId:String){
        var params = [String:Any]()
        params["address_id"] = selectedAddressId
        
        let UserToken:String = UserDefaults.standard.value(forKey: "LoginToken") as! String
        print("Login user token = ",UserToken)
        
        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer/delete_address")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserToken, forHTTPHeaderField: "token")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
           print(response!)
            do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                //  print(json)
        if json["status"]! as! String == "error"{
            print("Error = ",json["message"]! as Any)
                    
            DispatchQueue.main.async {
        let alertController = UIAlertController(title: "ALERT", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
                    }
        }else{
                   
        print("Data = ",json["data"] as Any)
            DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Alert", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            self.callApi()
                    }
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
    
    
    @IBAction func addNewAddress(_ sender: Any) {
        
        let vc2 = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "newaddressvc") as? NewaddressVC)!
        vc2.isFrom = "Add"
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
}
