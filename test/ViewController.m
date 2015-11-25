//
//  ViewController.m
//  test
//
//  Created by Niels Dawartz on 25/11/15.
//  Copyright © 2015 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myString = [ [NSString alloc] initWithFormat:@"strVar"];
    _strPoperty = [ [NSString alloc] initWithFormat:@"Hello World"];

    
}


- (void) changeLabel:(NSString *)string{
    _lblTitle.text = string;
}



- (IBAction)doClick:(id)sender{
    [self changeLabel:_strPoperty];
}



- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
