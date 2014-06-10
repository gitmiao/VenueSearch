//
//  MapFavorViewController.h
//  MapSearch
//
//  Created by Rui Chen on 4/6/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapFavorViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@end
