//
//  MLViewController.m
//  MapLocation
//
//  Created by viet on 2/19/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()
@property (strong, nonatomic) NSMutableArray *results;
@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self;
    //ensure that your own loaction can be view in the map view
    [self.mapView setShowsUserLocation:YES];
    //instantiate a location object
    locationManager = [[CLLocationManager alloc] init];
    //make this controller the delegate for the location manager
    [locationManager setDelegate:self];
    //set some parameters for the location object
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate methods.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,latDistance,longDistance);
    
    [mapView setRegion:region animated:YES];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //set east and west points for calculate zoom level
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //Set current distance
    currenDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    //Set current center point
    currentCentre = self.mapView.centerCoordinate;
}

#pragma mark - Helpers functions


//
//- (void)loadDataFromServer
//{
//    __weak MLViewController *weakSelf = self;
//
//    [[MLPointClient sharedInstance] globalTimelineContactsWithBlock:^(NSMutableArray *results, NSError *error)
//     {
//         if (error)
//         {
//             [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
//                                         message:[error localizedDescription]
//                                        delegate:nil
//                               cancelButtonTitle:nil
//                               otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
//         }
//         else
//         {
//             weakSelf.results = results;
//             weakSelf.tableView.scrollEnabled = YES;
//             [weakSelf.tableView.pullToRefreshView stopAnimating];
//         }
//         
//         [spinner stopAnimating];
//         weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
//         
//         [self reloadUI];
//     }];
//}

@end
