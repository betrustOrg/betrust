//
//  AppDelegate.h
//  betrust
//
//  Created by BigFansLJ on 2018/6/13.
//  Copyright © 2018年 XueFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const APP_ID = @"1254765384";//你申请的 APP_ID
static NSString * const SECRET_ID = @"AKIDfBUaT9vsvlOo0zPJdjdJm24tVu64GRpz";//你申请的 SECRET_ID
static NSString * const SECRET_KEY = @"4vZ0DCzYu3yf8NTLzPbgmrqdDahY9UZP";//你申请的 SECRET_KEY

@interface UserService : NSObject

@property (nonatomic, assign) NSInteger *userId; // 登录用户ID
@property (nonatomic, assign) NSInteger *userIdentity; // 用户是否认证 1:已认证 0:没认证
@property (nonatomic, strong) NSString *userCountry;  // 用户所在地区
@property (nonatomic, strong) NSString *authorizion;  // 用户登录token



-(void) setUserId:(NSInteger *)userId; // 设置用户ID

-(void) setUserCountry:(NSString *)userCountry;  // 设置用户地区

-(void) setAuthorizion:(NSString *)authorizion; // 设置用户登录token

-(BOOL) checkUserLogin;

-(BOOL) checkUserIdentity;

@end
