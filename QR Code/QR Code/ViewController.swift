//
//  ViewController.swift
//  QR Code
//
//  Created by Silviya Velani on 18/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func POST_Data() -> Void
    {
        //Make ADDRESS URL
        let reqUrl = URL(string: "http://localhost:8888/PhpProject2/register_insert.php")
        
        //GET DATA FROM TEXT FIELD AND PUT INTO DICTIONARY on KEY NAME
        let reqDict = ["username":txtname.text,"password":txtpassword.text];
        
        do {
            
            //DICTIONARY  FORMATE CONVERT JSON FORMATE WITH JSONSERIALIZABLE
            let reqData = try JSONSerialization.data(withJSONObject: reqDict, options: .prettyPrinted)
            
            //FOR URL REQUEST
            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            
            //REQUEST HTTP METHOD
            request.httpMethod = "POST"
            
            //REQUEST DATA HTTPBODY JSON
            request.httpBody = reqData
            
            //REQUEST SETVALUE
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //SESSION
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
                if (error != nil){
                    print(error.debugDescription)
                }else{
                    do {
                        
                        let resDict = try JSONSerialization.jsonObject(with: resData!, options: .allowFragments)
                        print(resDict)
                        
                        DispatchQueue.main.async(execute:{
                            
                            self.parsdata(result: resDict as! [String : Any])
                            
                        }
                            
                            
                        )
                        
                        
                        
                    }catch{
                        print(exception())
                    }
                }
            })
            task.resume()
        }
            
        catch{
            print(exception())
        }
        
    }
    //response ma json ane ios ma dictionary ->
    func parsdata(result:[String:Any])
    {
        
        
        if let valueforkey = result["lid"] as? String
        {
            print("sucess")
            UserDefaults.standard.set(valueforkey, forKey: "id")
            
            if result["role"] as? String == "d"
            {
                
                performSegue(withIdentifier: "d", sender: nil)
                
            }
            else if result["role"] as? String == "v"
            {
                
                
                performSegue(withIdentifier: "v", sender: nil)
            }
            
            
        }
        else
        {
            print("fail")
            
        }
        
    }


}

