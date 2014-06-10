//
//  MapTableResultViewController.h
//  MapSearch
//
//  Created by Rui Chen on 3/21/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapBaseViewController.h"

@interface MapTableResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
