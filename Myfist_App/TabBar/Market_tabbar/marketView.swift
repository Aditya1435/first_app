//
//  marketView.swift
//  Myfist_App
//
//  Created by sonu on 21/11/19.
//  Copyright © 2019 sonu. All rights reserved.
//

import UIKit

class marketView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pagecontrole: UIPageControl!
    @IBOutlet weak var market_collection: UICollectionView!
    
    var timer: Timer?
    let img = ["demo_product" , "appicon", "demo_product", "appicon", "demo_product", "appicon", "demo_product", "appicon"]

    var marketplace = [[String: Any]] ()
    var detailimg = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self 
        market_collection.dataSource = self
        market_collection.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.market_collection.frame.size.width - 20)/2, height: (self.market_collection.frame.size.height/2))
        self.market_collection.collectionViewLayout = layout
        
        pagecontrole.numberOfPages = img.count
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout2.itemSize = CGSize(width: (self.collectionView.frame.size.width), height: self.collectionView.frame.size.height)
        layout2.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout2
        self.collectionView.isPagingEnabled = true
        collectionView.reloadData()
        startTimer()
        marketPlace()
    }
    
    //MARK:- UICollectionViewDataSource Protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
           return self.img.count
        }else{
            return  self.detailimg.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellmarket", for: indexPath) as! marketpageCell
            cell.img_View.image = UIImage(named: img[indexPath.item])
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell3
            let product = self.detailimg[indexPath.item]
                cell.lbl_market.text = product["name"] as? String
                cell.lbl_market2.text = product["price"] as? String
            let imgurl = URL(string: (self.detailimg[indexPath.row]["image"] as! String))
                cell.img_Market.sd_setImage(with: imgurl, placeholderImage: UIImage(named: "profile_icon"))
            
//            if self.detailimg[indexPath.item][ "is_market_place"] as! String == "null"{
//                cell.btn_cart.setImage(UIImage(named: "cart_icon"), for: .normal)
//            }else {
//                cell.btn_cart.setImage(UIImage(named: "cart_selected"), for: .normal)
//            }
//            cell.btn_cart.addTarget(self, action: #selector(self.button_cart), for: .touchUpInside)
//            cell.btn_cart.tag = indexPath.item
            
                return cell
        }
    }
    
    
//    
//    @objc func button_cart (sender : UIButton) {
//
//          if self.detailimg[sender.tag]["is_market_place"] as! String == "null"{
//             self.detailimg[sender.tag]["is_market_place"]  = "Yes"
//               }else{
//
//              self.detailimg[sender.tag]["is_market_place"]  = "null"
//              }
//              self.market_collection.reloadData()
//      }
    
    // MARK:- Click on CollectionView Item 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if collectionView == self.collectionView {
        } else {
            let Booking = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Daily_vc") as! VC_Daily
                Booking.selectedSlug = self.detailimg[indexPath.item]["slug"] as! String
            self.navigationController?.pushViewController(Booking, animated: true)
        }
        }

    //MARK:- Timer use pagecontroler
    
        func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
        }

            @objc func scrollAutomatically(_ timer1: Timer) {
            for cell in collectionView.visibleCells {
                if img.count == 1 {
                    return
                }
                let indexPath = collectionView.indexPath(for: cell)!
                if indexPath.row < (img.count - 1) {
                    let indexPath1 = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
                    collectionView.scrollToItem(at: indexPath1, at: .right, animated: true)
                    pagecontrole.currentPage = indexPath1.row
                }
                else {
                    let indexPath1 = IndexPath.init(row: 0, section: indexPath.section)
                    collectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
                    pagecontrole.currentPage = indexPath1.row
                }
             }
          }
    
         func marketPlace() {
            var parameters = [String:Any]()
                parameters["language_id"] = "1"

            var request = URLRequest(url: URL(string: "http://xsdemo.com/bellezayofertas/api/product/marketplace")!)

                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print("Recived data = ",response as Any)
                      do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print("Product List = ",json)
            if json["status"]! as! String == "success"{
            let products = json["data"] as! [String: Any]
                self.detailimg = products["offerPriceProducts"] as! [[String:Any]]
                print("arrsalon = ",self.detailimg)
                DispatchQueue.main.async {
                self.market_collection.reloadData()
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
                }
    


  


