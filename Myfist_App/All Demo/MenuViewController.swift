//
//  MenuViewController.swift
//  Myfist_App
//
//  Created by sonu on 25/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//
    
import UIKit

enum MenuType : Int {
    case cut
    case Profile
    case sampoo
}
class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let menutype = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true ) {
            print("DisMissing: \(menutype)")
        }
    }

}
