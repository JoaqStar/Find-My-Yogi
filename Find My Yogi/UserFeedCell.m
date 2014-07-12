//
//  UserFeedCell.m
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "UserFeedCell.h"
#import "Tools.h"

@implementation UserFeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Populate cell contents from passed-in data
- (void)loadCellFromUserFeedItem:(UserFeedItem *)feedItem
{
    self.yogiNameLabel.text = feedItem.name;
    self.messageLabel.text = feedItem.message;
    self.eventInfoLabel.text = feedItem.eventDescription;
    [self.yogiImage setImage:feedItem.yogiPhoto];
    
    // Determine Om image
    feedItem.liked = NO; // This line for testing
    if (self.omButton.imageView.image == nil) {
        UIImage *originalImage = [UIImage imageNamed:@"thumbs_up.png"];
        [self.omButton setImage:[originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        self.omButton.adjustsImageWhenHighlighted = NO;  // Don't darken button image when pressed
    }
    
    if (feedItem.isLiked) {
        self.omButton.tintColor = [Tools likeTintColor];
        self.omButton.selected = YES;
    } else {
        self.omButton.tintColor = [UIColor darkGrayColor];
        self.omButton.selected = NO;
        
    }
}

- (IBAction)likeButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.isSelected;

    if (sender.isSelected) {
        self.omButton.tintColor = [Tools likeTintColor];
        self.omButton.selected = YES;
        /*! Change "like" status in DB */
    } else {
        self.omButton.tintColor = [UIColor darkGrayColor];
        self.omButton.selected = NO;
        /*! Change "like" status in DB */        
    }
    NSLog(@"Button was pressed. State is %@", sender.selected ? @"Selected" : @"Not selected");
}


@end
