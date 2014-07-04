//
//  UserFeedCell.h
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFeedItem.h"

@interface UserFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *yogiImage;
@property (nonatomic, weak) IBOutlet UILabel *yogiNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *eventInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *omButton;

-(void)loadCellFromUserFeedItem:(UserFeedItem *)feedItem;

@end
