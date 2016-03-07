//
//  SUCUser.m
//  Starucan
//
//  Created by vgool on 16/1/4.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "SUCUser.h"
#import "SUCArchive.h"
#import "NSObject+MJKeyValue.h"
@implementation SUCUser
static SUCUser *user;
+ (instancetype)shareUser{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[SUCUser alloc] init];
    });
    
    return user;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [super allocWithZone:zone];
    });
    
    return user;
}
+ (instancetype)initWithUserInfo{
    // 根据 MJExtension 动态从 dic 传值到模型
    return [self objectWithKeyValues:[SUCArchive shareArchiveManager].userDic];
}
@end
