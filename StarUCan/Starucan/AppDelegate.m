//
//  AppDelegate.m
//  Starucan
//
//  Created by vgool on 15/12/31.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    NSLog(@"hello");
    
    self.uid = @"";
    self.nickname = @"";
    self.gender = @"";
    // self.credential = @"";
    self.weiPass = @"";
    self.icon = @"";
    self.regist_u_password = @"";
    self.regist_u_account = @"";
    self.regist_auto = @"";
    self.regist_accesstoken = @"";
    self.universityId = @"";
    self.university_name = @"";
    self.userInfo = [[NSMutableDictionary alloc] init];
    self.account = @"";
    self.accessToken = @"";
    self.passText = @"";
    self.name = @"";
    self.labelId = [[NSMutableArray alloc]init];
    self.labelIDict = [[NSMutableDictionary alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
        //self.window.rootViewController= [[MainViewController alloc]init];
    [self.window switchRootViewController];
    
    //设置手机状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //初始化shareSDK应用
    [ShareSDK registerApp:@"965ad3743f81" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
            default:
                break;
        }
        
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                          appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                      appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"100371282"
                                     appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
        
    }];
    
    
    //分享平台授权
//    [ShareSDK authorize:<#(SSDKPlatformType)#> settings:<#(NSDictionary *)#> onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        
//    }];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
