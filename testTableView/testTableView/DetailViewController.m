//
//  DetailViewController.m
//  testTableView
//
//  Created by Niels Dawartz on 06/01/16.
//  Copyright © 2016 nd. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cat.bg.png"]];
    _labelTitle.text = _stringTitle;
    _labelTitle.numberOfLines = 0;
    _labelTitle.textColor = [UIColor colorWithRed:(0/255.0) green:(134/255.0) blue:(139/255.0) alpha:1] ;
    [_labelTitle setFont:[UIFont fontWithName:@"STIXGeneral-Bold" size:18]];

    NSString * xmlPath = [_articleLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString * cleanedPath = [xmlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Init an activity indicator
    UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //Change the color of the indicator
    activityIndicator.color=[UIColor grayColor];
    
    //Put the indicator on the center of view
    [activityIndicator setCenter:self.view.center];
    
    //Assign it to the property
    self.activityIndicator=activityIndicator;
    
    //Add activity indicator to webView
    [self.webView addSubview:self.activityIndicator];
    
    // request the url
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:cleanedPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityIndicator stopAnimating];
}
@end
