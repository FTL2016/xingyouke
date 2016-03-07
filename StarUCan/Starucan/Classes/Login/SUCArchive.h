//
//  SUCArchive.h
//  Starucan
//
//  Created by vgool on 16/1/4.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUCArchive : NSObject
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *passWord;


@property (nonatomic,retain) NSMutableDictionary * userDic;
@property (nonatomic,copy) NSString *path;

+ (instancetype)shareArchiveManager;
- (void)synchronize;

- (BOOL)online;
@end
