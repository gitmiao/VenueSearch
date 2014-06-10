//
//  MapBaseViewController.h
//  MapSearch
//
//  Created by Rui Chen on 2/7/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapBaseViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSString *queryType;
@property (strong, nonatomic) NSString *radius;

//@property(strong, nonatomic) MapTableResultViewController *tableView;
@property (nonatomic, strong) NSMutableArray *venues;
@end
