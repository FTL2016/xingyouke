//
//  MyShowLayoutFrame.h
//  Starucan
//
//  Created by vgool on 16/1/27.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowDetailModel.h"
@interface MyShowLayoutFrame : NSObject
@property (nonatomic, strong)ShowDetailModel *showModel;
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
/**
 *  配图的frame
 */
@property (nonatomic, assign) CGRect pictrueF;
//学校
@property (nonatomic, assign)CGRect uniserF;
//标签图片
@property (nonatomic, assign)CGRect labelF;
@property (nonatomic, assign)CGRect labelCommentF;
//线
@property (nonatomic, assign)CGRect lineF;


//评论
@property (nonatomic, assign)CGRect commentF;
@property (nonatomic, assign)CGRect commentImgF;
@property (nonatomic, assign)CGRect commentLabelF;
//线2
@property (nonatomic, assign)CGRect lineSecF;
//赞
@property (nonatomic, assign)CGRect praiseF;
@property (nonatomic, assign)CGRect praiseImgF;
@property (nonatomic, assign)CGRect praiseLabelF;
//线3
@property (nonatomic, assign)CGRect lineThriF;
@property (nonatomic, assign)CGRect shareF;
@property (nonatomic, assign)CGRect shareImgF;
@property (nonatomic, assign)CGRect shareLabelF;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;




@end
