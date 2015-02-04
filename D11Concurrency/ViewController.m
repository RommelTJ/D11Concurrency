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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
