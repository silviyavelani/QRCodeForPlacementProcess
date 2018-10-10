//
//  QuizefinalViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 30/09/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class ModelClass:NSObject
{
    var question:String?
    var optionone:String?
    var optiontwo:String?
    var optionthree:String?
    var optionfour:String?
    var correctans:String?
}

class QuizefinalViewController: UIViewController {
  var qrCode : String?
    
    var arr : [ModelClass] = []
    var user_ans : [String] = []
    var result:Int = 0
    var flag:Bool = false
    var flag2:Bool = false
    
    let timeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "30:00"
        lbl.textColor = UIColor.init(red: 54/255, green: 144/255, blue: 167/255, alpha: 1.0)
        return lbl
    }()
    
    var countDownTimer = Timer()
    var timeRemaining = 1800//1800
    
    @IBOutlet weak var righTimeButtonLabel: UIBarButtonItem!
    //var data = [Model]()
    
    @IBOutlet weak var lblquestion: UILabel!
    @IBOutlet weak var lbloptionone: UILabel!
    @IBOutlet weak var lbloptiontwo: UILabel!
    @IBOutlet weak var lbloptionthree: UILabel!
    @IBOutlet weak var lbloptionfour: UILabel!
    
    @IBOutlet weak var btnoptionone: UIButton!
    @IBOutlet weak var btnoptiontwo: UIButton!
    @IBOutlet weak var btnoptionthree: UIButton!
    @IBOutlet weak var btnoptionfour: UIButton!
    
   // @IBOutlet weak var btnprevious: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForNavigationBar()
        prepareTimerMethods()
        
        btnnext.layer.cornerRadius = 5

        let reqDict = ["setname":qrCode]
        APIRequest.doRequestForJson(method: .POST, queryString: "questionpaper_user.php", parameters: reqDict as [String : Any],showLoading: true) { (response, err) in
            if let json = response as? [[String:Any]]
            {
                //self.parsdata(result: json)
                self.parsedata(result: json)
                self.prepareData()
                AlertView.show(title: "Notice", message: "You can only select Answer once. Please do it carefully!", vc: self)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func prepareData()
    {
        lblquestion.text = arr[index].question
        lbloptionone.text = arr[index].optionone
        lbloptiontwo.text = arr[index].optiontwo
        lbloptionthree.text = arr[index].optionthree
        lbloptionfour.text = arr[index].optionfour
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
//    @IBAction func btnprevious(_ sender: UIButton) {
//        if index > 0
//        {
//            index = index - 1
//            prepareData()
//        }
//        else{
//            AlertView.show(title: "Invalid", message: "This is first question", vc: self)
//        }
//    }
    
    
    @IBAction func btnnext(_ sender: UIButton) {
        if index < arr.count
        {
            if flag == true
            {
                index = index + 1
                flag = false
                if index < arr.count
                {
                    prepareData()
                }
                else
               {
//                    AlertView.show(title: "Answer not Selected", message: "Please select your answer!", vc: self)
                    calculateResult()
                navigationController?.popToRootViewController(animated: true)
               }
            }
            
            else
            {
                AlertView.show(title: "Answer not Selected", message: "Please select your answer!", vc: self)
            }
        }
        else{
            calculateResult()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func calculateResult()
    {
        var i:Int = 0
//        for i...(user_ans.count - 1) {
//            if user_ans[i] == arr[i].correctans
//            {
//                result = result + 1
//            }
//            i = i + 1
//        }
        
        while i < (user_ans.count)
        {
            if user_ans[i] == arr[i].correctans
            {
                result = result + 1
            }
            i = i + 1
        }
        print(result)
        
        var lid = UserDefaults.standard.value(forKey: Constant.loginId) as! String
        print(lid)
        
        let reqDict = ["lid":lid, "marks": String(result)]
            APIRequest.doRequestForJson(method: .POST, queryString: "marks_update.php", parameters: reqDict,showLoading: true) { (response, err) in
                if let json = response as? [String:Any]
                {
                    self.parsedataUpdate(res: json)
                    // self.parsedataUpdate(res: [json])
                }
        
    }
}
    
    
    @IBAction func btnoptionone(_ sender: UIButton) {
        if flag == false
        {
            user_ans.append("Option One")
            flag = true
        }
        else
        {
            AlertView.show(title: "Invalid", message: "You have already selected answer.Please press NEXT button!", vc: self)
        }
        
    }
    
    @IBAction func btnoptiontwo(_ sender: Any) {
        if flag == false
        {
            user_ans.append("Option Two")
            flag = true
        }
        else
        {
            AlertView.show(title: "Invalid", message: "You have already selected answer.Please press NEXT button!", vc: self)
        }
    }
    
    
    @IBAction func btnoptionthree(_ sender: Any) {
        if flag == false
        {
            user_ans.append("Option Three")
            flag = true
        }
        else
        {
            AlertView.show(title: "Invalid", message: "You have already selected answer.Please press NEXT button!", vc: self)
        }
    }
    
    @IBAction func btnoptionfour(_ sender: Any) {
        if flag == false
        {
            user_ans.append("Option Four")
            flag = true
        }
        else
        {
            AlertView.show(title: "Invalid", message: "You have already selected answer.Please press NEXT button!", vc: self)
        }
    }
    
    func parsedata(result:[[String:Any]])
    {
        for i in result
        {
            let obj = ModelClass()
            //let data[index] = [Model]()
            obj.question = i["question"] as? String
            obj.optionone = i["opa"] as? String
            obj.optiontwo = i["opb"] as? String
            obj.optionthree = i["opc"] as? String
            obj.optionfour = i["opd"] as? String
            obj.correctans = i["correctop"] as? String
            
            arr.append(obj)
        }
        
        print(arr)
    }
    
    func parsedataUpdate(res: [String : Any])
    {
        var msg = res["response"] as? String
        if msg == "successfully updated"
        {
            AlertView.show(title: "Successful", message: msg!, vc: self)
        }
    }

    
    private func prepareForNavigationBar()
    {
        let rightView = UIView(frame: CGRect(x: 50, y: 0, width: 100, height: 40))
        rightView.addSubview(timeLabel)
        
        righTimeButtonLabel.customView = rightView
    }
    
    private func prepareTimerMethods()
    {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
    }
    
    @objc private func timerRunning()
    {
        if timeRemaining != 0 {
            timeRemaining -= 1
            let minutesLeft = Int(timeRemaining) / 60 % 60
            let secondsLeft = Int(timeRemaining) % 60
            let zeroMinuteText = "\(minutesLeft)".count != 1 ? "" : "0"
            let zeroSecondText = "\(secondsLeft)".count != 1 ? "" : "0"
            timeLabel.text = "\(zeroMinuteText)\(minutesLeft):\(zeroSecondText)\(secondsLeft)"
        }
        else
        {
            timeLabel.text = "00:00"
            countDownTimer.invalidate()
            countDownTimer.fire()
            resultSendApi()
        }
    }
    
    private func resultSendApi()
    {
        calculateResult()
        navigationController?.popToRootViewController(animated: true)
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
