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
    //var myTimer: NSTimer! //Implicitly unboxed, so no value = nil
    var myTimer: NSTimer?
    var myTimerCount = 0
    var myNSObjectThreadCount = 0
    
    //var demo: Int? //optional
    //var demo2: Int! //implicitly unboxed optional
    
    @IBOutlet weak var myTimerCountLabel: UILabel!
    @IBOutlet weak var myManualCountLabel: UILabel!
    @IBOutlet weak var myNSObjectThreadCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //demo = 10
        //demo2 = 10
        //println("demo: \(demo)") //Not unboxed, allowed to be optional
        //println("demo: \(demo!)") //Implicitly unboxed, so value is 10
        //println("demo2: \(demo2)") //Implicitly unboxed
        
        updateDisplay()
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "myTimerHandler", userInfo: nil, repeats: true)
        
        //NSObject performSelectorInBackground not supported.
        //Let's use NSThread instead.
        //NSThread.detachNewThreadSelector("doNSThread", toTarget: self, withObject: nil)
        
        //Using Grand Central Dispatch (GCD) in Swift.
        let queue = dispatch_queue_create("com.rommelrico.myq", nil)
        dispatch_async(queue, { () -> Void in
            var count = 0
            while true {
                count++
                sleep(1)
                //Get main thread, synchronize, and perform operation.
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.myNSObjectThreadCountLabel.text = "Count = \(count)"
                })
            }
        })
    }
    
    var myNSThreadCount = 0
    func doNSThread() {
        while true {
            myNSThreadCount++
            //myNSObjectThreadCountLabel.text = "Count = \(myNSThreadCount)" //Cannot update main thread from detached thread.
            //Sync using NSOperationQueue
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.myNSObjectThreadCountLabel.text = "Count = \(self.myNSThreadCount)" //Reference to the property in the block requires "self" prefix.
            })
            sleep(1) //sleep for 1 second.
        }
    }
    
    func myTimerHandler() {
        myTimerCount++
        myTimerCountLabel.text = "TimerCount: \(myTimerCount)"
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
