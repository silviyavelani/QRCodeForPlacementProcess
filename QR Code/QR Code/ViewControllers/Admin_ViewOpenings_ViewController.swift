//
//  Admin_ViewOpenings_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Admin_ViewOpenings_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mytableview: UITableView!
    @IBOutlet weak var btnaddnewopening: UIButton!
    var openings: [String] = []
    var number : [String] = []
    var opid = [String]()
    var rid = 0
    var id : IndexPath?
    var msg:String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = tableView.dequeueReusableCell(withIdentifier: "")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        cell?.textLabel?.text = openings[indexPath.row]
        cell?.detailTextLabel?.text = number[indexPath.row]
        return cell!
    }
  
    override func viewWillAppear(_ animated: Bool) {
        APIRequest.doRequestForJson(method: .GET, queryString: "opening_select.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                print(json)
                //    parseDataDel(res: [json])
                // self.parseData(res: json)
                // self.parsdata(result: json)
            }
            self.mytableview.reloadData()
            // Do any additional setup after loading the view.
        }
        mytableview.reloadData()
    }
    
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
        //  print(opid[indexPath.row])
            rid = indexPath.row
            id = indexPath
          let reqDict = ["cid":opid[indexPath.row]]
          APIRequest.doRequestForJson(method: .GET, queryString: "opening_delete.php", parameters: reqDict , showLoading: true) { (response, err) in
              if let json = response as? [String:Any]
               {
                    print(json)
                self.parseDataDel(res: json)
                 //   self.parseData(res: json)
                    // self.parsdata(result: json)
               }

               // Do any additional setup after loading the view.
           }

        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnaddnewopening.layer.cornerRadius = 5
        mytableview.dataSource = self
        //.layer.cornerRadius = 5
    }
        func parseData(res : [[String:Any]])
        {
            openings.removeAll()
            for i in res
            {
                let name = i["cname"] as? String
                let numberofposition = i["noofpositions"] as? String
                let id = i["openid"] as? String
                opid.append(id!)
                openings.append(name!)
                number.append(numberofposition!)
            }
            mytableview.reloadData()
            
        }
        
        func parseDataDel(res : [String:Any])
        {
//            for i in res
//            {
//                let name = i["cname"] as? String
//                let numberofposition = i["noofpositions"] as? String
//                var id = i["openid"] as? String
//                opid.append(id!)
//                openings.append(name!)
//                number.append(numberofposition!)
        
            msg = res["response"] as? String ?? ""
            if msg == "successfully deleted"
            {
                openings.remove(at: rid)
               // tableView.deleteRows(at: [indexPath], with: .automatic)
                mytableview.deleteRows(at: [id!], with: .automatic)
                 mytableview.reloadData()
            }
            
            else{
                AlertView.show(title: "Something went wrong", message: msg, vc: self)
            }
            
        
        }
        
            
        }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


