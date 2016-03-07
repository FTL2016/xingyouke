//
//  MyFanTableViewCell.h
//  Starucan
//
//  Created by vgool on 16/1/26.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDetailModel.h"
@interface MyFanTableViewCell : UITableViewCell
{
    NSArray *photosUrlArr;
}
@property(nonatomic,strong)UIImageView *headImgV;//头像
@property(nonatomic,strong)UILabel *nameLabel;//姓名
@property(nonatomic,strong)UIImageView *sexImV;//性别
@property(nonatomic,strong)UILabel *uniserLabel;//学校
@property (nonatomic, strong)ShowDetailModel *showModel;
@property (nonatomic, strong)UIButton *addAttionBtn;
@property (nonatomic, strong)UIImageView *imgView;//
@property (nonatomic, assign) BOOL flag;
@end
