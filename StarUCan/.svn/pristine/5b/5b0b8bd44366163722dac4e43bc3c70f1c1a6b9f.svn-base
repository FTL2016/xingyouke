//
//  SUCArchive.m
//  Starucan
//
//  Created by vgool on 16/1/4.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "SUCArchive.h"

@implementation SUCArchive
static SUCArchive *archiveManager;
+ (instancetype)shareArchiveManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        archiveManager = [[SUCArchive alloc] init];
    });
    
    return archiveManager;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        archiveManager = [super allocWithZone:zone];
    });
    
    return archiveManager;
}

#pragma mark - 初始化沙盒中的 loacalArchive.plist 文件
- (id)init{
    if (self=[super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //            self.path = [NSString stringWithFormat:@"%@/Documents/userStatus.plist",NSHomeDirectory()];
            
            // 拼接沙盒中 Document 下 userStatus.plist 路径
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            self.path = [docPath stringByAppendingPathComponent:@"userInfo.plist"];
            
            // 从 userInfo.plist 中取出字典
            // 每次初始化都会将 dic 变为 userInfo.plist 的内容, 所以 dic 变量本身存不了东西
            // 因此, 每次 dic 里更新后需 synchronize 方法来同步
            self.userDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.path];
            if (self.userDic==nil ) {
                self.userDic = [NSMutableDictionary dictionaryWithCapacity:0];
            }
        });
    }
    return self;
}

- (void)synchronize{
    [self.userDic writeToFile:self.path atomically:YES];
}

- (BOOL)online{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user boolForKey:LoginStatus];
}


@end
