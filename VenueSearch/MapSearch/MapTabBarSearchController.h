//
//  MapTabBarSearchController.h
//  MapSearch
//
//  Created by Rui Chen on 3/21/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 

@interface MapTabBarSearchController : UITabBarController<UISearchBarDelegate>

@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSString *queryType;
@property (strong, nonatomic) NSString *radius;

@end
