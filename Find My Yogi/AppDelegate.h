//
//  AppDelegate.h
//  Find My Yogi
//
//  Created by Jeff on 7/1/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tools.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI withCompletion:(void (^)(FBSession *session, NSError *error))callback;

@end
