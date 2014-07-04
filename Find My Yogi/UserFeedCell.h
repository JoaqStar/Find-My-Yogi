//
//  YogiFeedCell.h
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFeedCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *yogiImage;
@property (nonatomic, weak) IBOutlet UILabel *yogiNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *eventInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *omButton;

@end
