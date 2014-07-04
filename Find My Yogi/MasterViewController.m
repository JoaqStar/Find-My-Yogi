//
//  MasterViewController.m
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "UserFeedCell.h"
#import "UserFeedItem.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) NSMutableArray *userFeedItems;  // Array of main feed items

@end

@implementation MasterViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set color of nav bar items
    [self.navigationController.navigationBar setTintColor:[Tools titleTintColor]];
    
    // Template code to add edit button
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    self.navigationItem.leftBarButtonItem = searchButton;

    // This was template code to add a "+" button in nav bar
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Register UserFeedCell class for UITableView -- Not needed when using storyboard?
/*!    [self.tableView registerClass:[UserFeedCell class] forCellReuseIdentifier:@"UserFeedCell"]; */
    
    // Create test data
    UserFeedItem *item = [[UserFeedItem alloc] init];
    item.postID = 1;
    item.userID = 1;
    item.name = @"Joaquin Brown";
    item.message = @"Just mastered a new pose, I'll be teaching it in my advanced class on Thursday!";
    [self.userFeedItems addObject:item];
    
    item = [[UserFeedItem alloc] init];
    item.postID = 2;
    item.userID = 1;
    item.name = @"Joaquin Brown";
    item.message = @"Feeling pumped about tomorrow's Pilates class!";
    [self.userFeedItems addObject:item];
    
    item = [[UserFeedItem alloc] init];
    item.postID = 3;
    item.userID = 1;
    item.name = @"Jeff Berman";
    item.message = @"I'll be at YogaExpo at booth 119 all day, stop by and say hello!";
    [self.userFeedItems addObject:item];
}

- (void)search:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserFeedCell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    
    cell.yogiNameLabel.text = @"Jeff Berman";
    cell.messageLabel.text = @"Hi everyone, I'll be subbing for Mark at tomorrow's 8:30 class, it's going to be a blast.  Hope to see you there!  ";
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
