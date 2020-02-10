//
//  MyAddresssCell.swift
//  Myfist_App
//
//  Created by sonu on 24/01/20.
//  Copyright © 2020 sonu. All rights reserved.
//

import UIKit

class MyAddresssCell: UITableViewCell {

    @IBOutlet var btn_check: UIButton!
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_address: UILabel!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var lbl5: UILabel!
    @IBOutlet var lbl6: UILabel!
    @IBOutlet var address2: UILabel!
    @IBOutlet var ZipCode: UILabel!
    @IBOutlet var lbl_Weekend: UILabel!
    @IBOutlet var btn_saturday: UIButton!
    @IBOutlet var lbl_saturday: UILabel!
    @IBOutlet var btn_sunday: UIButton!
    @IBOutlet var lbl_sunday: UILabel!
    @IBOutlet var lbl7: UILabel!
    @IBOutlet var btn_delete: UIButton!
    @IBOutlet var edit_address: UIButton!
        
    var Name : String = ""
    var Address1 : String = ""
    var Address2 : String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          }
    
}
