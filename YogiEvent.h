//
//  YogiEvent.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/15/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YogiPost, YogiUser, YogiVenue;

@interface YogiEvent : NSManagedObject

@property (nonatomic, retain) NSDate * eventDate;
@property (nonatomic, retain) NSNumber * eventId;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSNumber * venueId;
@property (nonatomic, retain) YogiPost *post;
@property (nonatomic, retain) YogiUser *user;
@property (nonatomic, retain) YogiVenue *venue;

@end
