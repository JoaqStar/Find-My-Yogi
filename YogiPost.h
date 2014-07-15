//
//  YogiPost.h
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/15/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YogiPost : NSManagedObject

@property (nonatomic, retain) NSNumber * eventId;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * postDate;
@property (nonatomic, retain) NSNumber * postId;
@property (nonatomic, retain) NSString * userId;

@end
