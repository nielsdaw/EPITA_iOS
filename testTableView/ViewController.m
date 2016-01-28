//
//  ViewController.m
//  testTableView
//
//  Created by Niels Dawartz on 09/12/15.
//  Copyright © 2015 nd. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSIndexPath * testIndexNumber;
}

@synthesize tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cat.bg.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];    
    
    // Init an activity indicator
    UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //Change the color of the indicator
    activityIndicator.color=[UIColor grayColor];
    
    //Put the indicator on the center of view
    [activityIndicator setCenter:self.view.center];
    
    //Assign it to the property
    self.activityIndicator=activityIndicator;
    
    //Add activity indicator to webView
    [self.tableView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    
    // Parse URl (xml file)
    NSURL *url = [NSURL URLWithString:@"https://feeds.bbci.co.uk/news/technology/rss.xml?edition=uk"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];  // get data from url
    feeds = [[NSMutableArray alloc] init]; // alloc and init as mutable array
    parser = [[NSXMLParser alloc] initWithData:data];   // init parser
    
    [parser setDelegate:self];  // set delegate to the same class, every method is gonna use "parser" auto
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {    // check for items in xml file and initialize the properties
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        date = [[NSMutableString alloc] init];
        imageUrl = [[NSMutableString alloc] init];
        article = [[NSMutableString alloc] init];
        author = [[NSMutableString alloc] init];
    }
    if ( [element isEqualToString:@"media:thumbnail"]) {    // get the img attribute path
        imageUrl = [attributeDict objectForKey:@"url"];
    }
}


- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if ([element isEqualToString:@"link"]){
        [link appendString:string];
    }
    else if ([element isEqualToString:@"pubDate"]){
        [date appendString:string];
    }
    else if ([element isEqualToString:@"description"]){
        [article appendString:string];
    }
    else if ([element isEqualToString:@"author"]){
        [author appendString:string];
    }

}


- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"item"]){
        [item setObject:title forKey:@"title"]; // set key in our dictionary
        [item setObject:link forKey:@"link"];
        [item setObject:date forKey:@"pubDate"];
        [item setObject:article forKey:@"description"];
        [item setObject:imageUrl forKey:@"media:thumbnail"];
        [feeds addObject:[item copy]];
    }
}



/*
 * Send data with segue
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"showDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController * detailViewController = segue.destinationViewController;
        detailViewController.stringTitle = [[feeds objectAtIndex: indexPath.row] objectForKey:@"title"];
        detailViewController.articleLink = [[feeds objectAtIndex: indexPath.row] objectForKey:@"link"];
    }
}

/*
 *End of parser - used for logging and to stop the activityIndicator
 */
- (void) parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"%@",feeds); // define string %@(object), %d (integer) etc..
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}


// parser
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSDictionary *userInfo = parseError.userInfo;
    NSNumber *lineNumber = userInfo[@"NSXMLParserErrorLineNumber"];
    NSNumber *errorColumn = userInfo[@"NSXMLParserErrorColumn"];
    NSString *errorMessage = userInfo[@"NSXMLParserErrprMessage"];
    NSLog(@"Error at line %@ and column %@: %@", lineNumber, errorColumn, errorMessage);
}


/*
 *  method to get count of list
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  20;
}


/*
 * inherited method
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableIdentifier = @"newsFeedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: tableIdentifier];
    
    CGRect tableRect = self.view.frame;
    tableRect.origin.x += 1; // make the table begin a few pixels right from its origin
    tableRect.size.width -= 1 + 1; // reduce the width of the table, in order to fit the content
    tableView.frame = tableRect;
    
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:tableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail; // set wrapping on
    cell.textLabel.numberOfLines = 0;
    
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];  // set title
    cell.textLabel.font = [UIFont fontWithName:@"STIXGeneral-Bold" size:13.0];
    cell.textLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(134/255.0) blue:(139/255.0) alpha:1] ;
    
    cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"]; // set date
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:11.0];

        
    NSString * path = [[feeds objectAtIndex:indexPath.row] objectForKey:@"media:thumbnail"];    // get image
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    if(img != nil){
        cell.imageView.image = img; // set if there is an image
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"]; // else set placeholder
    }
    return cell;
}


/*
 * Size of col
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

/*
 * Set's the tableview when returned from the segue
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

/*
 * To update view, when returned from segue
 */
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData]; // to reload selected cell
}


@end

