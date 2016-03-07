//
//  SUCUser.h
//  Starucan
//
//  Created by vgool on 16/1/4.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUCUser : NSObject


/**
 * 昵称
 */

//账号
@property (nonatomic, copy) NSString *account;
//头像
@property (nonatomic, copy) NSString *avatar;
//是否绑定微信
@property (nonatomic, copy) NSString *bindWeixin;
//手机
@property (nonatomic, copy) NSString *mobile;
//名字
@property (nonatomic, copy) NSString *name;
//
@property (nonatomic, copy) NSString *token;
//
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *appIdToken;
@property (nonatomic, copy) NSString *universityId;

@property (nonatomic) bool isLogout;//是否

@property (nonatomic, retain) NSString *regist_u_account;//
@property (nonatomic, retain) NSString *regist_u_password;
@property (nonatomic, assign)BOOL loginStatus;
+ (instancetype)shareUser;

/**
 * 直接获得登录后用户的基本信息模型
 **/
+ (instancetype)initWithUserInfo;

@end
