//
//  SwiftViewController.swift
//  D11Concurrency
//
//  Created by Rommel Rico on 2/3/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    var count = 0
    
    @IBOutlet weak var myManualCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDisplay()
    }

    func updateDisplay() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        myManualCountLabel.text = "Manual Count = \(appDelegate.myGlobalCount)"
    }
    
    @IBAction func doManualCountButton(sender: AnyObject) {
        //count++
        //myManualCountLabel.text = "Manual Count = \(count)"
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.myGlobalCount++;
        updateDisplay();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
