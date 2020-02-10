//
//  VC_Daily.swift
//  Myfist_App
//
//  Created by sonu on 21/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class VC_Daily: UIViewController {

    @IBOutlet var imgdetail: UIImageView!
    @IBOutlet weak var lbl_count: UILabel!
    @IBOutlet weak var hart: UIButton!
    @IBOutlet var lbl_price: UILabel!
    @IBOutlet var cart: UIButton!
    @IBOutlet weak var btn_add1: UIButton!
    @IBOutlet var detail_mg: UILabel!
    @IBOutlet var txtview_detail: UITextView!
    @IBOutlet var brand_name: UILabel!
    @IBOutlet var cream_name: UILabel!
    @IBOutlet var lbl_colour: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var pro_des_name: UILabel!
    @IBOutlet var brand_lbl: UILabel!
    @IBOutlet var lbl_code: UILabel!
    @IBOutlet var product_weight: UILabel!
    
    
    var selectedSlug = ""
    var totleitem = ""
    var productCost = 0.0
    var detailimg = [[String: Any]] ()
    var alldetal = [[String: Any]] ()
    
     var service_category_list = [[String: Any]] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_count.text = "1"
        self.totleitem = self.lbl_count.text!
     
        
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.ApiForDetails()
    }
    
    func ApiForDetails(){
        var parameters = [String:Any]()
            parameters["language_id"] = "1"
            parameters["cart_id"] = ""
            parameters["slug"] = self.selectedSlug
            
        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/product/detail")!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                   
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                   
            print(response!)
        do {
                          
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
               print("Product List = ",json)
        if json["status"]! as! String == "success"{
           let products = json["data"] as! [String: Any]
            print("arrsalon = ",self.detail_mg)

            DispatchQueue.main.async {
            self.cream_name.text = products["name"] as? String
            self.brand_lbl.text = products["name"] as? String
            self.lbl_code.text = products["code"] as? String
            self.detail_mg.text = products["weight"] as? String
            self.product_weight.text = products["weight"] as? String
            self.date.text = products["expiry_date"] as? String
            self.pro_des_name.text = products["product_id"] as? String
            self.lbl_price.text = products["price"] as? String
            self.txtview_detail.text = products["specification"] as? String
        let imgurl = URL(string: products["image"] as! String)
            self.imgdetail.sd_setImage(with: imgurl, placeholderImage: UIImage(named: "profile_icon"))
                                   
            }
                } else {
                } }
          } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
                       }
                   })
              task.resume()
    }
    
    @IBAction func btn_hart(_ sender: Any) {
    //    is_favourite
        if self.hart.isSelected == false {
           self.hart.isSelected = true
           hart.setImage(UIImage.init(named: "heart_colored"), for: .selected)
        } else {
            self.hart.isSelected = false
        }
    }

    @IBAction func btn_cart(_ sender: Any) {
    if self.cart.isSelected == false {
       self.cart.isSelected = true
       cart.setImage(UIImage.init(named: "cart_selected"), for: .selected)
        } else {
            self.cart.isSelected = false
        }
    }
    @IBAction func btn_Sub(_ sender: Any) {
        if lbl_count.text == "1"{
            self.productCost = Double(self.lbl_price.text!) as! Double
            
        } else {
                var totlesub : Int = Int(totleitem)!
                totlesub = totlesub - 1
                self.lbl_count.text = String(totlesub )
                self.totleitem = self.lbl_count.text!
            
                var subprice = totlesub
                subprice = totlesub * Int(self.productCost)
                self.lbl_price.text = String(subprice)

            }
        }
                             
     @IBAction func btn_Add(_ sender: Any) {
        var totlecount : Int = Int(totleitem)!
         totlecount = totlecount + 1
        
        self.lbl_count.text = String(totlecount )
        self.totleitem = self.lbl_count.text!

        if totlecount == 2 {
            self.productCost = Double(self.lbl_price.text!)!
        }
        var totle_price = totlecount
        totle_price = totlecount * Int((self.productCost))
        self.lbl_price.text = String(totle_price)

    }
    @IBAction func backbtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
}
