//
//  MyMapAnnotation.h
//  MapSearch
//
//  Created by Rui Chen on 2/8/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyMapAnnotation : NSObject <MKAnnotation>{
    NSString *title;
    NSString *subtitle;
    NSString *note;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@end
