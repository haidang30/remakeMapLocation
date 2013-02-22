//
//  MLPointClient.m
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MLPointClient.h"

@interface MLPointClient()
@property (nonatomic, strong) NSMutableArray *allLocations;
@end

@implementation MLPointClient

+ (id)sharedInstance
{
    static MLPointClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[MLPointClient alloc] initWithBaseURL:[NSURL URLWithString:kLocationAPIBaseURLString]];
    });
    
    return __sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.allLocations = [NSMutableArray array];
    
    return self;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self setDefaultHeader:@"x-api-token" value:kLocationAPIToken];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}
//- (void)globalTimelineContactsWithBlock:(void (^)(NSMutableArray *results, NSError *error))block {
//    
//    [self getPath:kLocationAPIPath parameters:nil
//          success:^(AFHTTPRequestOperation *operation, id response) {
//              
//              NSMutableArray *locations = [NSMutableArray arrayWithCapacity:[response count]];
//              
//              for (id obj in response)
//              {
//                  if ([obj isKindOfClass:[NSDictionary class]])
//                  {
//                      MLMapPoint *point = [[MLMapPoint alloc] initWithDictionary:(NSDictionary *)obj];
//                      [locations addObject:point];
//                  }
//              }
//              
//              self.allLocations = locations;
//              
//              if (block) {
//                  block(locations, nil);
//              }
//          }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              if (block) {
//                  block([NSMutableArray array], error);
//              }
//          }];
//}

@end
