//
//  YogiUsers.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/8/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YogiEvents, YogiPosts;

@interface YogiUsers : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * deviceToken;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * endpointARN;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * isYogi;
@property (nonatomic, retain) NSDate * lastLogin;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * loginType;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSSet *events;
@property (nonatomic, retain) NSSet *posts;
@end

@interface YogiUsers (CoreDataGeneratedAccessors)

- (void)addEventsObject:(YogiEvents *)value;
- (void)removeEventsObject:(YogiEvents *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

- (void)addPostsObject:(YogiPosts *)value;
- (void)removePostsObject:(YogiPosts *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

@end
