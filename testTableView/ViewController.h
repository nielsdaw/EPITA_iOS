//
//  ViewController.h
//  tableViewTest
//
//  Created by Niels Dawartz on 09/12/15.
//  Copyright © 2015 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,
UITableViewDataSource, NSXMLParserDelegate> {
    
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *date;
    NSString *imageUrl;
    NSMutableString *article;
    NSMutableString *author;
    
    NSString *element;
    
}

@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * activityIndicator;

@end

