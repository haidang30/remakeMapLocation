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
    
    firstLaunch = YES;
}

#pragma loading data from API

-(void) queryGooglePlaces: (NSString *) googleType
{
    // Build the url string to send to Google.
    
    NSString *url = [NSString stringWithFormat:kGoogleAPIRequest, currentCentre.latitude, currentCentre.longitude, [NSString stringWithFormat:@"%i", currenDist], googleType, kGOOGLE_API_KEY];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    
    
}

- (void)fetchedData:(NSData *)responseData
{
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", places);
    
    //Plot the data in the places array onto the map with the plotPostions method.
    [self pinPositions:places];
}

- (void)pinPositions:(NSArray *)data
{
    for (id<MKAnnotation> annotation in self.mapView.annotations)
    {
        if ([annotation isKindOfClass:[MLMapPoint class]])
        {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    for (int i = 0; i < [data count]; i++)
    {
        NSDictionary *place     = [data objectAtIndex:i];
        NSDictionary *geometry  = [place objectForKey:@"geometry"];
        
        NSString     *name      = [place objectForKey:@"name"];
        NSString     *vicinity  = [place objectForKey:@"vicinity"];
        
        NSDictionary *location  = [geometry objectForKey:@"location"];
        
        
        CLLocationCoordinate2D placeCoord;
        placeCoord.latitude     = [[location objectForKey:@"lat"] doubleValue];
        placeCoord.longitude    = [[location objectForKey:@"lng"] doubleValue];
        
        MLMapPoint *placeObject = [[MLMapPoint alloc] initWithName:name
                                                           address:vicinity
                                                        coordinate:placeCoord];
        
        [self.mapView addAnnotation:placeObject];
    }
}


#pragma on Button methods

- (IBAction)onToolBarBtnPressed:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    NSString *buttonTitle = [button.title lowercaseString];
    
    [self queryGooglePlaces:buttonTitle];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - MKMapViewDelegate methods.
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Define your reuse identifier.
    static NSString *identifier = @"MapPoint";
    
    if ([annotation isKindOfClass:[MLMapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    CLLocationCoordinate2D center = [mapView centerCoordinate];
    
    MKCoordinateRegion region;
    if (firstLaunch)
    {
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,latDistance,longDistance);
        firstLaunch = NO;
    }
    else
    {
        region = MKCoordinateRegionMakeWithDistance(center, currenDist, currenDist);
    }
    
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
