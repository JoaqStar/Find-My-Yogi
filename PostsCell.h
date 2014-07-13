//
//  PostsCell.h
//  Find My Yogi
//
//  Created by Jeff Berman on 7/12/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//
//  Lays out the cell elements in the Posts table view that's in
//  the Profile scene.

#import <UIKit/UIKit.h>

@interface PostsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postsCellMessage;
@property (weak, nonatomic) IBOutlet UILabel *postsCellLikesCount;

@end
