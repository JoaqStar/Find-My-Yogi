//
//  DetailViewController.m
//  Find My Yogi
//
//  Created by Jeff Berman on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "YogiViewController.h"

@interface YogiViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UIButton *sundayButton;
@property (weak, nonatomic) IBOutlet UIButton *mondayButton;
@property (weak, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *thursdayButton;
@property (weak, nonatomic) IBOutlet UIButton *fridayButton;
@property (weak, nonatomic) IBOutlet UIButton *saturdayButton;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;


- (void)configureView;
@end

@implementation YogiViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    [self.profilePhotoImage setImage:self.detailItem.yogiPhoto];
    
    // Set up instagram button
    [self.instagramButton setImage:[UIImage imageNamed:@"Instagram Logo.png"] forState:UIControlStateNormal];
    [self.instagramButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
  //  self.instagramButton.adjustsImageWhenHighlighted = NO;  // Don't darken button image when pressed
    
    // Choose correct Follow button
    self.yogi = YES;  /*! For testing */
    if (self.isYogi == YES) {
        self.followersButton.hidden = NO;
        self.followButton.hidden = YES;
    } else {
        self.followersButton.hidden = YES;
        self.followButton.hidden = NO;
    }

    // Make days of the week buttons round
    self.sundayButton.layer.cornerRadius = self.sundayButton.bounds.size.width / 2.0;
    self.mondayButton.layer.cornerRadius = self.mondayButton.bounds.size.width / 2.0;
    self.tuesdayButton.layer.cornerRadius = self.tuesdayButton.bounds.size.width / 2.0;
    self.wednesdayButton.layer.cornerRadius = self.wednesdayButton.bounds.size.width / 2.0;
    self.thursdayButton.layer.cornerRadius = self.thursdayButton.bounds.size.width / 2.0;
    self.fridayButton.layer.cornerRadius = self.fridayButton.bounds.size.width / 2.0;
    self.saturdayButton.layer.cornerRadius = self.saturdayButton.bounds.size.width / 2.0;
    
    // Light up those days of the week that have events  /*! For testing */
    self.mondayButton.backgroundColor = [UIColor lightGrayColor];
    self.thursdayButton.backgroundColor = [UIColor lightGrayColor];
    self.wednesdayButton.backgroundColor = [UIColor lightGrayColor];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The "daysOfWeek tappable layer" view is a temporary invisible UIView that sits on top of the
// days-of-the-week buttons and accepts tap gestures.  Its purpose is to intercept taps so the
// entire group of buttons acts as one large button.  When we add more calendar features and want
// each day of the week to be a distinct button, simply delete this view and hook up the individual
// buttons.
- (IBAction)daysOfWeekTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Tapped.");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"calendarSegue"]) {
       // [[segue destinationViewController] setDetailItem:object];
        
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCell" forIndexPath:indexPath];
    
   // UserFeedItem *item = self.userFeedItems[indexPath.row];
   // [cell loadCellFromUserFeedItem:item];
    
    return cell;
}

@end
