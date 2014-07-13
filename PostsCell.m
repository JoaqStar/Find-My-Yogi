//
//  PostsCell.m
//  Find My Yogi
//
//  Created by Jeff Berman on 7/12/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "PostsCell.h"

@implementation PostsCell

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

@end
