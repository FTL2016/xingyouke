//
//  ShowCommentModel.h
//  Starucan/
//
//  Created by vgool on 16/1/22.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "BaseModel.h"

@interface ShowCommentModel : BaseModel
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *userUuid;
@property(nonatomic,copy)NSString *authorUuid;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSDictionary *createUser;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *participatCount;
@end
