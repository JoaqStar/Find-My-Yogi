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
#import "DataManager.h"
#import "Tools.h"

typedef enum {
    AuthenticationError = -1,
    IsNotAuthorized = 0,
    IsAuthorized = 1,
} AuthenticationStatus;

@interface SigninViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

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
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self checkUserAuthentication];
}

- (void) checkUserAuthentication
{
    AuthenticationStatus status = [self isAuthenticated];
    if (status == AuthenticationError) {
        [[[UIAlertView alloc] initWithTitle:@"Whoops!"
                                    message:@"We could not connect to the Yogi Network. Please try again."
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (status == IsAuthorized) {
        [self.activityIndicator startAnimating];
        [self performSegueWithIdentifier:@"feedSegue" sender:self];
    } else if (status == IsNotAuthorized) {
        [self.activityIndicator stopAnimating];
        [self.facebookButton setEnabled:YES];
    }
}

- (AuthenticationStatus)isAuthenticated {
    
    if (!self.appDelegate.session.isOpen) {
        // create a fresh session object
        self.appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (self.appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            NSArray *permissions = FBSession.activeSession.permissions;
            if ([permissions count] == 0) {
                return NO;
            } else {
                // if the session isn't open, let's open it now and present the login UX to the user
                [self.appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                                 FBSessionState status,
                                                                 NSError *error) {
                }];
                // Set up amazon client access
                if ([AmazonClientManager FBLogin:self.appDelegate.session]) {
                    
                    if (!FBSession.activeSession.isOpen) {
                        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
                            // even though we had a cached token, we need to login to make the session usable
                            [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                                                 FBSessionState status,
                                                                                 NSError *error) {
                                if (error) {
                                    NSLog(@"Could not login to facebook because: %@", error);
                                } else {
                                    NSLog(@"Successfuly logged into facebook");
                                }
                            }];
                        }
                    }
                } else {
                    [FBSession.activeSession closeAndClearTokenInformation];
                    [self.appDelegate.session close];
                    return AuthenticationError;
                }
                
                return IsAuthorized;
            }
        } else {
            return IsNotAuthorized;
        }
    } else {
        return IsAuthorized;
    }
}

- (IBAction)facebookSignin:(id)sender {
    
    if (!FBSession.activeSession.isOpen) {
        [self.facebookButton setHidden:YES];
        [self.activityIndicator startAnimating];
        [NSTimer scheduledTimerWithTimeInterval:15.0
                                         target:self
                                       selector:@selector(stopActivityIndicator)
                                       userInfo:nil
                                        repeats:NO];
        [self.appDelegate openSessionWithAllowLoginUI:YES withCompletion:^(FBSession *session, NSError *error) {
            if (!error) {
                [self getUserInfo:session];
            } else {
                [self.facebookButton setHidden:NO];
                [self.activityIndicator stopAnimating];
                NSString *alertMessage = @"Awesome does not have access to your facebook.\nGo to Settings->Facebook and allow Awesome. to user your account.";
                [[[UIAlertView alloc] initWithTitle:@"Whoops!"
                                            message:alertMessage
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
        }];
    } else {
        [self getUserInfo:FBSession.activeSession];
    }
}

- (void)getUserInfo:(FBSession *)session {
    static FBSession *savedSession;
    
    if (session == nil) {
        session = savedSession;
    } else {
        savedSession = session;
    }
    // Get facebook user
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *fbUser, NSError *error) {
         if (!error) {
             NSLog(@"User is %@", fbUser);
             if ([AmazonClientManager FBLogin:session]) {
                 
                 // add facebook user to database
                 DataManager *dataManager = [DataManager sharedManager];
                 [dataManager addFacebookUser:fbUser];
                 [self performSegueWithIdentifier:@"feedSegue" sender:self];
                 [self.activityIndicator stopAnimating];
             } else {
                 [[[UIAlertView alloc] initWithTitle:@"Whoops!"
                                             message:@"Oops, we could not connect. Press ok to try again."
                                            delegate:self
                                   cancelButtonTitle:@"OK"
                                   otherButtonTitles:nil] show];
             }
             
         }
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self getUserInfo:nil];
}

#pragma mark - FBLoginViewDelegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
    NSLog(@"user logged in");
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    NSLog(@"User is %@", user);
    
    [AmazonClientManager FBLogin:self.appDelegate.session];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    NSLog(@"login in view");
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

- (void)stopActivityIndicator
{
    [self.facebookButton setHidden:NO];
    [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
