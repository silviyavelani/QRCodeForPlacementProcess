//
//  QuestionCollectionViewCell.swift
//  ScannerQuizDemo
//
//  Created by Silviya Velani on 31/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet var questionBorder: [UIView]!
    
    @IBOutlet weak var btnOpt1: UIButton!
    @IBOutlet weak var btnOpt2: UIButton!
    @IBOutlet weak var btnOpt3: UIButton!
    @IBOutlet weak var btnOpt4: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblOptionOne: UILabel!
    @IBOutlet weak var lblOptionTwo: UILabel!
    @IBOutlet weak var lblOptionThree: UILabel!
    @IBOutlet weak var lblOptionFour: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBorder()
    }
    
    fileprivate func addBorder()
    {
        for item in questionBorder
        {
            item.layer.borderColor = UIColor.init(red: 54/255, green: 144/255, blue: 167/255, alpha: 1.0).cgColor
            item.layer.borderWidth = 1.0
        }
    }
    
    var indexPath : IndexPath! {
        didSet{
            btnOpt1.tag = indexPath.item
            btnOpt2.tag = indexPath.item
            btnOpt3.tag = indexPath.item
            btnOpt4.tag = indexPath.item
            //btnSkip.tag = indexPath.item
        }
    }
    
    var modelArray: FakeModel? {
        didSet {
            lblQuestion.text = modelArray?.question
            lblOptionOne.text = modelArray?.optionOne
            lblOptionTwo.text = modelArray?.optionTwo
            lblOptionThree.text = modelArray?.optionThree
            lblOptionFour.text = modelArray?.optionFour
        }
    }
    
}
