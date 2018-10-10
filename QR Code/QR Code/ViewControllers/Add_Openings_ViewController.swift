//
//  Add_Openings_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class Add_Openings_ViewController: UIViewController, UIPickerViewTextFieldDelegate{
    
    
    func doneButtonOnTaped(selectedTextfield: UITextField, name: String?, row: Int) {
        print(name!)
        print(row)
    }
    
    
    var openings:[String] = []
    var msg:String = ""
    
    @IBOutlet weak var lblopenings: UIPickerViewTextField!
    @IBOutlet weak var lblnoofpositions: UITextField!
    @IBOutlet weak var btnadd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequest.doRequestForJson(method: .GET, queryString: "select_TechnologyAPI.php", parameters: [:] , showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                print(json)
                self.parseDataTech(res: json)
                // self.parsdata(result: json)
            }
            
            
            
            // Do any additional setup after loading the view.
        }
        
        lblopenings.backgroundColor = UIColor.clear
        lblnoofpositions.backgroundColor = UIColor.clear
        
        AddBottomBorderTo(textfield: lblopenings)
        AddBottomBorderTo(textfield: lblnoofpositions)
        
        btnadd.layer.cornerRadius = 5
        
//        lblopenings.pickerDelegate = self
//        lblopenings.pickerData = openings
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblopenings.pickerDelegate = self
        
        //lblopenings.pickerData = openings
    }
    
    func parseDataTech(res : [[String:Any]])
    {
     
        for i in res
        {
            let name = i["cname"] as? String
            openings.append(name!)
        }
        lblopenings.pickerData = openings
        
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }
    
    
    @IBAction func btnadd(_ sender: UIButton) {
        if lblopenings.text != "" && lblnoofpositions.text != ""
        {
            let reqDict = ["cid":lblopenings.text, "noofpositions":lblnoofpositions.text]
            APIRequest.doRequestForJson(method: .POST, queryString: "opening_insert.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
                if let json = response as? [String:Any]
                {
                    print(json)
                    self.parseData(res: json)
                    // self.parsdata(result: json)
                }
            }
        }
        else
        {
            AlertView.show(title: "Invalid Technology", message: "Please enter valid technology name", vc: self)
        }
        
    }
    
    func parseData(res : [String:Any])
    {
        msg = res["response"] as? String ?? ""
        if msg == "successfully inserted"
        {
            navigationController?.popViewController(animated: true)
            //AlertView.show(title: "Add Openings", message: msg, vc: self)
            
            //performSegue(withIdentifier: "FromAdd_Openings_ViewControllerToAdmin_ViewOpenings_ViewController", sender: nil)
            
        }
        
        else
        {
            AlertView.show(title: "Invalid Input", message: msg, vc: self)
            
            lblopenings.text = ""
            lblnoofpositions.text = ""
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

