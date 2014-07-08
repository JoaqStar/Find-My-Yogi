//
//  YogiFollowers.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/7/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiFollowers : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * followerId;

@end
