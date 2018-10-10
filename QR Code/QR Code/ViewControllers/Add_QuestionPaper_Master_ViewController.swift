//
//  Add_QuestionPaper_Master_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Add_QuestionPaper_Master_ViewController: UIViewController {

    @IBOutlet weak var lblqpapername: UITextField!
    @IBOutlet weak var btnadd: UIButton!
    
    var qid:String?
    
    var msg:String?
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnadd.layer.cornerRadius = 5
        
        AddBottomBorderTo(textfield: lblqpapername)
        
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    func AddBottomBorderTo(textfield:UITextField)
    {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textfield.frame.size.height - 2.0, width: textfield.frame.size.width , height: 2.0)
        textfield.layer.addSublayer(layer)
    }
    @IBAction func btnadd(_ sender: UIButton) {
        if lblqpapername.text != ""
        {
            let reqDict = ["setname":lblqpapername.text]
            APIRequest.doRequestForJson(method: .POST, queryString: "questionpapermaster_insert.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
                if let json = response as? [String:Any]
                {
                    print(json)
                    self.parseData(res: json)
                //    self.parseData(res: json)
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
        id = (res["id"] as? Int)!
        if msg == "successfully inserted "
        {
            //navigationController?.popViewController(animated: true)
            //AlertView.show(title: "Add Openings", message: msg, vc: self)
            
            performSegue(withIdentifier: "FromMasterViewControllerToSubQuestionPaper", sender: nil)
            
        }
            
        else
        {
            AlertView.show(title: "Invalid Input", message: msg!, vc: self)
            
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GenerateQRCodeViewController
        
        vc.id = String(id)
        vc.QRCode = lblqpapername.text
        
        
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
