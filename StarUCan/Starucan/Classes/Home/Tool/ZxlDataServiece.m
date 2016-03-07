//
//  ZxlDataServiece.m
//  O2O
//
//  Created by yingtehua on 14-12-28.
//  Copyright (c) 2014年 yingtehua. All rights reserved.
//

#import "ZxlDataServiece.h"

@implementation ZxlDataServiece
+ (id)requestData:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    
    //通过系统自带的json解析方法解析json数据（5.0之后）
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (json == nil)
    {
        return nil;
    }
    
    return json;
}

@end
