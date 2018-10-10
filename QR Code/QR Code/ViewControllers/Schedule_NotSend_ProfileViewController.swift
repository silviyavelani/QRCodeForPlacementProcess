//
//  Schedule_NotSend_ProfileViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 03/10/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Schedule_NotSend_ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // retfiurn
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
    var marks:[String] = []
    var lid:[String] = []
   
    var fname = ""
    var lname = ""
    var photos = ""
    var cno = ""
    var smarks = ""
    var semail = ""
    var scname = ""
    var slid = ""
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mytableview.dataSource = self
        mytableview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        name.removeAll()
        APIRequest.doRequestForJson(method: .GET, queryString: "schedualselectprofile.php", parameters: [:] , showLoading: true) { (response, err) in
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
    }
    
    func parseData(res : [[String:Any]])
    {
        for i in res
        {
            let firstname1 = i["firstname"] as? String
            let lastname1 = i["lastname"] as? String
            let photo1 = i["photo"] as? String
            let no1 = i["no"] as? String
            let email1 = i["email"] as? String
            let cname1 = i["cname"] as? String
            let marks1 = i["marks"] as? String
            let lid1 = i["lid"] as? String
//            qid = [id!]
            name.append(firstname1! + " " + lastname1!)
            photo.append(photo1!)
            no.append(no1!)
            cname.append(cname1!)
            marks.append(marks1!)
            email.append(email1!)
            lid.append(lid1!)
            
        }
        mytableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photos = photo[indexPath.row]
        fname = name[indexPath.row]
        cno = no[indexPath.row]
        semail = email[indexPath.row]
        scname = cname[indexPath.row]
        smarks = marks[indexPath.row]
        slid = lid[indexPath.row]
        
        performSegue(withIdentifier: "detailscreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! SendSchedule_ProfileViewController
        vc.fname = fname
        vc.photo = photos
        vc.cno = cno
        vc.email = semail
        vc.technology = scname
        vc.marks = smarks
        vc.lid = slid
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
