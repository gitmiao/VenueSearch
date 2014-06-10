//
//  Venue.h
//  MapSearch
//
//  Created by Rui Chen on 3/22/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Venue : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * vicinity;

@end
