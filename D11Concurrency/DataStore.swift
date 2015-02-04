//
//  DataStore.swift
//  D11Concurrency
//
//  Created by Rommel Rico on 2/3/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

let KEY_COUNT = "KeyCount"

class DataStore: NSObject {
    
    //Not yet implemented: class let KEY_COUNT = "KeyCount"
    
    //By making these class functions, we don't have to create an instance 
    // of a class to call the functions.
    class func restoreData() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let userDefaults = NSUserDefaults.standardUserDefaults()
        appDelegate.myGlobalCount = Int32(userDefaults.integerForKey(KEY_COUNT))
    }
    
    class func saveData() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(Int(appDelegate.myGlobalCount), forKey: KEY_COUNT)
        userDefaults.synchronize()
    }
}
