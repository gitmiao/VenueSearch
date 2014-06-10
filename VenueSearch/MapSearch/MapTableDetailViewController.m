//
//  MapTableDetailViewController.m
//  MapSearch
//
//  Created by Rui Chen on 3/21/14.
//  Copyright (c) 2014 Rui Chen. All rights reserved.
//

#import "MapTableDetailViewController.h"
#import "MapAppDelegate.h"

@interface MapTableDetailViewController ()

@property(retain, nonatomic)NSManagedObjectContext *context;

@end

@implementation MapTableDetailViewController
@synthesize name, vicinity, type;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.name;
    self.adLabel.text = self.vicinity;
    self.typeLabel.text = self.type;
    // Do any additional setup after loading the view.
    //set button status
    //NSLog(@"%d",[self searchFromBookmark]);
    MapAppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    self.context = [appdelegate managedObjectContext];

    if ([self searchFromBookmark] == 1) {
        [self.bookmarkButton setSelected:YES];
    }else{
        [self.bookmarkButton setSelected:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)bookmark:(id)sender {
    if([sender isSelected]){
        
        [sender setSelected:NO];
        [self removeFromBookmark];
        
    } else {
        
        [sender setSelected:YES];
        [self addToBookmark];
        
    }
}

- (void)addToBookmark
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:self.context];
    NSManagedObject *newVenue = [[NSManagedObject alloc] initWithEntity:entitydesc insertIntoManagedObjectContext:self.context];
    
    NSLog(@"%@",self.name);
    [newVenue setValue:self.name forKey:@"name"];
    [newVenue setValue:self.vicinity forKey:@"vicinity"];
    
    NSError *error;
    [self.context save:&error];
    NSLog(@"saved");
    
}

- (void)removeFromBookmark
{
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:self.context];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name LIKE %@) AND (vicinity LIKE %@)",self.name, self.vicinity];
    [req setEntity:entitydesc];
    [req setPredicate:pred];
    NSError *error;
    NSArray *queryResults = [self.context executeFetchRequest:req error:&error ];
    
    for (NSManagedObject *obj in queryResults) {
        [self.context deleteObject:obj];
    }
    
    [self.context save:&error];
    NSLog(@"complete");
}

- (int)searchFromBookmark
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:self.context];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name LIKE %@) AND (vicinity LIKE %@)",self.name, self.vicinity];
    [req setEntity:entitydesc];
    [req setPredicate:pred];
    NSError *error;
    NSArray *queryResults = [self.context executeFetchRequest:req error:&error ];
    if ([queryResults count] > 0) {
        return 1;
    }else{
        return 0;
    }
}



@end
