//
//  demo.swift
//  Myfist_App
//
//  Created by sonu on 06/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class demo: UIViewController {
    
    var arrRecord = [[String:Any]]()
    var dict1: [String:Any] = [:]
    var dict2: [String:Any] = [:]
    var dict3: [String:Any] = [:]
    @IBOutlet weak var txt1: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        dict1["name"] = "Aditya"
        dict1["age"] = 26
        dict1["Phone"] = 1256652

        dict2["name"] = "Vikas"
        dict2["age"] = 28
        dict2["Phone"] = 1256652

        dict3["name"] = "Rajesh"
        dict3["age"] = 27
        dict3["Phone"] = 1256652
        
        self.arrRecord.append(dict1)
        self.arrRecord.append(dict2)
        self.arrRecord.append(dict3)
        
        print("\n First Records = ",self.arrRecord[0])
        print("\n Second Records = ",self.arrRecord[1])
        print("\n Theard Records = ",self.arrRecord[2])

        print("Name of first record = ",self.arrRecord[0]["name"] ?? arrRecord)
   
    }
    
    @IBAction func btn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "aditya") as? HomeAdi
          
        self.navigationController?.pushViewController(vc!, animated: true)
          
        
        print("dict")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
