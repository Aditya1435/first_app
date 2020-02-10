//
//  TableViewCell.swift
//  Myfist_App
//
//  Created by sonu on 11/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var img_view: UIImageView!
    
    @IBOutlet weak var lbl_SalonName: UILabel!
    
    @IBOutlet weak var lbl_Location: UILabel!
    
    @IBOutlet weak var lbl_SPA: UILabel!
    
    @IBOutlet weak var lbl_Price: UILabel!
    
    @IBOutlet weak var lbl_Date: UILabel!
    
    
    @IBOutlet weak var btn_Booking: UIButton!
    
    // For upcomint cell
        @IBOutlet weak var lbl_UpcomingSalonName: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
