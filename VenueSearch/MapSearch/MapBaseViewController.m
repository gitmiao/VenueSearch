//
//  MapBaseViewController.m
//  MapSearch
//
//  Created by Rui Chen on 2/7/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <objc/runtime.h>
#import "MapBaseViewController.h"
#import <COMSMapManager/COMSMapManager.h>
#import "MyMapAnnotation.h"
#import "MapTabBarSearchController.h"

#define METER_PER_MILE 1609.344
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MapBaseViewController ()

@property (nonatomic, strong)CLLocationManager *locationMangager;
@property (nonatomic) CLLocationCoordinate2D coord;
@end


@implementation MapBaseViewController

- (void)awakeFromNib{
    self.locationMangager = [CLLocationManager new];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MapTabBarSearchController *tab = (MapTabBarSearchController *)self.tabBarController;
    self.query = tab.query;
    self.queryType = tab.queryType;
    self.radius =tab.radius;
  
    // set default queryType and redius
    if ([self.queryType length] == 0){
        self.queryType = @"restaurant|hotel";
    }
    if ([self.radius length] == 0){
        self.radius = @"1";
    }

    self.locationMangager = [[CLLocationManager alloc] init];
    [self.locationMangager setDelegate:self];
    [self.locationMangager startUpdatingLocation];
	
    //self.mapView.showsUserLocation = YES;

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *loc = [locations lastObject];
    self.coord = loc.coordinate;
    
    // stop location update
    [self.locationMangager stopUpdatingLocation];
    [self zoomToRegion];
    
    /*
    [GoogleMapManager nearestVenuesForLatLong:self.coord withinRadius:[self.radius doubleValue]*METER_PER_MILE
                                     forQuery:self.query queryType:self.queryType
                             googleMapsAPIKey:@"AIzaSyC7lKb4Q6BWrCoNeUPN5hL9J6GETLuN4rA"
                             searchCompletion:^(NSMutableArray *results) {
                                
                                 self.venues = results;
                                
                                 //NSLog(@"%@",results);
                                 if ([results count] == 0) {
                                     NSLog(@"no result");
                                     [self nonResultAlert];
                                 }else{
                                     [self displayVenues:results];
                                     }
                                     
                                     
                                 }
                                 
                             }];
     */
    
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%@&types=%@&name=%@&sensor=true&key=AIzaSyC7lKb4Q6BWrCoNeUPN5hL9J6GETLuN4rA", self.coord.latitude, self.coord.longitude, [NSString stringWithFormat:@"%f", [self.radius doubleValue]*METER_PER_MILE], self.queryType, self.query];
    NSLog(@"%@",url);
    //NSURL *requestURL=[NSURL URLWithString:url];
    NSURL *requestURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: requestURL];
        
        if (data != NULL) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
        else{
            NSLog(@"data is null");
        }
        
    });
     
}

-(void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    id result = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    if (error) {
        NSLog(@"error");
    }
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *json = result;
        //The results from Google will be an array obtained from the NSDictionary object with the key "results".
        NSArray* results = [json objectForKey:@"results"];
        
        //Write out the data to the console.
        NSLog(@"Google Data: %@", results);
        self.venues = [[NSMutableArray alloc] initWithArray:results];
        
        //NSLog(@"%@",results);
        if ([results count] == 0) {
            NSLog(@"no result");
            [self nonResultAlert];
        }else{
            //show results on map
            [self displayVenues:results];
        }

    }
    else
    {
        NSLog(@"not ns dictionary");

    }
}

-(void)displayVenues: (NSArray*)results
{
    for (int i=0; i < [results count]; i++) {
        // get coordinate of the venue
        NSDictionary *resLoc=[results[i] objectForKey:@"geometry"];
        NSDictionary *resLatLon=[resLoc objectForKey:@"location"];
        NSNumber *lat=[resLatLon objectForKey:@"lat"];
        NSNumber *lon=[resLatLon objectForKey:@"lng"];
        
        // create an annotation for this venue and pass its coordinate
        MyMapAnnotation *annotation = [[MyMapAnnotation alloc] init];
        CLLocationCoordinate2D venueCoord;
        venueCoord.latitude = [lat doubleValue];
        venueCoord.longitude = [lon doubleValue];
        annotation.coordinate = venueCoord;
        
        // add title and subtitle
        NSString *name = [results[i] objectForKey:@"name"];
        annotation.title = name;
        
        [self.mapView addAnnotation:annotation];
    }

    
}

- (void)nonResultAlert
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"No Results Found"
                          message:nil
                          delegate:nil  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

-(void)zoomToRegion
{
    // zoom the map to user region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.coord, 20*METER_PER_MILE, 20*METER_PER_MILE);
    region = [self.mapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
