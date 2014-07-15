//
//  aDataManager.m
//  awesome
//
//  Created by Joaquin Brown on 10/22/13.
//  Copyright (c) 2013 Joaquin Brown. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "AWSPersistenceDynamoDBIncrementalStore.h"
#import <AWSRuntime/AWSRuntime.h>
#import "AmazonClientManager.h"

@interface DataManager ()

@property (nonatomic, strong) NSString *deviceToken;

@end

@implementation DataManager

#pragma mark Singleton Methods
+ (id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
        [AmazonErrorHandler shouldNotThrowExceptions];
        
        // call managed context just to set up context and to set up persistant store coordianator 
        [self managedObjectContext];
        
        [self getThisUser:nil];
    }
    return self;
}

#pragma mark User Methods
- (BOOL)updateUserWithToken:(NSString *)deviceToken {

    YogiUser *user = [self getThisUser:nil];
    
    self.deviceToken = deviceToken;
    
    if (user != nil && [user.deviceToken isEqualToString:deviceToken] == NO && [self.deviceToken length] > 0) {
        NSLog(@"updating token to %@", self.deviceToken);
        user.deviceToken = self.deviceToken;
        [self saveContext];
    }
    
    return YES;
}
- (NSString *)addUser:(NSString *)userId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    YogiUser *user = [NSEntityDescription insertNewObjectForEntityForName:USERS_TABLE inManagedObjectContext:context];
    
    user.userId = userId;
    user.createDate = [NSDate date];
    user.isYogi = [NSNumber numberWithBool:YES];
    [self setTokenAndEndpointARNForUser:user];
    
    self.thisUserId = user.userId;
    [self saveContext];
    return @"success";
}

- (NSString *)addFacebookUser:(NSDictionary *)fbUser
{
    YogiUser *user = [self getThisUser:fbUser[@"id"]];
    
    if (user == nil) {
        return [self addUser:fbUser[@"id"]];
    } else {
        return @"success";
    }
}

- (void)delete:(NSManagedObject *)object
{
    [self.managedObjectContext deleteObject:object];
}

-(YogiUser *)getThisUser:(NSString *)userId {
    
    // If userId is nil, then see if there is any value stored in thisUserId
    if (userId == nil && self.thisUserId != nil) {
        userId = self.thisUserId;
    }
    
    @synchronized([self class])
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        YogiUser *user;
        
        NSEntityDescription *entity = [NSEntityDescription
                                                  entityForName:USERS_TABLE inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        NSString *queryString = [NSString stringWithFormat:@"%@ = %@", USERS_KEY, userId];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:queryString];
        [request setPredicate:predicate];
        
        NSError *error;
        NSArray *users = [context executeFetchRequest:request error:&error];
        
        if (error) {
            [self throwError:error];
            return nil;
        }
        
        if ([users count] == 0) {
            [self addUser:userId];
        } else {
            user = [users objectAtIndex:0];
            user.lastLogin = [NSDate date];
            [self setTokenAndEndpointARNForUser:user];
            self.thisUserId = user.userId;
            
            [self saveContext];
        }
        
        return user;
    }
}

-(void) setTokenAndEndpointARNForUser:(YogiUser *)user
{
//    // If the token is empty, or if it's changed then add it
//    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.deviceToken != nil && [appDelegate.deviceToken isEqualToString:user.deviceToken] == NO) {
//        user.deviceToken = appDelegate.deviceToken;
//        // Set endpointARN to nil so we know to update it
//        user.endpointARN = nil;
//    }
//    // If we have a device token but not an endpointARN, add it
//    if (user.deviceToken != nil && user.endpointARN == nil) {
//        SNSMessenger *messenger = [SNSMessenger sharedManager];
//        NSString *endpoint = [messenger createEndpointARNFromToken:user.deviceToken forUser:user.userId];
//        if (endpoint != nil) {
//            user.endpointARN = endpoint;
//        }
//    }
}

-(NSString *)getEndpointARNForUserID:(NSString *)userId
{
    @synchronized([self class])
    {
        NSString *endpointARN;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        YogiUser *user;
        
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:USERS_TABLE inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:@"%@ = %@", USERS_TABLE, userId];
        [request setPredicate:predicate];
        
        NSError *error;
        NSArray *users = [context executeFetchRequest:request error:&error];
        
        if (error) {
            NSLog(@"Error was %@", error);
        } else {
            if ([users count] > 0) {
                user = [users objectAtIndex:0];
                endpointARN = user.endpointARN;
            }
        }
        
        return endpointARN;
    }
}

#pragma mark - Error handling
- (void)throwError:(NSError *)error
{
    NSLog(@"Error is %@", error);
    
    [[[UIAlertView alloc] initWithTitle:@"Whoops!"
                                message:@"We could not connect to the Yogi Network. Please try again."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - Core Data stack
- (NSError *)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    return error;
}
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        //Undo Support
        NSUndoManager *undoManager = [NSUndoManager new];
        _managedObjectContext.undoManager = undoManager;
        
        _managedObjectContext.persistentStoreCoordinator = coordinator;
        _managedObjectContext.mergePolicy = [[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyStoreTrumpMergePolicyType];
    }

    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error;
    
    // Registers the AWSNSIncrementalStore
    [NSPersistentStoreCoordinator registerStoreClass:[AWSPersistenceDynamoDBIncrementalStore class] forStoreType:AWSPersistenceDynamoDBIncrementalStoreType];
    
    // Instantiates PersistentStoreCoordinator
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
//    
//    // handle db upgrade
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//    
//    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
//        /*
//         Replace this implementation with code to handle the error appropriately.
//         
//         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//         
//         Typical reasons for an error here include:
//         * The persistent store is not accessible;
//         * The schema for the persistent store is incompatible with current managed object model.
//         Check the error message to determine what the actual problem was.
//         
//         
//         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//         
//         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//         * Simply deleting the existing store:
//         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//         
//         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
//         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
//         
//         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//         
//         */
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
    
    // Creates options for the AWSNSIncrementalStore
    NSDictionary *hashKeys = [NSDictionary dictionaryWithObjectsAndKeys:
                              USERS_KEY, USERS_TABLE,
                              nil];
//    NSDictionary *rangeKeys = [NSDictionary dictionaryWithObjectsAndKeys:
//                               LOCATIONS_RANGE_KEY, @"Location",
//                               AWESOME_RANGE_KEY, @"Awesome",
//                               nil];
    NSDictionary *versions = [NSDictionary dictionaryWithObjectsAndKeys:
                              USERS_VERSIONS,USERS_TABLE,
                              nil];
    NSDictionary *tableMapper = [NSDictionary dictionaryWithObjectsAndKeys:
                                 USERS_TABLE, USERS_TABLE,
                                 nil];
    
    AmazonWIFCredentialsProvider *provider = [AmazonClientManager provider];
    
    self.thisUserId = provider.subjectFromWIF;
    
    //AmazonClientManager *provider = [AmazonClientManager new];
    
    AmazonDynamoDBClient *ddb = [[AmazonDynamoDBClient alloc] initWithCredentialsProvider:provider];
    ddb.endpoint = [AmazonEndpoints ddbEndpoint:US_WEST_1];
    
    NSDictionary *storeOoptions = [NSDictionary dictionaryWithObjectsAndKeys:
                             hashKeys, AWSPersistenceDynamoDBHashKey,
                             versions, AWSPersistenceDynamoDBVersionKey,
//                             rangeKeys, AWSPersistenceDynamoDBRangeKey,
                             ddb, AWSPersistenceDynamoDBClient,
                             tableMapper, AWSPersistenceDynamoDBTableMapper, nil];
    
    // Adds the AWSNSIncrementalStore to the PersistentStoreCoordinator
    if(![_persistentStoreCoordinator addPersistentStoreWithType:AWSPersistenceDynamoDBIncrementalStoreType
                                                  configuration:nil
                                                            URL:nil
                                                        options:storeOoptions
                                                          error:&error])
    {
        // Handle the error.
        NSLog(@"Unable to create store. Error: %@", error);
    }

    
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
