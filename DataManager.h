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

@interface DataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *thisUserId;
@property (strong, nonatomic) NSString *thisUserName;

// Notification for when a user photo has been loaded into the cache.
extern NSString *const UserPhotoDidLoadNotification;

+ (id)sharedManager;

- (YogiUser *)getUser:(NSString *)userId;
- (NSString *)addFacebookUser:(NSDictionary *)fbUser;
- (BOOL)updateUserWithToken:(NSString *)deviceToken;
- (NSString *)getEndpointARNForUserID:(NSString *)userId;

- (NSArray *) getFeedForThisUser;
- (NSArray *) getYogisUserFollows;
- (UIImage *)photoForUserId:(NSString *)userId;

- (NSError *)saveContext;

@end
