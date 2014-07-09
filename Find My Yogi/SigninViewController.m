//
//  SigninViewController.m
//  Find My Yogi
//
//  Created by Joaquin Brown on 7/8/14.
//  Copyright (c) 2014 Joaquin Brown. All rights reserved.
//

#import "SigninViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "AmazonClientManager.h"
#import "AppDelegate.h"
#import "Tools.h"

@interface SigninViewController ()

@property (nonatomic, weak) IBOutlet UIButton *facebookButton;

@end

@implementation SigninViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
