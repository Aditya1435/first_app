//
//  Table2Controller.swift
//  Myfist_App
//
//  Created by sonu on 11/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Table2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dictSalons = [String:Any]()
    var arrSalons = [[String:Any]]()
    @IBOutlet weak var cart_table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0..<10{
            self.dictSalons.removeAll()
            self.dictSalons["salonName"] = "\(i+1) Salon"
            self.dictSalons["productQuantity"] =  1
            self.dictSalons["price"] = "$30"
            self.arrSalons.append(self.dictSalons)
        }
        self.cart_table.reloadData()
    }

    @IBAction func cart_back(_ sender: Any) {

        print("enter cart button")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSalons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Table2ViewCell
        cell.lbl_DailyBeauty.text = self.arrSalons[indexPath.row]["salonName"] as? String
        cell.lbl_cart_price.text = self.arrSalons[indexPath.row]["price"] as? String
        let price = self.arrSalons[indexPath.row]["productQuantity"] as? Int
        cell.lbl_count.text = String(price!)

        cell.btn_add.addTarget(self, action: #selector(self.add_count), for: .touchUpInside)
        cell.btn_add.tag = indexPath.row

        cell.btn_sub.addTarget(self, action: #selector(self.sub_count), for: .touchUpInside)
        cell.btn_sub.tag = indexPath.row

        cell.btn_delete.addTarget(self, action: #selector(self.btn_remove), for: .touchUpInside)
        cell.btn_delete.tag = indexPath.row

       return cell
    }

 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }

    // MARK:- click on UIButton cell delete

    @objc func btn_remove(_ sender: UIButton) {
      self.arrSalons.remove(at: sender.tag)
      self.cart_table.reloadData()

    }
 
// MARK:- tableviewcell delete cell

       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == UITableViewCell.EditingStyle.delete {
       arrSalons.remove(at: indexPath.row)
       tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                  }
              }
  
    @IBAction func add_count(_ sender: UIButton) {

         let indexPath = IndexPath(row: sender.tag, section: 0)
         let cell = cart_table.cellForRow(at: indexPath) as! Table2ViewCell
         var cellCount:Int = Int(cell.lbl_count.text!)!
         cellCount += 1

         var dictDetails = self.arrSalons[sender.tag]
         dictDetails["productQuantity"] = cellCount

         self.arrSalons.remove(at: sender.tag)
         self.arrSalons.insert(dictDetails, at: sender.tag)

         self.cart_table.reloadData()

      }
    
    @IBAction func sub_count(_ sender: UIButton) {

        let indexPath = IndexPath(row: sender.tag , section: 0)
        let cell = cart_table.cellForRow(at: indexPath) as! Table2ViewCell
        if cell.lbl_count.text == "1" {

        }else {
               var cellCount:Int = Int(cell.lbl_count.text!)!
               cellCount -= 1
               var dictDetails = self.arrSalons[(sender as AnyObject).tag]
               dictDetails["productQuantity"] = cellCount

               self.arrSalons.remove(at: sender.tag)
               self.arrSalons.insert(dictDetails, at: sender.tag )

               self.cart_table.reloadData()
        }
    }
}
