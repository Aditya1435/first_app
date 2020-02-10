//
//  TabBarView.swift
//  Myfist_App
//
//  Created by sonu on 18/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class TabBarView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet var lbl_location: UILabel!
    
    var locationManager : CLLocationManager = CLLocationManager()
    var selectedLatitude = ""
    var selectedLongitude = ""
    
    var arrsalon = [[String: Any]] ()
    var service_category_list = [[String: Any]] ()
    override func viewDidLoad() {
        super.viewDidLoad()
            collection.dataSource = self
            collection.delegate = self
        
            collection2.dataSource = self
            collection2.delegate = self

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collection.frame.size.width - 40)/4, height: (self.collection.frame.size.height)/2)
        self.collection.collectionViewLayout = layout
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout2.itemSize = CGSize(width: (self.collection2.frame.size.width - 20)/2, height: self.collection2.frame.size.height)
        layout2.scrollDirection = .horizontal

        self.collection2.collectionViewLayout = layout2

    //MARK:- location
      if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        category()
        }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        /* you can use these values*/
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        print("Latitude =",lat)
        print("Longitude = ",long)
        self.selectedLatitude = "\(lat)"
        self.selectedLongitude = "\(long)"
        
        let locationsss = CLLocation(latitude: lat, longitude: long)
        locationsss.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)  // Rio de Janeiro, Brazil
            self.lbl_location.text = city + ", " + country
            self.serviceAPI()
        }
    }

  // MARK:- UICollectionview Datasource Method -
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collection{
                return self.service_category_list.count
        }else{
            return self.arrsalon.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            let salondetails = self.service_category_list[indexPath.item]
             cell.lbl.text = salondetails["category_name"] as? String
             cell.isUserInteractionEnabled = true
            let imageurl = URL(string: (self.service_category_list[indexPath.row]["image"] as! String))
             cell.imgAll.sd_setImage(with: imageurl, placeholderImage: UIImage(named: "hairspa_icon"))
            return cell
        
        }else{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            let salonDetails = self.arrsalon[indexPath.item]
            cell.lbl2.text = salonDetails["business_name"] as? String
            cell.lbl3.text = (salonDetails["distance_miles"] as? String)! + "Km"
            let imgurl = URL(string: (self.arrsalon[indexPath.row]["banner_image"] as! String))
            cell.img2.sd_setImage(with: imgurl, placeholderImage: UIImage(named: "profile_icon"))

        //MARK:- Cell HartButton(is_favourite)
            
            if self.arrsalon[indexPath.item]["is_favourite"] as! String == "No"{
            cell.btn_hart.setImage(UIImage(named: "heart_white"), for: .normal )
            }else{
            cell.btn_hart.setImage(UIImage(named: "heart_colored"), for: .normal)
            }
            cell.btn_hart.addTarget(self, action: #selector(self.button_hart), for: .touchUpInside)
            cell.btn_hart.tag = indexPath.item
            
            return cell
        }
    }
          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeview") as? Home_Turning
            self.navigationController?.pushViewController(vc!, animated: true)
    }
    
       @objc func button_hart (sender : UIButton) {

        
        if self.arrsalon[sender.tag]["is_favourite"] as! String == "No"{
           self.arrsalon[sender.tag]["is_favourite"]  = "Yes"
             }else{

            self.arrsalon[sender.tag]["is_favourite"]  = "No"
            }
            self.collection2.reloadData()
    }
    // MARK:- UICollectionview API Call -

    func category() {
    var parameters = [String:Any]()
        parameters["language_id"] = "1"

    var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/services/service_category_list")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        print("Recived data = ",response as Any)
    do {
    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        print("salon List = ",json)
    if json["status"]! as! String == "success"{
    self.service_category_list = json["data"] as! [[String: Any]]
        print("arrsalon = ",self.service_category_list)
        DispatchQueue.main.async {
        self.collection.reloadData()
            }
            }
    else {
         }
        } catch {
        print("error")
                }
            })
        task.resume()
                    }

    func serviceAPI() {
        var parameters = [String:Any]()
            parameters["language_id"] = "1"
            parameters["page"] = 1
            parameters["limit"] = 10
            parameters["location"] = self.lbl_location.text
            parameters["latitude"] = self.selectedLatitude
            parameters["longitude"] = self.selectedLongitude

        var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/customer_service/salon_list")!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print("Recived data = ",response as Any)
                do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print("salon List = ",json)
                    if json["status"]! as! String == "success"{
                    self.arrsalon = json["data"] as! [[String: Any]]
                    print("arrsalon = ",self.arrsalon)
                              
                    DispatchQueue.main.async {
             
                    self.collection2.reloadData()
                        }
                    }
                    else {
                    }
                    } catch {
                            print("error")
                        }
                    })
               task.resume()
            }
   
    //MARK:- Segue Login
    
    @IBAction func Login_View(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
