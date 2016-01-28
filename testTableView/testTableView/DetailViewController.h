//
//  DetailViewController.h
//  testTableView
//
//  Created by Niels Dawartz on 06/01/16.
//  Copyright © 2016 nd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>


@property (nonatomic, retain) NSString * stringTitle;
@property (nonatomic, retain) NSString * articleLink;
@property (nonatomic, retain) IBOutlet UILabel * labelTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * activityIndicator;




@end


