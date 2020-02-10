//
//  ProfileVC.swift
//  Myfist_App
//
//  Created by sonu on 17/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
     var info_list = ["Booking","Orders","Reset Password"]
     var Name : String = ""
     var Email : String = ""
     var Number : String = ""
    
    @IBOutlet weak var Table_Profile: UITableView!
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_Email: UILabel!
    @IBOutlet var lbl_Number: UILabel!
           
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lbl_Name.text = UserDefaults.standard.string(forKey: "name")
        lbl_Email.text = UserDefaults.standard.string(forKey: "email")
        lbl_Number.text = UserDefaults.standard.string(forKey: "number")
        
    }

    //MARK:- UITableView DataSource Method
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return info_list.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Profile_TableViewCell
        let title = self.info_list[indexPath.row]
        cell?.cart_btn.setTitle(title, for: .normal)
        cell?.cart_btn.tag = indexPath.row
        cell?.cart_btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return cell!
     }
    
     //MARK:- UITableView Click index Array Button
    
    @objc func buttonClick (sender : UIButton) {
        let buttonRow = sender.tag
        
        if buttonRow == 0 {
                
        let Booking = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "oder_tableview") as! Table_View
        self.navigationController?.pushViewController(Booking, animated: true)
            } else
                if buttonRow == 1 {
           
                let MyOder = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "myorders") as! My_orders
                self.navigationController?.pushViewController(MyOder, animated: true)
            } else
            
            if buttonRow == 2 {
                let ResetPassword = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "2viewcontroller") as! SecondViewController
                self.navigationController?.pushViewController(ResetPassword, animated: true)
            }

    }

    //MARK:- TableView Height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func Edit_VC(_ sender: UIButton) {
        
        let edit_profile = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileEdit") as! Profile_Edit
        
             self.navigationController?.pushViewController(edit_profile, animated: true)

    }

    @IBAction func logout(_ sender: Any) {
       
        let logout = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "3thViewController") as! ThardViewController
                         self.navigationController?.pushViewController(logout, animated: true)
        
        
        
    }
}
   
