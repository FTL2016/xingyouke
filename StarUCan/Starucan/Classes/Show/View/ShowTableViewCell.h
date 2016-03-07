//
//  ShowTableViewCell.h
//  Starucan
//
//  Created by vgool on 16/1/22.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowCommentModel.h"
#import "CommentLayFrame.h"
@interface ShowTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  性别
 */
@property (nonatomic, weak) UIImageView *sexImV;

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *introLabel;
//学校
@property(nonatomic,strong)UILabel *uniserLabel;//学校

@property (nonatomic, strong)CommentLayFrame *myLayoutFrame;


@end
