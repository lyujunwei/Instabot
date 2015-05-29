//
//  LoginViewController.h
//  Instabot
//
//  Created by Junwei Lyu on 15/5/29.
//  Copyright (c) 2015年 Junwei Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramLoginResponse.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "InstagramLoginManager.h"
#import "InstagramLoginUtils.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *clientID;
@property (copy, nonatomic) NSString *clientSecret;
@property (strong, nonatomic) NSURL *callbackURL;
@property (copy, nonatomic) void (^completion)(InstagramLoginResponse *response, NSError *error);
@property (nonatomic) BOOL shouldShowErrorAlert;
@property (strong, nonatomic) NSArray *permissionScope;
@property (strong, nonatomic) InstagramLoginManager *loginManager;
@property (strong, nonatomic) InstagramLoginUtils *instagramLoginUtils;

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     callbackURL:(NSURL *)callbackURL
                      completion:(void (^)(InstagramLoginResponse *response, NSError *error))completion;

@end
