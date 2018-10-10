//
//  User_HomePageViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 18/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class User_HomePageViewController: UIViewController, ScannerViewControllerDelegate, UIPickerViewTextFieldDelegate {
    
    @IBOutlet weak var txtselectfield: UIPickerViewTextField!
    var openings:[String] = []
    
    func doneButtonOnTaped(selectedTextfield: UITextField, name: String?, row: Int) {
        print(name!)
        print(row)
    }
    
    var lid:String?
    var firstname:String?
    var lastname:String?
    var examstatus:String?
    var applystatus:String?
    var qrstatus:String?
    var resumeid:String?
    var photo:String!

    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblfirstname: UILabel!
    @IBOutlet weak var lbllastname: UILabel!
  //  @IBOutlet weak var txtselectfield: UITextField!
    @IBOutlet weak var btnapply: UIButton!
    @IBOutlet weak var btnscan: UIButton!
    @IBOutlet weak var txtlinkedinprofile: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblfirstname.text = ""
        lbllastname.text = ""

        btnscan.layer.cornerRadius = 5
        btnapply.layer.cornerRadius = 5
        
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width / 2
        imgprofile.clipsToBounds = true
        
        self.title = "Scanner"
    
        lid = UserDefaults.standard.value(forKey: Constant.loginId) as? String
        print(lid!)
        
        APIRequest.doRequestForJson(method: .GET, queryString: "opening_select.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parseData(res: json)
                //print(json)
            }
            
            // Do any additional setup after loading the view.
        }
        
        txtselectfield.pickerDelegate = self
        
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width / 2
        imgprofile.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let reqDict = ["lid":lid]
        APIRequest.doRequestForJson(method: .POST, queryString: "check_status_apply_scan.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                self.parsedataDisplay(res: json)
                self.lblfirstname.text = self.firstname!
                self.lbllastname.text = self.lastname!
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnScannerOnClick(_ sender: UIButton) {
        if qrstatus == "1"
        {
        if applystatus == "1"
        {
            if examstatus == "0"
            {
                let reqDict = ["lid":lid]
                APIRequest.doRequestForJson(method: .POST, queryString: "scanupdate.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
                    if let json = response as? [String:Any]
                    {
                        self.parsedataUpdate(res: json)
                        // self.parsedataUpdate(res: [json])
                    }
                }
        performSegue(withIdentifier: "fromUser_HomePageViewControllerToScannerViewController", sender: nil)
    }
        else{
            AlertView.show(title: "Test Completed", message: "You have already given test", vc: self)
            }
            
        }
        else
        {
            AlertView.show(title: "Apply First", message: "You have yet not applied!", vc: self)
            }
    }
            
        else{
            AlertView.show(title: "QR Code Not Recieved", message: "Please wait till admin sends you qrcode! And till then check your mails.", vc: self)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromUser_HomePageViewControllerToScannerViewController"
        {
            let dvc = segue.destination as! ScannerViewController
            dvc.delegate = self
        }
        else if segue.identifier == "fromUser_HomePageViewControllerToQuizViewController"
        {
            let dvc = segue.destination as! QuizefinalViewController
            let qrCode = sender as! String
            dvc.qrCode = qrCode
        }
    }
    
    func getBarCodeReceive(fromCode code: String) {
        print(code)
        performSegue(withIdentifier: "fromUser_HomePageViewControllerToQuizViewController", sender: code)
    }
    
    
    @IBAction func btnlogout(_ sender: UIBarButtonItem) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            RemoveUserDefault.remove()
            UserDefaults.standard.set(false, forKey: Constant.isLoginKey)
            appDelegate.logoutScreen()
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func parseData(res : [[String:Any]])
    {
        for i in res
        {
            let name = i["cname"] as? String
            openings.append(name!)
        }
        txtselectfield.pickerData = openings
     
        
    }
    
    func parsedataDisplay(res: [[String:Any]])
    {
        for i in res
        {
            firstname = i["firstname"] as? String
            lastname = i["lastname"] as? String
            examstatus = i["examstatus"] as? String
            applystatus = i["applystatus"] as? String
            qrstatus = i["qrstatus"] as? String
            resumeid = i["resumeid"] as? String
            photo = i["photo"] as? String
        }
        let reqUrl = URL(string: "https://silviyavelani.000webhostapp.com/Qrapi/" + photo)
        let data = NSData(contentsOf: reqUrl!)
        if data != nil
        {
            imgprofile.image =  UIImage(data:data as! Data)
        }
    }

    
    @IBAction func btnapply(_ sender: UIButton) {
        if applystatus == "0"
        {
            if txtselectfield.text != "" && txtlinkedinprofile.text != ""
            {
                let reqDict = ["lid":lid, "cname":txtselectfield.text , "filepath":txtlinkedinprofile.text]
                APIRequest.doRequestForJson(method: .POST, queryString: "update.php", parameters: reqDict,showLoading: true) { (response, err) in
                    if let json = response as? [String:Any]
                    {
                        self.parsedataUpdate(res: json)
                        self.applystatus = "1"
                       // self.parsedataUpdate(res: [json])
                    }
                }
                AlertView.show(title: "Successfully Applied", message: "You applies successfully", vc: self)
            }
            else
            {
                AlertView.show(title: "Enter Full Details", message: "Please enter field and linkedIn profile!", vc: self)
            }
        }
        
        else
        {
            AlertView.show(title: "Already applied", message: "You have already applied for the technology!", vc: self)
        }
    }
    
    func parsedataUpdate(res: [String : Any])
    {
        let msg = res["response"] as? String
        if msg == "successfully updated"
        {
            AlertView.show(title: "Successful", message: msg!, vc: self)
        }
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
