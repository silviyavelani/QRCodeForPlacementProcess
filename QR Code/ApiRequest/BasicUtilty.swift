//
//  BasicUtilty.swift
//  QR Code
//
//  Created by Silviya Velani on 19/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit


extension String
{
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
