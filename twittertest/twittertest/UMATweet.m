//
//  UMATweet.m
//  twittertest
//
//  Created by Bryan Gaston on 11/27/12.
//  Copyright (c) 2012 UNC-CH. All rights reserved.
//

#import "UMATweet.h"

@implementation UMATweet

@synthesize latitude;
@synthesize longitude;
@synthesize proximity;
@synthesize user;
@synthesize tweetAge;
@synthesize tweetText;

//This will calculate the proximity in feet between two sets of lat/long.  Vikram is working on this method.
+ (NSNumber*)getProximityInFeetFromDeviceLatitude:(NSNumber*)deviceLatitude deviceLongitude:(NSNumber*)deviceLongitude tweetLatitude:(NSNumber*)tweetLatitude tweetLongitude:(NSNumber*)tweetLongitude{
    
    //this is just a placeholder
    NSNumber *proximityInFeet=[NSNumber numberWithFloat:0];
    
    return proximityInFeet;
}

//This will calculate the difference between the current time and the tweet time to return the tweetAge as a string.
+ (NSString*)calculateTweetAgeAsStringFromUTCTimestamp:(NSString*)UTCTimestampAsString{
    
    NSDate *currentDateTime = [NSDate date];
    
    //finish this
    
    //this is just a placeholder
    NSString *tweetAgeString = @"1 day and 2 minutes";
    return tweetAgeString;
}

/*
//returns array of UMATweet objects
+ (NSMutableArray*)getTweetObjects{
    
    NSMutableArray *allTweetsArray = [[NSMutableArray alloc]init];
        
//    UMATweet *aTweet = [[UMATweet alloc] init];

    
//    [allTweetsArray addObject:aTweet];
    

    return allTweetsArray;
}
*/

@end
