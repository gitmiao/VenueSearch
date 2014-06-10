//
//  MapQueryViewController.h
//  MapSearch
//
//  Created by Rui Chen on 2/11/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapTabBarSearchController.h"

@interface MapQueryViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *queryBar;
@property (weak, nonatomic) IBOutlet UISearchBar *queryTypeBar;
@property (weak, nonatomic) IBOutlet UISearchBar *radiusBar;

@property (weak,nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonClicked:(id)sender;
@property (nonatomic) UIDynamicAnimator *animator;
@end
