//
//  YogiOms.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/7/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiOms : NSManagedObject

@property (nonatomic, retain) NSNumber * postId;
@property (nonatomic, retain) NSString * userId;

@end
