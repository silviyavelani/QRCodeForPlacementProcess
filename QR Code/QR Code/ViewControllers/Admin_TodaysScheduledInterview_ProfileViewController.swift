//
//  Admin_TodaysScheduledInterview_ProfileViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 20/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Admin_TodaysScheduledInterview_ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var lid:String?
    var scheduledStudents:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        cell?.textLabel?.text = scheduledStudents[indexPath.row]
        return cell!
    }
    
    
    @IBOutlet weak var mytableview: UITableView!
    @IBOutlet weak var btnsendqrcode: UIButton!
    @IBOutlet weak var btnschedulenewinterview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableview.dataSource = self
        btnsendqrcode.layer.cornerRadius = 5
        btnschedulenewinterview.layer.cornerRadius = 5
        APIRequest.doRequestForJson(method: .GET, queryString: "scheduled_interview_students_select.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                print(json)
                //    parseDataDel(res: [json])
                // self.parseData(res: json)
                // self.parsdata(result: json)
            }
            print(self.scheduledStudents)
            // Do any additional setup after loading the view.
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APIRequest.doRequestForJson(method: .GET, queryString: "scheduled_interview_students_select.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                print(json)
                //    parseDataDel(res: [json])
                // self.parseData(res: json)
                // self.parsdata(result: json)
            }
            print(self.scheduledStudents)
            // Do any additional setup after loading the view.
        }
    }
    
    func parseData(res : [[String:Any]])
    {
        scheduledStudents.removeAll()
        for i in res
        {
            let id = i["lid"] as? String
            let fname = i["firstname"] as? String
            let lname = i["lastname"] as? String
            lid = id!
            let name = fname! + " " + lname!
            scheduledStudents.append(name)
            
        }
        print(scheduledStudents)
        mytableview.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
