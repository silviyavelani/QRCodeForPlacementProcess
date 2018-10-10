//
//  SendQRCode_ProfileViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 03/10/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class SendQRCode_ProfileViewController: UIViewController {
    
    var fname:String?
    var email:String?
    var cno:String?
    var photo = ""
    var technology:String?
    var lid:String?

    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var lblfname: UILabel!
    @IBOutlet weak var lbltechnology: UILabel!
    @IBOutlet weak var lblmobileno: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reqUrl = URL(string: "https://silviyavelani.000webhostapp.com/Qrapi/" + photo)
        let data = NSData(contentsOf: reqUrl!)
        if data != nil
        {
            imgprofile.image =  UIImage(data:data as! Data)
        }
        
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width / 2
        imgprofile.clipsToBounds = true
        
        lblfname.text = fname
        lbltechnology.text = technology
        lblmobileno.text = cno
        lblemail.text = email
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnupdateqrcodestatus(_ sender: Any) {
        let reqDict = ["lid":lid]
        APIRequest.doRequestForJson(method: .POST, queryString: "qrcodestatus_update.php", parameters: reqDict,showLoading: true) { (response, err) in
            if let json = response as? [String:Any]
            {
                self.parsdata(res: json)
            }
            else
            {
                AlertView.show(title: "Error", message: "Something went wrong!", vc: self)
            }
        }
        
    }
    
    func parsdata(res : [String:Any])
    {
        var msg = res["response"] as? String ?? ""
        if msg == "successfully update"
        {
            navigationController?.popViewController(animated: true)
            AlertView.show(title: "Schedule Status", message: msg, vc: self)
        }
            
        else
        {
            AlertView.show(title: "successfully update", message: msg, vc: self)
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
