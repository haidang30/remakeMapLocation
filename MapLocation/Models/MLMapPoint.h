//
//  MLMapPoint.h
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLMapPoint : NSObject <MKAnnotation>
{
    NSString *_name;
    NSString *_street;
//    NSString *_description;
}
@property (copy) NSString *name;
@property (copy) NSString *address;
//@property (copy) NSString *description;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithName:(NSString*)name
          address:(NSString*)address
       coordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithDictionary:(NSDictionary *)locationDictionary;

//- (void)encodeWithCoder:(NSCoder *)aCoder;
//- (id)initWithCoder:(NSCoder *)aDecoder;

@end
