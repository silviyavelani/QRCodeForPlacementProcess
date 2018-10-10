//
//  RegisterViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 18/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class RegisterModel: Codable {
    var lid : String?
    var role : String?
}

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewTextFieldDelegate  {
    
    func doneButtonOnTaped(selectedTextfield: UITextField, name: String?, row: Int) {
        print(name!)
        print(row)
    }
    

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var middlename: UITextField!
    @IBOutlet weak var gender: UIPickerViewTextField!
    @IBOutlet weak var no: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var repwd: UITextField!
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var imgprofile: UIImageView!
    var gen:[String] = ["Female","Male"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
  gesturePerform()
        firstname.backgroundColor = UIColor.clear
        lastname.backgroundColor = UIColor.clear
        middlename.backgroundColor = UIColor.clear
        no.backgroundColor = UIColor.clear
        email.backgroundColor = UIColor.clear
        gender.backgroundColor = UIColor.clear
        pwd.backgroundColor = UIColor.clear
        repwd.backgroundColor = UIColor.clear
        imgprofile.layer.cornerRadius = 79.0
        
        AddBottomBorderTo(textfield: firstname)
        AddBottomBorderTo(textfield: lastname)
        AddBottomBorderTo(textfield: middlename)
        AddBottomBorderTo(textfield: gender)
        AddBottomBorderTo(textfield: no)
        AddBottomBorderTo(textfield: email)
        AddBottomBorderTo(textfield: pwd)
        AddBottomBorderTo(textfield: repwd)
        
        btnsubmit.layer.cornerRadius = 5
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width / 2
        imgprofile.clipsToBounds = true
        
        gender.pickerDelegate = self
        gender.pickerData = gen
//        let manage = [firstname!.self,middlename!.self,lastname!.self,no!.self,email!.self,pwd!.self,repwd!.self]
//        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = manage.
        
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
    
    @IBAction func btnsubmit(_ sender: Any) {
        let c = validation()
        
        let fname = firstname.text
        let mname = middlename.text
        let lname = lastname.text
        let mobileno = no.text
        let emailadd = email.text
        let password = pwd.text
        
        let callnumberfunc = c.isVaildnumber(value: mobileno!)
        let callemailfunction = c.isValidEmail(testStr: emailadd!)
        let callpasswordfunction = c.isPasswordValid(password!)
        let callfnamefunction = c.validatename(name: fname!)
        let callmnamefunction = c.validatename(name: mname!)
        let calllnamefunction = c.validatename(name: lname!)
        
        if callfnamefunction && callmnamefunction && calllnamefunction
        {
            if callnumberfunc
            {
                    if callemailfunction
                    {
                        if callpasswordfunction
                        {
                            if callnumberfunc && callemailfunction && callpasswordfunction && mobileno != "" && password != "" && emailadd != "" && callfnamefunction && callmnamefunction && calllnamefunction
                            {
                                if let password = pwd.text, let repassword = repwd.text
                                {
                                    if password == repassword && password != ""
                                    {
                                        let reqDict = ["firstname":firstname.text!,"lastname":lastname.text!,"middlename":middlename.text!,"gender":gender.text!, "no":no.text!,"email":email.text!,"pwd":pwd.text!];
                                        APIRequest.doRequestForJson(method: .POST, queryString: "register_insert.php", parameters: reqDict,showLoading: true)
                                        { (response, err) in
                                            if let json = response as? [String:Any]
                                            {
                                                self.parsdata(result: json)
                                                
                                            }
                                        }
                                    }
                                    else
                                    {
                                            AlertView.show(title: "Invalid password", message: "Password and confirm password are different.", vc: self)
                                    }
                                }
                            }
                            else
                            {
                                AlertView.show(title: "Registration Error", message: "Please enter full details", vc: self)
                            }
                        }
                        else
                        {
                            AlertView.show(title: "Invalid password", message: "Password should be of 8 characters which include atleast one special character, A-Z, 0-9, a-z", vc: self)
                        }
                    }
                    else
                    {
                        AlertView.show(title: "Invalid Email Address error", message: "Please enter valid email", vc: self)
                    }
                }
                else
                {
                AlertView.show(title: "Invalid mobile number", message: "Please enter valid mobile number", vc: self)
            }
        }
        else
        {
            AlertView.show(title: "Invalid name", message: "Please enter valid name", vc: self)
        }
    }
                
    func parsdata(result:[String:Any])
    {
        if let lid = result["id"] as? Int
        {
            if let responce = result["response"] as? String
            {
                
                self.postImage(imageId:String(lid) )
                //AlertView.show(title: "Registration Sucessfull", message: "", vc: self)
                  //  self.navigationController?.popToRootViewController(animated: true)
            }
        }
        let vc2 = navigationController?.viewControllers[0] as! LoginViewController
        navigationController?.popToViewController(vc2, animated: true)
    }
    
    func gesturePerform()   {
    
        let tapgesture=UITapGestureRecognizer(target: self, action:#selector(tapgesturePerform(gesture:)))
        
        tapgesture.numberOfTapsRequired=2
        
        self.imgprofile.addGestureRecognizer(tapgesture)
    }
    
    //MARK:- tap gesture
    
    @objc func tapgesturePerform(gesture:UIGestureRecognizer)  {
        
        let alert=UIAlertController(title:"Add Photo", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Open Galary", style: .default, handler: { (acton:UIAlertAction) in
            
            self.openGalary()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    //MARK:- helper method for alert in Opengalary
    
    func openGalary()  {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate=self
        
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK:- select photo and set image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgprofile.contentMode = .scaleToFill
        
        imgprofile.image=chosenImage
        
        dismiss(animated: true, completion: nil)
        
    }
  
    func postImage(imageId:String){
        
        
        
        let reqUrl = URL(string: "https://silviyavelani.000webhostapp.com/Qrapi/registrationimageupload.php?id="+imageId)
        
        
        var request = URLRequest(url: reqUrl! as URL)
        
        request.httpMethod = "POST"
        
        let boundary = "xxxxBoundaryStringxxxx"
        
        request.setValue("multipart/form-data; boundary=\(boundary)",
            
            forHTTPHeaderField: "Content-Type")
        
        if (imgprofile.image == nil)
            
        { return }
        
        //        let image_data = UIImagePNGRepresentation(imageofProduct.image!)
        
        let image_data = UIImagePNGRepresentation(self.compressImage(imgprofile.image!))
        let body = NSMutableData()
        
        // let fname = "porch-16.png"
        
        let fname = imageId+".png"
        //  let mimetype = "image/png"
        
        body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Disposition:form-data; name=\"fileUpload\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using:String.Encoding.utf8)!)
        
        body.append(image_data!)
        
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using:String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response , error
                
                == nil else {
                    print("error")
                    return
            }
            
            let resDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(resDict);
            DispatchQueue.main.async(execute: {
                self.parseData(res: resDict as! [String : Any])
              //  self.parsdata(res: resDict as! [String : Any])
                
            })
            
     //   }
            
        }
        task.resume()
    }
    
    
    func compressImage(_ image:UIImage) -> UIImage
    {
        //        var CompressImage : UIImage = image.correctlyOrientedImage()
        
        var CompressImage
            : UIImage = image
        var actualHeight = CompressImage.size.height
        var actualWidth = CompressImage.size.width
        let maxHeight:CGFloat
        let maxWidth:CGFloat
          maxHeight = 1080
        maxWidth =  1920
       
        
        var imageRetio:CGFloat = actualWidth/actualHeight
        let maxRetio:CGFloat = maxWidth/maxHeight
        print(image.imageOrientation)
        
        let compressionQuality:CGFloat = 1.0   // 0 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth
        {
            if imageRetio < maxRetio
            {
                imageRetio = maxHeight/actualHeight
                actualWidth = imageRetio * actualWidth
                actualHeight = maxHeight
            }
            else if imageRetio > maxRetio
            {
                imageRetio = maxWidth/actualWidth
                actualWidth = imageRetio * actualHeight
                actualHeight = maxWidth
                
            }
            else
            {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
            let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
            UIGraphicsBeginImageContext(rect.size)
            CompressImage.draw(in: rect)
            if CompressImage.imageOrientation == .up
            {
                print("True")
            }
            let img = UIGraphicsGetImageFromCurrentImageContext()
            let imageData = UIImageJPEGRepresentation(img!, compressionQuality)
            UIGraphicsEndImageContext()
            CompressImage = UIImage(data:imageData!)!
            CompressImage.imageOrientation
        }
        return CompressImage
    }

    func parseData(res:[String:Any])
    {
        let msg = res["msg"] as? String
        //var path = res["path"] as? String
        if msg == "success"
        {
            performSegue(withIdentifier: "FromRegisterViewControllerToLoginViewController", sender: Any?.self)
        }
            
    }
    
}
