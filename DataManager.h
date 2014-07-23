//
//  aDataManager.h
//  awesome
//
//  Created by Joaquin Brown on 10/22/13.
//  Copyright (c) 2013 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <CoreLocation/CoreLocation.h>
#import "YogiUser.h"
#import "YogiEvent.h"
#import "YogiPost.h"
#import "YogiVenue.h"

@interface DataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *thisUserId;
@property (strong, nonatomic) NSString *thisUserName;

// Notification for when a user photo has been loaded into the cache.
extern NSString *const UserPhotoDidLoadNotification;

+ (id)sharedManager;

// WORKING
- (YogiUser *)getUser:(NSString *)userId;
- (NSString *)addFacebookUser:(NSDictionary *)fbUser;
- (BOOL)updateUserWithToken:(NSString *)deviceToken;
- (NSString *)getEndpointARNForUserID:(NSString *)userId;
- (NSArray *) getFeedForThisUser;
- (NSArray *) getYogisThisUserFollows;

// WORKS But still need to cache events
- (YogiEvent *)getEventForUser:(NSString *)userId withDate:(NSDate *)eventDate;

// RETURNS FAKE DATA
- (NSInteger)getFollowerCount:(NSString *)userId;
- (NSArray *)getFollowers:(NSString *)userId;

// DOES NOT WORK
- (NSArray *)getNearbyYogis:(CLLocation *)location;
- (NSArray *)getVenue:(NSString *)venueId;
- (NSArray *)getAllVenuesForSearchString:(NSString *)searchString;
- (NSInteger)getOmCountForPostId:(NSString *)postId;
- (NSArray *)getUsersWhoOmedPostId:(NSString *)postId;
- (YogiEvent *)addEvent:(NSString *)title onDate:(NSDate *)eventDate atVenue:(NSString *)venueId;
- (YogiPost *)addPost:(NSString *)message eventDate:(NSDate *)eventDate;
- (BOOL)followYogi:(NSString *)userId;
- (BOOL)omPost:(NSString *)postId;
- (YogiVenue *)addVenue:(NSString *)venueName atAddress1:(NSString *)address1 atAddress2:(NSString *)address2 inCity:(NSString *)city inProvence:(NSString *)provence inCountry:(NSString *)country withPostalCode:(NSString *)postCode withPhoneNumber:(NSString *)phoneNumber;
- (BOOL)checkinToLocation:(CLLocation *)location;

// WE SHOULD PROBABLY CREATE A FACEBOOK CLASS AND MOVE THIS TO THERE
- (UIImage *)photoForUserId:(NSString *)userId;

- (NSError *)saveContext;

@end
