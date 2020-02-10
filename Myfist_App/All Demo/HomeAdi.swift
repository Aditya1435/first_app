//
//  Adi.swift
//  Myfist_App
//
//  Created by sonu on 12/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class HomeAdi: UIViewController {
 
    
    @IBOutlet var eette: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didtapMenu(_ sender: UIBarButtonItem) {
        guard let menuviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") else {
            return        }
 present(menuviewcontroller, animated: true)
         
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
