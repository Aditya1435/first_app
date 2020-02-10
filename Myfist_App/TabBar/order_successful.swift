//
//  order_successful.swift
//  Myfist_App
//
//  Created by sonu on 03/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class order_successful: UIViewController {

    @IBOutlet weak var btn_order_successful: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_order_successful.layer.borderWidth = 1
        btn_order_successful.layer.borderColor = CGColor(srgbRed: 0.800, green: 0.310, blue: 0.042, alpha: 1.0)
        
        
        // Do any additional setup after loading the view.
    }
    

   

}
