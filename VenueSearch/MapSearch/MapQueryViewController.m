//
//  MapQueryViewController.m
//  MapSearch
//
//  Created by Rui Chen on 2/11/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import "MapQueryViewController.h"

@interface MapQueryViewController ()

@property (strong,nonatomic) NSString *queryResult;
@property (strong,nonatomic) NSString *queryTypeResult;
@property (strong,nonatomic) NSString *radiusResult;

@end

@implementation MapQueryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buttonAnimation]; //button falls
    
    [self.queryBar setDelegate:self];
    [self.queryTypeBar setDelegate:self];
    [self.radiusBar setDelegate:self];
    
    //allow keyboard dismiss by tapping screen
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
 
}

- (void)buttonAnimation
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *fall = [[UIGravityBehavior alloc] initWithItems:@[self.button]];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.button]];
    
    //set collision to tabBar
    [collisionBehavior addBoundaryWithIdentifier:@"tabbar"
                                       fromPoint:self.tabBarController.tabBar.frame.origin
                                         toPoint:CGPointMake(self.tabBarController.tabBar.frame.origin.x + self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.origin.y)];
    
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:fall];

    
}

- (void)dismissKeyboard
{
    if([self.queryBar isFirstResponder]){
        self.queryResult = self.queryBar.text;
        [self.queryBar resignFirstResponder];
    }
    else if([self.queryTypeBar isFirstResponder]){
        self.queryTypeResult = self.queryTypeBar.text;
        [self.queryTypeBar resignFirstResponder];
    }else if([self.radiusBar isFirstResponder]){
        self.radiusResult =self.radiusBar.text;
        [self.radiusBar resignFirstResponder];
    }
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self getSearchResult:searchBar];
    [searchBar resignFirstResponder];
}

- (void) getSearchResult: (UISearchBar *) searchBar
{
    if ([searchBar isEqual:self.queryBar]) {
        self.queryResult = searchBar.text;
    }else if ([searchBar isEqual:self.queryTypeBar]){
        self.queryTypeResult = searchBar.text;
    }else{
        self.radiusResult =searchBar.text;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",self.queryResult);
    NSLog(@"%@",self.queryTypeResult);
    NSLog(@"%@",self.radiusResult);
    if([segue.identifier isEqualToString:@"QueryToTab"]){
        MapTabBarSearchController *destination=(MapTabBarSearchController*) segue.destinationViewController;
        destination.query = self.queryResult;
        destination.queryType = self.queryTypeResult;
        destination.radius = self.radiusResult;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Welcome!"
                          message:@"Please enter name of the place you want to search, type(optional) from food, restaurant, gym..., enter only one, radius(optional)"
                          delegate:nil  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];

}
@end
