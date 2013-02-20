//
//  MLPointClient.h
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "AFHTTPClient.h"

@interface MLPointClient : AFHTTPClient

+ (id)sharedInstance;

- (void)globalTimelineContactsWithBlock:(void   (^)(NSMutableArray *results, NSError* error))block;
- (void)saveLocationArray;
//- (void)loadLocationArray;

@end
