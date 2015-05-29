//
//  InstagramLoginManager.m
//  InsDemo
//
//  Created by Lv Junwei on 15/5/27.
//  Copyright (c) 2015年 Lv Junwei. All rights reserved.
//

#import "InstagramLoginManager.h"
#import <AFNetworking/AFNetworking.h>

NSString *const InstagramAuthTokenEndpoint = @"/oauth/access_token/";
NSString *const ClientIDKey = @"client_id";
NSString *const ClientSecretKey = @"client_secret";
NSString *const GrantTypeKey = @"grant_type";
NSString *const GrantTypeValue = @"authorization_code";
NSString *const RedirectURIKey = @"redirect_uri";
NSString *const CodeKey = @"code";

@interface InstagramLoginManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (copy, nonatomic, readwrite) NSString *clientID;
@property (copy, nonatomic, readwrite) NSString *clientSecret;
@property (strong, nonatomic, readwrite) NSURL *callbackURL;

@end

@implementation InstagramLoginManager

#pragma mark - Init Methods

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     callbackURL:(NSURL *)callbackURL
{
    self = [super init];
    if (self) {
        self.clientID = clientID;
        self.clientSecret = clientSecret;
        self.callbackURL = callbackURL;
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:InstagramAuthURL]];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Public Methods

- (void)authenticateWithAuthCode:(NSString *)authCode
                         success:(void (^)(InstagramLoginResponse *instagramLoginResponse))success
                         failure:(void (^)(NSError *error))failure
{
    [self.sessionManager POST:InstagramAuthTokenEndpoint
                   parameters:[self instagramTokenParams:authCode]
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          InstagramLoginResponse *loginResponse = [[InstagramLoginResponse alloc] initWithInstagramOAuthResponse:responseObject];
                          success(loginResponse);
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          failure(error);
                      }];
}

#pragma mark - Private Methods

- (NSDictionary *)instagramTokenParams:(NSString *)authCode
{
    return @{ ClientIDKey     : self.clientID,
              ClientSecretKey : self.clientSecret,
              GrantTypeKey    : GrantTypeValue,
              RedirectURIKey  : self.callbackURL.absoluteString,
              CodeKey         : authCode };
}

@end