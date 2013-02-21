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
    CLLocationCoordinate2D _coordinate;
}
@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

//@interface MapPoint : NSObject <MKAnnotation>
//{
//    
//    NSString *_name;
//    NSString *_address;
//    CLLocationCoordinate2D _coordinate;
//    
//}
//
//@property (copy) NSString *name;
//@property (copy) NSString *address;
//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
//
//- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
//
//@end

@end
