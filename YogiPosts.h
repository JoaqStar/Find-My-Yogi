//
//  YogiPosts.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/7/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YogiEvents, YogiUsers;

@interface YogiPosts : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSDate * postDate;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * eventId;
@property (nonatomic, retain) NSNumber * postId;
@property (nonatomic, retain) YogiUsers *user;
@property (nonatomic, retain) YogiEvents *event;

@end
