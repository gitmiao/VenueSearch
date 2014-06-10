//
//  MapTableDetailViewController.h
//  MapSearch
//
//  Created by Rui Chen on 3/21/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapTableDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;

- (IBAction)bookmark:(id)sender;

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *vicinity;
@property(strong,nonatomic) NSString *type;
@end
