//
//  SendOTPViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 23/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SendOTPViewController: UIViewController {
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnsendOTP: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtemail.backgroundColor = UIColor.clear
        AddBottomBorderTo(textfield: txtemail)
        
        btnsendOTP.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnsendOTP(_ sender: UIButton){
        if let login = txtemail.text, login.trim().count != 0
                {
                    let reqDict = ["email":login]
                    APIRequest.doRequestForJson(method: .POST, queryString: "email.php", parameters: reqDict,showLoading: true) { (response, err) in
                        if let json = response as? [String:Any]
                        {
                            self.parsdata(result: json)
                        }
                    }
                    
                    //UserDefaults.standard.set(role, forKey: Constant.loginRole)
        }
        
        //performSegue(withIdentifier: "SendOTPViewControllerToForgotPasswordViewController", sender: nil)
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }

    func parsdata(result:[String:Any])
    {
        if let resultOTP = result["result"] as? Bool
        {
            if let msg = result["msg"] as? String
            {
                if let OTP = result["otp"] as? Int
                {
                UserDefaults.standard.set("\(OTP)", forKey: Constant.OTP)
                     UserDefaults.standard.set(txtemail.text, forKey: Constant.email)
                performSegue(withIdentifier: "SendOTPViewControllerToForgotPasswordViewController", sender: nil)
//                UserDefaults.standard.set(true, forKey: Constant.isLoginKey)
                }
                else
                {
                    AlertView.show(title: "Error", message: "Please enter correct email", vc: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc2 = segue.destination as! ForgotPasswordViewController
        vc2.email = txtemail.text
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
