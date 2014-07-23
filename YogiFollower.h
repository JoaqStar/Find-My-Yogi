//
//  YogiFollower.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/23/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiFollower : NSManagedObject

@property (nonatomic, retain) NSString * followerId;
@property (nonatomic, retain) NSString * userId;

@end
