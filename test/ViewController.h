//
//  ViewController.h
//  test
//
//  Created by Niels Dawartz on 25/11/15.
//  Copyright © 2015 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
        NSString * myString;    // local variabel
    
    
    
}

@property(nonatomic, retain) NSString * strPoperty; // global variable

@property(nonatomic, retain) IBOutlet UILabel * lblTitle;   // interface builder outlet

- (void)changeLabel:(NSString *) string;    // interface builder action
- (IBAction) doClick:(id)sender;

@end

