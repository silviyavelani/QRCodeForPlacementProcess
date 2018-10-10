//
//  AlertView.swift
//  QR Code
//
//  Created by Silviya Velani on 19/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    
    class func show(title:String?,message:String,vc:UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    class func showNeworkError(title:String?,message:String?)
    {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate, let window = appdelegate.window, let vc = window.rootViewController
        {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
        }
    }
}
