//
//  YogiVenue.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/23/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiVenue : NSManagedObject

@property (nonatomic, retain) NSString * address1;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * provence;
@property (nonatomic, retain) NSNumber * venueId;

@end
