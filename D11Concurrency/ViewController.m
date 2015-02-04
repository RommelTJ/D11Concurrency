//
//  ViewController.m
//  D11Concurrency
//
//  Created by Rommel Rico on 2/3/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myManualCountLabel;
@property int myManualCount;
@property (weak, nonatomic) IBOutlet UILabel *myTimerCountLabel;
@property (strong, nonatomic) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *myNSObjectThreadCountLabel;
@property int myNSObjectThreadCount;
@property int myTimerCount;
@end

@implementation ViewController
- (IBAction)doManualIncrement:(id)sender {
    //self.myManualCount++;
    //self.myManualCountLabel.text = [NSString stringWithFormat:@"Manual Count = %i", self.myManualCount];
    
    //Increment the global count.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.myGlobalCount++;
    [self updateDisplay];
}

- (void)updateDisplay {
    //Get the global count.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.myManualCountLabel.text = [NSString stringWithFormat:@"Manual Count = %i", appDelegate.myGlobalCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateDisplay];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTimerHandler) userInfo:nil repeats:YES];
    
    //Using performSelectorInBackground
    //[self performSelectorInBackground:@selector(doBackground) withObject:nil];
    
    //Using Grand Central Dispatch (GCD)
    dispatch_queue_t queue = dispatch_queue_create("com.rommelrico.myq", 0);
    dispatch_async(queue, ^{
        int count = 0;
        while (YES) {
            count++;
            sleep(1);
            //Get main thread, synchronize, and perform operation.
            dispatch_async(dispatch_get_main_queue(), ^{
                self.myNSObjectThreadCountLabel.text = [NSString stringWithFormat:@"NSObjectCount: %i", count];
            });
        }
    });
}

- (void)myTimerHandler {
    self.myTimerCount++;
    self.myTimerCountLabel.text = [NSString stringWithFormat:@"TimerCount: %i", self.myTimerCount];
}

- (void)doBackground {
    while (YES) {
        self.myNSObjectThreadCount++;
        //You can't just change the label text. You have to wait for the main thread, thus the line below.
        [self performSelectorOnMainThread:@selector(doUpdateNSObjectCount) withObject:nil waitUntilDone:NO];
        sleep(1); //sleep for 1 second.
    }
}

- (void)doUpdateNSObjectCount {
    self.myNSObjectThreadCountLabel.text = [NSString stringWithFormat:@"NSObjectCount: %i", self.myNSObjectThreadCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
