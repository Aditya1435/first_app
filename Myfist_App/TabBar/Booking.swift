//
//  Booking.swift
//  Myfist_App
//
//  Created by sonu on 03/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Booking: UIViewController {

    @IBOutlet weak var btn_goback: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_goback.layer.borderWidth = 1
        btn_goback.layer.borderColor = CGColor(srgbRed: 0.800, green: 0.310, blue: 0.042, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    

    

}
