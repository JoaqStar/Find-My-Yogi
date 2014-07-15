//
//  YogiUser.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/15/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YogiEvent;

@interface YogiUser : NSManagedObject

@property (nonatomic, retain) NSString * bio;
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
@property (nonatomic, retain) NSSet *events;
@end

@interface YogiUser (CoreDataGeneratedAccessors)

- (void)addEventsObject:(YogiEvent *)value;
- (void)removeEventsObject:(YogiEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
