//
//  MapTableResultViewController.m
//  MapSearch
//
//  Created by Rui Chen on 3/21/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import "MapTableResultViewController.h"
#import "MapTableDetailViewController.h"

@interface MapTableResultViewController ()

@property(strong,nonatomic)NSMutableArray *results;
@property(strong,nonatomic)NSMutableArray *array;

@end

@implementation MapTableResultViewController
@synthesize table;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array = [NSMutableArray new];
    MapBaseViewController *mapView = (MapBaseViewController*)[self.tabBarController.viewControllers objectAtIndex:0];
    
    self.results = mapView.venues;
    if ([self.results count] == 0) {
        
        [self nonResultAlert];
    }else{
        for (int i=0; i < [self.results count]; i++) {
            NSString *address = [self.results[i] objectForKey:@"vicinity"];
            [self.array addObject:address];
        }
    }
    
    self.tabBarController.delegate = self;
    self.table.delegate = self;
    self.table.dataSource = self;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TableToDetail"]) {
        NSIndexPath *indexPath = nil;
        indexPath = [table indexPathForSelectedRow];
        NSString *name = [self.results[indexPath.row] objectForKey: @"name"];
        NSString *vicinity = [self.results[indexPath.row] objectForKey: @"vicinity"];
        NSMutableArray *type = [self.results[indexPath.row] objectForKey: @"types"];
        NSString *typeStr = [type componentsJoinedByString:@", "];
        NSLog(@"%@", typeStr);
        NSLog(@"%@",vicinity);
        [[segue destinationViewController] setName:name];
        [[segue destinationViewController] setVicinity:vicinity];
        [[segue destinationViewController] setType:typeStr];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
