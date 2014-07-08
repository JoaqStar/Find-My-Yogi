//
//  YogiEvents.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/7/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YogiUsers, YogiVenues;

@interface YogiEvents : NSManagedObject

@property (nonatomic, retain) NSNumber * eventId;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSNumber * venueId;
@property (nonatomic, retain) NSDate * eventDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) YogiUsers *user;
@property (nonatomic, retain) YogiVenues *venue;

@end
