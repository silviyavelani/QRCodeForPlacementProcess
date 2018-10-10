//
//  LoginViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 18/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class LoginModel: Codable {
    var lid : String?
    var role : String?
}

class LoginViewController: UIViewController {

    var lid:String?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var imgsignin: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.backgroundColor = UIColor.clear
        pwd.backgroundColor = UIColor.clear
        
        AddBottomBorderTo(textfield: email)
        AddBottomBorderTo(textfield: pwd)
        
        btnsubmit.layer.cornerRadius = 5
        
        imgsignin.layer.cornerRadius = imgsignin.frame.size.width / 2
        imgsignin.clipsToBounds = true
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        email.text = ""
        pwd.text = ""
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }

    @IBAction func btnforgetpassword(_ sender: UIButton)
    {

    }
    
    
    @IBAction func btnsignin(_ sender: Any) {
//        POST_Data()
        let c = validation()
        
        let emailadd = email.text
        let password = pwd.text
        
        let callemailfunction = c.isValidEmail(testStr: emailadd!)
        let callpasswordfunction = c.isPasswordValid(password!)
        
        if callemailfunction && callpasswordfunction && emailadd != ""
        {
            if let login = email.text, let password = pwd.text, login.trim().count != 0
            {
                let reqDict = ["email":login,"pwd":password]
                APIRequest.doRequestForJson(method: .POST, queryString: "login_select.php", parameters: reqDict,showLoading: true) { (response, err) in
                    if let json = response as? [String:Any]
                    {
                        self.parsdata(result: json)
                    }
                    else
                    {
                        AlertView.show(title: "Login Error", message: "Please enter username and passsword", vc: self)
                        self.email.text = ""
                        self.pwd.text = ""
                    }
                }

            }
            else
            {
                AlertView.show(title: "Login Error", message: "Please enter username and passsword", vc: self)
                email.text = ""
                pwd.text = ""
            }
        }
        
        else
        {
            AlertView.show(title: "Login Error", message: "Please enter valid details", vc: self)
        }
        
    }
    
    func parsdata(result:[String:Any])
    {
        if let lid = result["lid"] as? String
        {
            self.lid = lid
            UserDefaults.standard.set(lid, forKey: Constant.loginId)
            if let role = result["role"] as? String
            {
                UserDefaults.standard.set(role, forKey: Constant.loginRole)
                UserDefaults.standard.set(true, forKey: Constant.isLoginKey)
                
                if role == "user"
                {
                    performSegue(withIdentifier: "FromLoginViewControllerToUser_HomePageViewController", sender: nil)
                }
                else if role == "admin"
                {
                    performSegue(withIdentifier: "FromLoginViewControllerToAdmin_HomePageViewController", sender: nil)
                }
                
                else
                {
                    AlertView.show(title: "Login Error", message: "Please enter valid username & password", vc: self)
                    email.text = ""
                    pwd.text = ""
                }
            }
        }
        else
        {
            AlertView.show(title: "Login Error", message: "Please enter valid username & password", vc: self)
            email.text = ""
            pwd.text = ""
        }
    }
}

