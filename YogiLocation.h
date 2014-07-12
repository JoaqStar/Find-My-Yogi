//
//  YogiLocation.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/9/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSDate * locationDate;
@property (nonatomic, retain) NSString * locationKey;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * userId;

@end
