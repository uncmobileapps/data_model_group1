//
//  UMATweet.h
//  twittertest
//
//  Created by Bryan Gaston on 11/27/12.
//  Copyright (c) 2012 UNC-CH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMATweet : NSObject

/*
 latitude: 43.000012
 longitude: -73.020483
 proximity: “1.23 Miles”
 user: “@sammy234”
 tweetAge: “3 minutes”
 tweetText: “I’m at #TopO for my birthday!”
 */
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *proximity;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *tweetAge;
@property (strong, nonatomic) NSString *tweetText;

//method that map and feed view controllers will call to get NSMutableArray of UMATweet objects
//+ (NSMutableArray*)getTweetObjects;

//This will calculate the proximity in feet between two sets of lat/long. Vikram is in charge of this (use distance formula and then convert to feet).
+ (NSNumber*)getProximityInFeetFromDeviceLatitude:(NSNumber*)deviceLatitude deviceLongitude:(NSNumber*)deviceLongitude tweetLatitude:(NSNumber*)tweetLatitude tweetLongitude:(NSNumber*)tweetLongitude;

//This will calculate the difference between the current time and the tweet time to return the tweetAge as a string.
+ (NSString*)calculateTweetAgeAsStringFromUTCTimestamp:(NSString*)UTCTimestampAsString;

@end
