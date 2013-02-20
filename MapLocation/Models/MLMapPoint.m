//
//  MLMapPoint.m
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MLMapPoint.h"

@implementation MLMapPoint

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    
    return self;
}

//- (id)initWithDictionary:(NSDictionary *)locationDictionary
//{
//    self = [super init];
//    
//    if (self) {
//        self.name = [locationDictionary objectForKey:@"name"];
//        self.address = [locationDictionary objectForKey:@"address"];
////        self.coordinate = [locationDictionary objectForKey:@"coordinate"];
//    }
//}

- (NSString*)title
{
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknow charge";
    else
        return _name;
}

- (NSString*)subtitle
{
    return _address;
}



@end
