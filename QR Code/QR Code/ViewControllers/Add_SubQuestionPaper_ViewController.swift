//
//  Add_SubQuestionPaper_ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 29/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class Add_SubQuestionPaper_ViewController: UIViewController, UIPickerViewTextFieldDelegate {
    
    var correctans:[String] = ["Option One","Option Two","Option Three","Option Four"]
    
    func doneButtonOnTaped(selectedTextfield: UITextField, name: String?, row: Int) {
        print(name!)
        print(row)
    }
    
    
    
    @IBOutlet weak var txtquestion: UITextField!
    @IBOutlet weak var txtopa: UITextField!
    @IBOutlet weak var txtopb: UITextField!
    @IBOutlet weak var txtopc: UITextField!
    @IBOutlet weak var txtopd: UITextField!
    @IBOutlet weak var txtcorrectopt: UIPickerViewTextField!
    //@IBOutlet weak var txtcorrectopt: UITextField!
    @IBOutlet weak var btnnext: UIButton!
    
    var count = 1
    var id =  ""
//
//    $qid = $jsonarr["qid"];
//    $question = $jsonarr["question"];
//    $opa = $jsonarr["opa"];
//    $opb = $jsonarr["opb"];
//    $opc = $jsonarr["opc"];
//    $opd = $jsonarr["opd"];
//    $corre = $jsonarr["corre"];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnnext.layer.cornerRadius = 5
        
        txtcorrectopt.pickerDelegate = self
        txtcorrectopt.pickerData = correctans
        
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func btnnext(_ sender: UIButton) {
        
        if let question = txtquestion.text ,let opa = txtopa.text ,let opb = txtopb.text ,let opc = txtopc.text ,let opd = txtopd.text , let corre = txtcorrectopt.text
        {
            if question != "" && opa != "" && opb != "" && opc != "" && opd != "" && corre != ""
            {
            let reqDict = ["qid":id,"question" : question ,"opa" :opa,"opb":opb,"opc":opc,"opd":opd,"corre":corre]
            APIRequest.doRequestForJson(method: .POST, queryString: "subquestionpaper_insert.php", parameters: reqDict,showLoading: true) { (response, err) in
                if let json = response as? [String:Any]
                {
                    self.parsedata(res: json)
                }
            }
            }
            else{
                AlertView.show(title: "Invalid Input", message: "None of the field can be empty", vc: self)
            }
        }
        else
        {
            AlertView.show(title: "Error", message: "Something went wrong", vc: self)
        }
      
        
    }
    
    func parsedata(res : [String:Any])  {
        let msg = res["response"] as? String
        if msg == "successfully inserted"
        {
            txtquestion.text = ""
            txtopd.text = ""
            txtopc.text = ""
            txtopb.text = ""
            txtopa.text = ""
            txtcorrectopt.text = ""
            count = count + 1
            
            
        
        if count > 20
        {
            let vc = navigationController?.viewControllers[1] as! Admin_HomePageViewController
            navigationController?.popToViewController(vc, animated: true)
        }
        }
    }
}
