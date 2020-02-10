//
//  Home_Turning.swift
//  Myfist_App
//
//  Created by sonu on 02/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Haircut_list {
    var title_name: String?
    var sub_name : [String]?
    init(title_name: String, sub_name: [String]) {
        self.title_name = title_name
        self.sub_name = sub_name
    }
}

class Home_Turning: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var collection_home: UICollectionView!
  
    @IBOutlet weak var tablevc: UITableView!
    var haircut_list = [Haircut_list]()
    let img3 = ["all_icon" , "all_icon", "all_icon", "all_icon"]
    
         let items_2 = ["All" , "Face", "Hair", "Nall"]
    @IBOutlet weak var btn_back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection_home.delegate = self
        collection_home.dataSource = self
        tablevc.delegate = self
        tablevc.dataSource = self
        
          let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              layout2.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
              layout2.itemSize = CGSize(width: (self.collection_home.frame.size.width - 100)/2, height: self.collection_home.frame.size.height/1)
              layout2.scrollDirection = .horizontal

          self.collection_home.collectionViewLayout = layout2
        
        haircut_list.append(Haircut_list.init(title_name: "Haircut (3)", sub_name: ["Bangs Cut","Blow Dry", "Haircut"]))
        haircut_list.append(Haircut_list.init(title_name: "Scalp Treatments (2)", sub_name: ["Detox for the scaip","Anti-dandruff treatment"]))
    }

    //MARK:- UICollectionViewDataSource Method protocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.img3.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeViewCell
                cell.lbl_home.text = self.items_2[indexPath.item]
                cell.img_home.image = UIImage(named: self.img3[indexPath.item])
                return cell
       }

    @IBAction func btn_cell(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
}
    //MARK:- Etension

extension Home_Turning : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return haircut_list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return haircut_list[section].sub_name?.count ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = haircut_list[indexPath.section].sub_name?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return haircut_list[section].title_name
    }

}
