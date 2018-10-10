//
//  QRCode_NotSend_ProfileViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 03/10/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class QRCode_NotSend_ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell?.textLabel?.text = name[indexPath.row]
        //cell?.textLabel?.text = scheduledStudents[indexPath.row]
        return cell!
    }
    
    var name:[String] = []
    var photo:[String] = []
    var no:[String] = []
    var cname:[String] = []
    var email:[String] = []
    var lid:[String] = []
   
    var fname = ""
    var lname = ""
    var photos = ""
    var cno = ""
    var clid = ""
    var semail = ""
    var technology = ""

    @IBOutlet weak var mytablwview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytablwview.dataSource = self
        mytablwview.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        name.removeAll()
        APIRequest.doRequestForJson(method: .GET, queryString: "QRCode_not_send.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                print(json)
            }
            self.mytablwview.reloadData()
            // Do any additional setup after loading the view.
        }
    }
    
    func parseData(res : [[String:Any]])
    {
        for i in res
        {
            let firstname1 = i["firstname"] as? String
            let lastname1 = i["lastname"] as? String
            let email1 = i["email"] as? String
            let photo1 = i["photo"] as? String
            let no1 = i["no"] as? String
            let lid1 = i["lid"] as? String
            let cname1 = i["cname"] as? String
            
       
            name.append(firstname1! + " " + lastname1!)
            photo.append(photo1!)
            no.append(no1!)
            cname.append(cname1!)
            lid.append(lid1!)
            email.append(email1!)
            
        }
        mytablwview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photos = photo[indexPath.row]
        fname = name[indexPath.row]
        clid = lid[indexPath.row]
        semail = email[indexPath.row]
        cno = no[indexPath.row]
        technology = cname[indexPath.row]
        
        performSegue(withIdentifier: "FromQRCode_not_SendToSendQRCode_ViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! SendQRCode_ProfileViewController
        vc.fname = fname
        vc.photo = photos
        vc.lid = clid
        vc.email = semail
        vc.cno = cno
        vc.technology = technology
        
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
