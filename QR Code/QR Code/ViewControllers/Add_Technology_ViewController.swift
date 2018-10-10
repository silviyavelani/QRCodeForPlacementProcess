//
//  Add_Technology_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class Add_Technology_ViewController: UIViewController {

    var msg:String = ""
    @IBOutlet weak var lbltechnology: UITextField!
    @IBOutlet weak var btnadd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbltechnology.backgroundColor = UIColor.clear
        
        AddBottomBorderTo(textfield: lbltechnology)
        btnadd.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }

    @IBAction func btnaddtechnology(_ sender: Any) {
        if lbltechnology.text != ""
        {
            let reqDict = ["cname":lbltechnology.text]
            APIRequest.doRequestForJson(method: .POST, queryString: "Insert_TechnologyAPI.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
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
            AlertView.show(title: "Add Technology", message: msg, vc: self)
            
          // performSegue(withIdentifier: "FromAdd_Technolgy_ViewControllerToAdmin_ViewTechnology_ViewController", sender: nil)
            
        }
        
        else
        {
            AlertView.show(title: "Invalid Input", message: msg, vc: self)
            
            lbltechnology.text = ""
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

}
