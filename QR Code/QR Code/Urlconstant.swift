//
//  Urlconstant.swift
//  QR Code
//
//  Created by Silviya Velani on 19/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import Foundation

class Constant : NSObject {
    static let loginId = "lid"
    static let loginRole = "role"
    static let isLoginKey = "isLogin"
    static let OTP = "OTP"
    static let email = "email"
}


class RemoveUserDefault: NSObject {
    static func remove()
    {
        UserDefaults.standard.removeObject(forKey: Constant.loginId)
        UserDefaults.standard.removeObject(forKey: Constant.loginRole)
    }
    
}

class UserDefaultsGetValue : NSObject
{
    
    class func getOTP() -> String
    {
        if let value = UserDefaults.standard.value(forKey: Constant.OTP) as? String
        {
            return value
        }
        return ""
    }
    
}






