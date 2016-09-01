//
//  Beac.swift
//  Notification
//
//  Created by Christopher Campanelli on 2016-08-28.
//  Copyright © 2016 Estimote, Inc. All rights reserved.
//

import Foundation

class beac{
    var _uuid:String = " "
    func beac(){
        _uuid = uuidCheck()
    }
    func uuidCheck() -> String{
        var uuid:String = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("uuid") == nil){
           uuid = "6D63C38A-44B9-11E6-BEB8-9E71128CAE75"
        }
        else{
            uuid = NSUserDefaults.standardUserDefaults().objectForKey("uuid") as! String
        }

        return uuid
    }
    
}
