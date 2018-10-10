//
//  QuizViewController.swift
//  ScannerQuizDemo
//
//  Created by Silviya Velani on 31/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class FakeModel: NSObject {
    var question:String?
    var optionOne:String?
    var optionTwo:String?
    var optionThree:String?
    var optionFour:String?
    var answer:String?
    var isRight : Bool = false
    
}

class QuizViewController: UIViewController
{
    //MARK:- Outltes
    @IBOutlet weak var quizCollectionView: UICollectionView!
    @IBOutlet weak var righTimeButtonLabel: UIBarButtonItem!
    
    //MARK:- Object
    
    let timeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "30:00"
        lbl.textColor = UIColor.init(red: 54/255, green: 144/255, blue: 167/255, alpha: 1.0)
        return lbl
    }()
    
    var countDownTimer = Timer()
    var timeRemaining = 70//1800
    var qrCode : String?
    var modelArray : [FakeModel]?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(qrCode!)
        quizCollectionView.dataSource = self
        quizCollectionView.delegate = self
        prepareForNavigationBar()
        prepareTimerMethods()
        prepareDataQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //MARK:- prepare Methods
    
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
    
    func prepareDataQuestion()
    {
        let modelOne = FakeModel()
        modelOne.question = "In the first 10 overs of a cricket game, the run rate was only 3.2. What should be the run rate in the remaining 40 overs to reach the target of 282 runs?"
        modelOne.optionOne = "6.25"
        modelOne.optionTwo = "6.5"
        modelOne.optionThree = "6.75"
        modelOne.optionFour = "7"
        modelOne.answer = "6.25"

        let modelTwo = FakeModel()
        modelTwo.question = "Find the greatest number that will divide 43, 91 and 183 so as to leave the same remainder in each case."
        modelTwo.optionOne = "4"
        modelTwo.optionTwo = "7"
        modelTwo.optionThree = "9"
        modelTwo.optionFour = "13"
        modelTwo.answer = "4"

        let modelThree = FakeModel()
        modelThree.question = "The H.C.F. of two numbers is 23 and the other two factors of their L.C.M. are 13 and 14. The larger of the two numbers is:"
        modelThree.optionOne = "276"
        modelThree.optionTwo = "299"
        modelThree.optionThree = "322"
        modelThree.optionFour = "345"
        modelThree.answer = "322"

        modelArray = [modelOne,modelTwo,modelThree]
        quizCollectionView.reloadData()
    }
    
    private func resultSendApi()
    {
        self.navigationController?.popViewController(animated: true)
//        APIRequest.doRequestForJson(method: .POST, queryString: <#T##String?#>, parameters: <#T##[String : Any]?#>, showLoading: true, hudText: "Complet", returnError: true) { (json, str) in
//            if let getJson = json as? [String:Any]
//            {
//                //parsing
//                //check
//                self.navigationController?.popViewController(animated: true)
//
//            }
//            else
//            {
//
//            }
//        }
    }
}


// MARK: - Extension QuizViewController for CollectionView Datasource and delegate
extension QuizViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let questionArray = modelArray
        {
            return questionArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as! QuestionCollectionViewCell
        cell.indexPath = indexPath
        cell.modelArray = modelArray?[indexPath.row]
        cell.btnOpt1.addTarget(self, action: #selector(buttonOneClick), for: .touchUpInside)
        cell.btnOpt2.addTarget(self, action: #selector(buttonTwoClick), for: .touchUpInside)
        cell.btnOpt3.addTarget(self, action: #selector(buttonThreeClick), for: .touchUpInside)
        cell.btnOpt4.addTarget(self, action: #selector(buttonFourClick), for: .touchUpInside)
      //  cell.btnSkip.addTarget(self, action: #selector(buttonSkipClick), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    @objc private func buttonOneClick(_ sender:UIButton)
    {
        let index = sender.tag
        if let model = modelArray
        {
            if model[index].answer == model[index].optionOne
            {
                model[index].isRight = true
            }
            quizCollectionView.reloadData()
            
            if index + 1 < model.count
            {
                self.quizCollectionView.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .left, animated: true)
            }
            else
            {
                resultSendApi()
            }
        }
        
        
        
    }
    
    @objc private func buttonTwoClick(_ sender:UIButton)
    {
        let index = sender.tag
        if let model = modelArray
        {
            if model[index].answer == model[index].optionTwo
            {
                model[index].isRight = true
            }
            quizCollectionView.reloadData()
            
            if index + 1 < model.count
            {
                self.quizCollectionView.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .left, animated: true)
            }
            else
            {
                resultSendApi()
            }
        }
    }
    
    @objc private func buttonThreeClick(_ sender:UIButton)
    {
        let index = sender.tag
        if let model = modelArray
        {
            if model[index].answer == model[index].optionThree
            {
                model[index].isRight = true
            }
            quizCollectionView.reloadData()
            
            if index + 1 < model.count
            {
                self.quizCollectionView.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .left, animated: true)
            }
            else
            {
                resultSendApi()
            }
        }
    }
    
    @objc private func buttonFourClick(_ sender:UIButton)
    {
        let index = sender.tag
        if let model = modelArray
        {
            if model[index].answer == model[index].optionFour
            {
                model[index].isRight = true
            }
            quizCollectionView.reloadData()
            
            if index + 1 < model.count
            {
                self.quizCollectionView.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .left, animated: true)
            }
            else
            {
                resultSendApi()
            }
        }
    }
    
    @objc private func buttonSkipClick(_ sender:UIButton)
    {
        let index = sender.tag
        
        if let model = modelArray
        {
            if index + 1 < model.count
            {
                self.quizCollectionView.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .left, animated: true)
            }
            else
            {
                resultSendApi()
            }
        }
    }
    
    
}
