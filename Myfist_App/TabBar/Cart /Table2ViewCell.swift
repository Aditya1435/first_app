 //
//  Table2ViewCell.swift
//  Myfist_App
//
//  Created by sonu on 11/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Table2ViewCell: UITableViewCell {

    @IBOutlet weak var img2cart: UIImageView!
    @IBOutlet weak var lbl_DailyBeauty: UILabel!
    @IBOutlet weak var lbl_cart_price: UILabel!
    @IBOutlet weak var btn_sub: UIButton!
    @IBOutlet weak var lbl_count: UILabel!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
      var totleItem = ""
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
