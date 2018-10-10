//
//  ForgotPasswordViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 19/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate{

    var email:String?
   
    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var btnsubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtOTP.backgroundColor = UIColor.clear
        AddBottomBorderTo(textfield: txtOTP)
        txtOTP.delegate = self
        
         btnsubmit.layer.cornerRadius = 5
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
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }
    
    @IBAction func btnsubmit(_ sender: UIButton) {
        if UserDefaultsGetValue.getOTP() == txtOTP.text
        {
            performSegue(withIdentifier: "fromForgotPasswordViewControllertoUpdatePasswordViewController", sender: nil)
        }
        else
        {
            //alert
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc2 = segue.destination as! UpdatePasswordViewController
        vc2.email = email
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
