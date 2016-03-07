//
//  YHTHomeImageModel.h
//  Starucan
//
//  Created by Lonely丶晏袁杰 on 16/1/7.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface YHTHomeImageModel : BaseModel
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, copy)NSString *uuid;
@end
