//
//  Table_View.swift
//  Myfist_App
//
//  Created by sonu on 11/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit
import Alamofire

class Table_View: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    var arrSalonNames = ["1 Salon","2 Salon","3 Salon","4 Salon","5 Salon","6 Salon","7 Salon"]
    var arrUpcomingSalonNames = ["1 Upcoming Salon","2 Upcoming Salon","3 Upcoming Salon","4 Upcoming Salon","5 Upcoming Salon","6 Salon Upcoming","7 Salon Upcoming" ]
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnhistory: UIButton!
    @IBOutlet weak var btnupcoming: UIButton!
  
    var dictaddress = [String:Any]()
//    var arraddress = [[String:Any]]()
    var arrhistory = [[String: Any]] ()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           self.btnhistory.isSelected = true
     
       self.callApi()
       }
    
        @IBAction func History_btn(_ sender: Any) {
        if self.btnhistory.isSelected == true {
        }
        else{
            self.btnhistory.isSelected = true
            self.btnupcoming.isSelected = false
            self.tableview.reloadData()
            }
        }
    
    @IBAction func btn_upcoming(_ sender: Any) {
        if self.btnupcoming.isSelected == true{
            
        }
        else{
            self.btnupcoming.isSelected = true
            self.btnhistory.isSelected = false
            self.tableview.reloadData()
        }
    }
    
    //MARK:- popViewcontroller
    
    @IBAction func my_booking_back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
   
    
    //MARK:- UITableView DataSourse and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.btnhistory.isSelected == true {
            return self.arrhistory.count
          //  return self.arrSalonNames.count
        }
        else{
            return self.arrUpcomingSalonNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.btnhistory.isSelected == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            let salonDetails = self.arrhistory[indexPath.item]
             cell.lbl_SalonName.text = salonDetails["business_name"] as? String
             cell.lbl_Location.text = salonDetails["price"] as? String
             let imgurl = URL(string: (self.arrhistory[indexPath.row]["image"] as! String))
            cell.img_view.sd_setImage(with: imgurl, placeholderImage: UIImage(named: "profile_icon"))
            return cell
            }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell
            cell.lbl_UpcomingSalonName.text = self.arrUpcomingSalonNames[indexPath.row]
            return cell
        }
    }
     
  func callApi(){
         var params = [String:Any]()
             params["language_id"] = "1"
             params["page"] = 1
             params["limit"] = 10
            
        let UserToken:String = UserDefaults.standard.value(forKey: "LoginToken") as! String
        print("Login user token = ",UserToken)

        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer/online_booking_history")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserToken, forHTTPHeaderField: "token")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        print(response!)
        do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        print("aditya =",json)
        if json["status"]! as! String == "error"{
        print("Error = ",json["message"]! as Any)
                    
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "History", message: json["message"]! as? String, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            }
            }else{
            print("Data = ",json["data"] as Any)
            self.arrhistory.removeAll()
        let historyArray = json["data"] as! [[String:Any]]
        self.arrhistory = historyArray
            for i in 0..<self.arrhistory.count{

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

 

}
