//
//  UMAViewController.m
//  twittertest
//
//  Created by Bryan Gaston on 11/13/12.
//  Copyright (c) 2012 UNC-CH. All rights reserved.
//

#import "UMAViewController.h"

@interface UMAViewController ()

@end

@implementation UMAViewController

@synthesize tableView = _tableView, activityIndicatorView = _activityIndicatorView;
@synthesize dataSource = _dataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource) {
        return self.dataSource.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell Identifier";
//    NSString *CellIdentifier = [[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"id_str"];
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    NSDictionary *tweet = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [tweet objectForKey:@"text"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"]]]];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //hide tableview to show activityIndicator (rotating progress thingy)
    [self.tableView setHidden:YES];
    [self.activityIndicatorView startAnimating];
    
    //authenticate Twitter account
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        
        //if account authenticates
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if (accounts.count) {
                
                //if user has multiple Twitter accounts, use the first one
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                
                //set search params
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                [parameters setObject:@"chapel hill" forKey:@"q"];
                //[parameters setObject:@"37.781157,-122.398720,10mi" forKey:@"geocode"];
                [parameters setObject:@"5" forKey:@"count"];
                
                //send search request to Twitter
                TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
                [request setAccount:twitterAccount];
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    //if Twitter responds and we have a value for responseData
                    if (responseData) {
                        NSError *error = nil;
                        
                        //set dataSource array to the Twitter JSON feed
                        NSMutableDictionary *statusesDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                        
                        self.dataSource = [statusesDict objectForKey:@"statuses"];
                        NSLog(@"number of tweets: %d",self.dataSource.count);
                        
                        if (self.dataSource) {
                            [self.tableView reloadData];
                            
                            //show tableview and hide activityIndicator
                            [self.tableView setHidden:NO];
                            [self.activityIndicatorView stopAnimating];
                        } else {
                            NSLog(@"Error %@ with user info %@.", error, error.userInfo);
                        }
                    } //end if(responseData)
                }]; //end performRequestWithHandler
            } //end if accounts.count
        } //end if granted
        else {
            NSLog(@"The user does not grant us permission to access its Twitter account(s).");
        }
    }]; // end requestAccessToAccountsWithType

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
