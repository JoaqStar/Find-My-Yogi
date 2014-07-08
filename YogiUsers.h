//
//  YogiUsers.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/7/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiUsers : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSNumber * isYogi;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * loginType;
@property (nonatomic, retain) NSString * deviceToken;
@property (nonatomic, retain) NSString * endpointARN;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * lastLogin;
@property (nonatomic, retain) NSSet *posts;
@property (nonatomic, retain) NSSet *events;
@end

@interface YogiUsers (CoreDataGeneratedAccessors)

- (void)addPostsObject:(NSManagedObject *)value;
- (void)removePostsObject:(NSManagedObject *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
