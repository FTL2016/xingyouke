//
//  MyTopicLayoutFtame.h
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowCommentModel.h"

@interface MyTopicLayoutFtame : NSObject
@property (nonatomic, strong)ShowCommentModel *model;
/**
 *  标题的frame
 */
@property (nonatomic, assign) CGRect nameF;

/**
 *  正文的frame
 */
@property (nonatomic, assign) CGRect introF;

@property(nonatomic,assign)CGRect commentTimeF;//时间

@property(nonatomic,assign)CGRect imagV;
@property(nonatomic,assign)CGRect parCountF;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
