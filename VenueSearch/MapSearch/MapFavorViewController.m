//
//  MapFavorViewController.m
//  MapSearch
//
//  Created by Rui Chen on 4/6/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import "MapFavorViewController.h"
#import "MapAppDelegate.h"

@interface MapFavorViewController ()

@property(retain,nonatomic)NSMutableArray *array;

@end

@implementation MapFavorViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.array = [[NSMutableArray alloc] init];

    NSManagedObjectContext *context;
    MapAppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];
   
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:context];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:entitydesc];
    NSError *error;
    NSArray *queryResults = [context executeFetchRequest:req error:&error ];
    if ([queryResults count] > 0) {
        for (NSManagedObject *item in queryResults) {
            //NSLog(@"%@",[item valueForKey:@"name"]);
            //NSLog(@"%@",[item valueForKey:@"vicinity"]);
            NSString *str = [NSString stringWithFormat:@"%@: %@",[item valueForKey:@"name"], [item valueForKey:@"vicinity"]];
            [self.array addObject:str];
        }
    }
    self.table.delegate = self;
    self.table.dataSource = self;

    [self.table reloadData];
     
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"SavedItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
