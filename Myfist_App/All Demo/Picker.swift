//
//  Picker.swift
//  Myfist_App
//
//  Created by sonu on 12/12/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class Picker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {


    var datePicker = UIDatePicker()
    @IBOutlet var txtfield: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    var imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagepicker.delegate = self
        createdatepicker()
        // Do any additional setup after loading the view.
    }
    @IBAction func onClick(_ sender: Any) {
        imagepicker.sourceType = .savedPhotosAlbum
        imagepicker.allowsEditing = true
    present(imagepicker, animated: true, completion: nil)
       
    }
    func createdatepicker()  {
        datePicker.datePickerMode = .dateAndTime
        let tollbar = UIToolbar()
        tollbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doncac))
        tollbar.setItems([donebtn], animated: false)
        txtfield.inputAccessoryView = tollbar
        txtfield.inputView = datePicker
        
    }
    private let url = URL(string: "http://example.com/")!

    func httpPost(jsonData: Data) {
        if !jsonData.isEmpty {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData

            URLSession.shared.getAllTasks { (openTasks: [URLSessionTask]) in
                NSLog("open tasks: \(openTasks)")
            }

            let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData: Data?, response: URLResponse?, error: Error?) in
                print("\(response)")
            })
            task.resume()
        }
    }
    
    
    
    @objc func doncac()  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtfield.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
//extension Picker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
////
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////        <#code#>
////    }
//
//
//}
