//
//  UIWindow+Extension.m
//  YTHDBL
//
//  Created by lgx on 15/4/25.
//  Copyright (c) 2015年 yingtehua. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "NewFeatureViewController.h"
#import "LoginViewController.h"
#import "WXNavigationController.h"
@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //判断版本号，如果两次一样说明不是第一次使用，直接进入主页面；如果不一样说明第一次登陆，进入引导页。
    if ([currentVersion isEqualToString:lastVersion]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        WXNavigationController *nav=[[WXNavigationController alloc]initWithRootViewController:loginVC];
        self.rootViewController = nav;
    
    } else {
        
        self.rootViewController = [[NewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
