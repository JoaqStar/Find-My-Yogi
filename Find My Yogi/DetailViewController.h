//
//  DetailViewController.h
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFeedItem.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) UserFeedItem *detailItem;

@property (getter = isYogi) BOOL yogi; // Temp? -- am I a yogi

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImage;
@property (weak, nonatomic) IBOutlet UILabel *shortBioLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UIButton *followersButton;
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;
@end
