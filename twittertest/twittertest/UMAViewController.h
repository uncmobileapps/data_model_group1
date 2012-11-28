//
//  UMAViewController.h
//  twittertest
//
//  Created by Bryan Gaston on 11/13/12.
//  Copyright (c) 2012 UNC-CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface UMAViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    __weak UITableView *_tableView;
    __weak UIActivityIndicatorView *_activityIndicatorView;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
@end
