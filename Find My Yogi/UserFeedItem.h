//
//  UserFeedItem.h
//  Find My Yogi
//
//  Created by Jeff Berman on 7/3/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//
// Represents a single item on a user's feed.

/*** Not Needed -- Model objects come from Core Data ***/

#import <Foundation/Foundation.h>

@interface UserFeedItem : NSObject

@property NSUInteger postID;
@property NSUInteger userID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *yogiPhoto;
@property (strong, nonatomic) NSDate *postDate;
@property (strong, nonatomic) NSString *message;
@property NSUInteger eventID;
@property (strong, nonatomic) NSString *eventDescription;
@property (getter = isLiked) BOOL liked; /*! Should this be here or derived on-the-fly? */

@end
