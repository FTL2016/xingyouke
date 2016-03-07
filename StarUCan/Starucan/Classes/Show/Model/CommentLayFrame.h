//
//  CommentLayFrame.h
//  Starucan
//
//  Created by vgool on 16/2/15.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowCommentModel.h"
@interface CommentLayFrame : NSObject
@property (nonatomic, strong)ShowCommentModel *showCommentModel;
/**
 *  头像的frame
 */
@property (nonatomic, assign) CGRect iconF;
/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect nameF;
/**
 *  性别的frame
 */
@property (nonatomic, assign) CGRect sex;
/**
 *  正文的frame
 */
@property (nonatomic, assign) CGRect introF;
//学校
@property (nonatomic, assign)CGRect uniserF;
@property (nonatomic, assign) CGFloat cellHeight;
@end
