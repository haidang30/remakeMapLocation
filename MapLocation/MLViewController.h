//
//  MLViewController.h
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCentre;
    int currenDist;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
