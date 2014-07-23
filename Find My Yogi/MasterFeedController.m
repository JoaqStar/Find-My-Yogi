//
//  MasterFeedController.m
//  Find My Yogi
//
//  Created by Jeff Berman on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "MasterFeedController.h"

#import "YogiViewController.h"
#import "DataManager.h"
#import "YogiUser.h"
#import "YogiPost.h"
#import "YogiEvent.h"
#import "UserFeedCell.h"
#import "UserFeedItem.h"

@interface MasterFeedController ()

@property (strong, nonatomic) NSMutableArray *userFeedItems;  // Array of main feed items
@property (strong, nonatomic) NSArray *postsArray; // Array of feed posts from backend DB table
@property (strong, nonatomic) NSMutableArray *userArray;  // Array of user data from backend DB table
@property (strong, nonatomic) NSMutableArray *eventArray; // Array of event data from backend DB table
@property (strong, nonatomic) DataManager *dataManager;
@end

@implementation MasterFeedController

-(NSMutableArray *)userFeedItems
{
    if (!_userFeedItems) {
        _userFeedItems = [[NSMutableArray alloc] init];
    }
    
    return _userFeedItems;
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.dataManager = [DataManager sharedManager];
    
    // Set color of nav bar items
    [self.navigationController.navigationBar setTintColor:[Tools titleTintColor]];
    
    // Template code to add edit button
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    self.navigationItem.leftBarButtonItem = searchButton;

    // This was template code to add a "+" button in nav bar
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.yogiViewController = (YogiViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Register UserFeedCell class for UITableView -- Not needed when using storyboard?
/*!    [self.tableView registerClass:[UserFeedCell class] forCellReuseIdentifier:@"UserFeedCell"]; */
    
    // Load initial feed data into array properties.  Currently a property for each backend DB table.
    self.postsArray = [self.dataManager getFeedForThisUser];
    for (YogiPost *post in self.postsArray) {
        YogiUser *user = [self.dataManager getUser:post.userId];
        [self.userArray addObject:user];
        
        // Quick & dirty cheat to pre-cache user photos so they're already loaded by the time they're needed.
        [[DataManager sharedManager] photoForUserId:user.userId];
        
        NSLog(@"User: %@ %@", user.firstName, user.lastName);
        NSLog(@"bio: %@", user.bio);
        NSLog(@"Post message: %@", post.message);
        if (post.eventDate) {
            // Load in event info if it exists.  Add onto this code once getEvent: is written.
            YogiEvent *event = [self.dataManager getEventForUser:post.userId withDate:post.eventDate];
            NSLog(@"Event title: %@", event.title);
        }
    }
}


- (void)search:(id)sender
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        YogiUser *user = self.userArray[indexPath.row];
        [[segue destinationViewController] setYogiUser:user];
    }
}


- (NSMutableArray *)userArray
{
    if (!_userArray) {
        _userArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return _userArray;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserFeedCell" forIndexPath:indexPath];

    YogiPost *post = self.postsArray[indexPath.row];
    YogiUser *user = self.userArray[indexPath.row];
    [cell loadCellFromYogiPost:post yogiUser:user yogiEvent:nil];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UserFeedItem *object = self.userFeedItems[indexPath.row];
        self.yogiViewController.detailItem = object;
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
- (void)insertNewObject:(id)sender
{
    [self.userFeedItems insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/


/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.userFeedItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
@end
