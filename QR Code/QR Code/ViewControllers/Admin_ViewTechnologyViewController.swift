//
//  Admin_ViewTechnologyViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 19/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class Admin_ViewTechnologyViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var mycollection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return technology.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! Admin_ViewTechnologyCollectionViewCell
        
        cell.lbltechnology.text = technology[indexPath.row]
        return cell
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        APIRequest.doRequestForJson(method: .GET, queryString: "select_TechnologyAPI.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                print(json)
                self.parseData(res: json)
                // self.parsdata(result: json)
            }
            
            
            
            // Do any additional setup after loading the view.
        }
        self.mycollection.reloadData()
    }
    

    var technology: [String] = []
    @IBOutlet weak var btnaddnewtechnology: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnaddnewtechnology.layer.cornerRadius = 5
        mycollection.dataSource = self
        
//        APIRequest.doRequestForJson(method: .GET, queryString: "select_TechnologyAPI.php", parameters: [:] , showLoading: true) { (response, err) in
//            if let json = response as? [[String:Any]]
//            {
//                print(json)
//                self.parseData(res: json)
//                // self.parsdata(result: json)
//            }
//
//
//
//        // Do any additional setup after loading the view.
//        }
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
    
    func parseData(res : [[String:Any]])
    {
        technology.removeAll()
        for i in res
        {
            let name = i["cname"] as? String
            technology.append(name!)
        }
        mycollection.reloadData()
    }
    
    @IBAction func btnaddtechnology(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
