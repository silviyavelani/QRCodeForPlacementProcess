//
//  UpdatePasswordViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 23/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    var email:String?
    var msg:String?
    @IBOutlet weak var txtpwd: UITextField!
    @IBOutlet weak var txtRetypePwd: UITextField!
    @IBOutlet weak var btnsubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email = UserDefaults.standard.value(forKey: Constant.email) as? String
        
        btnsubmit.layer.cornerRadius = 5
        
        txtpwd.backgroundColor = UIColor.clear
        txtRetypePwd.backgroundColor = UIColor.clear
        AddBottomBorderTo(textfield: txtpwd)
        AddBottomBorderTo(textfield: txtRetypePwd)
      
        
        // Do any additional setup after loading the view.
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if txtpwd.text == txtRetypePwd.text
        {
            //Check response msg condition
            
            
          
                let reqDict = ["email":email,"pwd":txtpwd.text]
                APIRequest.doRequestForJson(method: .POST, queryString: "update_password.php", parameters: reqDict,showLoading: true) { (response, err) in
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
               }
          
            
        
          }
    
    func parseData(res : [String:Any])
    {
        msg = res["response"] as? String
        if msg == "successfully updated"
        {
            navigationController?.popToRootViewController(animated: true)
            AlertView.show(title: "Update Password", message: msg!, vc: self)
        }
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


