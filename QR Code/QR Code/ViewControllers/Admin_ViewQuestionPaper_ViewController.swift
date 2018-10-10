//
//  Admin_ViewQuestionPaper_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Admin_ViewQuestionPaper_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var mytableview: UITableView!
    @IBOutlet weak var btnaddnewquestionpaper: UIButton!
    var questionpaper: [String] = []
    var qid: [String]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionpaper.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        cell?.textLabel?.text = questionpaper[indexPath.row]
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mytableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnaddnewquestionpaper.layer.cornerRadius = 5
        mytableview.dataSource = self
        //.layer.cornerRadius = 5
        
        APIRequest.doRequestForJson(method: .GET, queryString: "questionpapermaster_select.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                print(json)
                //    parseDataDel(res: [json])
                // self.parseData(res: json)
                // self.parsdata(result: json)
            }
            
            // Do any additional setup after loading the view.
        }
        // Do any additional setup after loading the view.
    }
    
    func parseData(res : [[String:Any]])
    {
        for i in res
        {
            let id = i["qid"] as? String
            let name = i["setname"] as? String
            qid = [id!]
            questionpaper.append(name!)
            
        }
       mytableview.reloadData()
        
    }
    
    @IBAction func btnaddnewquespaper(_ sender: UIButton) {
        performSegue(withIdentifier: "FromAdmin_ViewQuestionPaperViewControllerToAdd_QuestionPaper_Master_ViewController", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "FromAdmin_ViewQuestionPaperViewControllerToAdd_QuestionPaper_Master_ViewController"
//        {
//            if let vc = segue.destination as? Add_QuestionPaper_Master_ViewController {
//            //    vc.qid = self.[qid!]
//        }
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
