//
//  GenerateQRCodeViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 01/10/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class GenerateQRCodeViewController: UIViewController {

    var id:String?
    var QRCode:String?
    var img:UIImage!
    var FinalImage:UIImage!

    @IBOutlet weak var imgqrcode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        if let myString = QRCode
        {
        let data = myString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
            
        filter?.setValue(data, forKey: "inputMessage")
            //let transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            
            
            img = UIImage(ciImage: (filter?.outputImage)!)
            let c = convert(cmage:(filter?.outputImage)! )
            UIImageWriteToSavedPhotosAlbum(c, nil, nil, nil)
            
           // UIImage(data: filter?.outputImage)
         //   let d =   UIImage(cgImage: img as! CGImage)
            //var n = "1" + ".png"
          //  UIImage(named: n)
            imgqrcode.image = img
            //imgqrcode.image = img
            
          //  var demo = imgqrcode.image
          //  print(demo)
           // print(imgqrcode.image)
        // Do any additional setup after loading the view.
        }
        FinalImage = imgqrcode.image!
       // var d = FinalImage.images
       
    }
    func convert(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    @IBAction func btndownload(_ sender: Any) {
        performSegue(withIdentifier: "FromGenerateQRCodeToAdd_SubQuestionPaperViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Add_SubQuestionPaper_ViewController
        
        vc.id = id!
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
