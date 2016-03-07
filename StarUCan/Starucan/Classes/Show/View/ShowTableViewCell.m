//
//  ShowTableViewCell.m
//  Starucan
//
//  Created by vgool on 16/1/22.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "ShowTableViewCell.h"
#import "ShowDetailModel.h"
#import "UIImageView+WebCache.h"
@implementation ShowTableViewCell
#define GXNameFont [UIFont systemFontOfSize:14]
#define GXTextFont [UIFont systemFontOfSize:12]
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    // 1.创建头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView.layer setMasksToBounds:YES];
    [iconView.layer setCornerRadius:24];
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    iconView.layer.borderWidth = 1;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    // 2.创建昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = GXNameFont;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.numberOfLines = 0;
   // nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    // 3.创建vip
    UIImageView *sexImV = [[UIImageView alloc] init];
    [self.contentView addSubview:sexImV];
    self.sexImV = sexImV;
    //学校
    UILabel *uniserLabel = [[UILabel alloc]init];
     uniserLabel.font = GXNameFont;
      uniserLabel.textColor = YTHColor(197, 197, 197);
    uniserLabel.numberOfLines = 0;
    [uniserLabel sizeToFit];
   
    [self.contentView addSubview:uniserLabel];
    self.uniserLabel = uniserLabel;
    
    // 4.创建正文
    UILabel *introLabel = [[UILabel alloc] init];
    introLabel.numberOfLines = 0;
    introLabel.font = GXTextFont;
    [self.contentView addSubview:introLabel];
    self.introLabel = introLabel;
    
    
    return self;

}
-(void)setMyLayoutFrame:(CommentLayFrame *)myLayoutFrame
{
    _myLayoutFrame = myLayoutFrame;
    // 设置数据
    [self settingData];
    [self settingFrame];
}
/**
 *  设置子控件的数据
 */
- (void)settingData
{
    ShowCommentModel *model = self.myLayoutFrame.showCommentModel;
    // 设置头像
        NSString *uslString = [model.createUser objectForKey:@"avatar"];
     [self.iconView sd_setImageWithURL:[NSURL URLWithString:uslString] placeholderImage:nil];
    // 设置内容
     _nameLabel.text = [model.createUser objectForKey:@"name"];
    //性别
    NSString *sexurl = [model.createUser objectForKey:@"sex"];
    if ([sexurl isEqualToString:@"1"]) {
        self.sexImV.image = [UIImage imageNamed:@"sex_male"];
    }else if ([sexurl isEqualToString:@"2"])
    {
          self.sexImV.image = [UIImage imageNamed:@"sex_female"];
    }
    
    
    
    //头像
    NSString *urlString = [model.createUser objectForKey:@"avatar"];
    
    
    if (!IsNilOrNull([model.createUser objectForKey:@"avatar"])&&!urlString.length==0) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
    }else{
        if ([sexurl isEqualToString:@"2"]) {
            self.iconView.image =  [UIImage imageNamed:@"female"];
        }else if ([sexurl isEqualToString:@"1"]){
            self.iconView.image =  [UIImage imageNamed:@"male"];
        }
    }
    //学校
    if (!IsNilOrNull([model.createUser objectForKey:@"universityName"])) {
         self.uniserLabel.text = [model.createUser objectForKey:@"universityName"];
    }
   
    
 self.introLabel.text = model.content;
    
}
/**
 *  设置子控件的Frame
 */
- (void)settingFrame
{
    self.iconView.frame = self.myLayoutFrame.iconF;
    self.nameLabel.frame = self.myLayoutFrame.nameF;
    self.introLabel.frame = self.myLayoutFrame.introF;
    self.sexImV.frame = self.myLayoutFrame.sex;
  
    self.uniserLabel.frame = self.myLayoutFrame.uniserF;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setShowDetailModel:(ShowDetailModel *)showDetailModel
//{
//    if (_showDetailModel!=showDetailModel) {
//        _showDetailModel=showDetailModel;
//        [self setNeedsLayout];
//    }
//    
//}
//-(void)setShowCommentModel:(ShowCommentModel *)showCommentModel
//{
//    if (_showCommentModel!=showCommentModel) {
//        _showCommentModel=showCommentModel;
//        [self setNeedsLayout];
//    }
//}
//-(void)layoutSubviews{
//    
//     [super layoutSubviews];
//    
//   NSString *uslString = [self.showCommentModel.createUser objectForKey:@"avatar"];
//    [_faceImg sd_setImageWithURL:[NSURL URLWithString:uslString] placeholderImage:nil];
//    _nickNameLab.text = [self.showCommentModel.createUser objectForKey:@"name"];
//    NSString *sex = [self.showCommentModel.createUser objectForKey:@"sex"];
//    if ([sex isEqualToString:@"0"]) {
//        self.sexImg.image = [UIImage imageNamed:@"sex_male"];
//    }else if ([sex isEqualToString:@"1"])
//    {
//         self.sexImg.image = [UIImage imageNamed:@"sex_female"];
//    }
//    if (!IsNilOrNull([self.showCommentModel.createUser objectForKey:@"avatar"])&&!uslString.length==0) {
//         [_faceImg sd_setImageWithURL:[NSURL URLWithString:uslString] placeholderImage:nil];
//        
//    }else{
//        if ([sex isEqualToString:@"0"]) {
//            _faceImg.image =  [UIImage imageNamed:@"female"];
//        }else if ([sex isEqualToString:@"1"]){
//           _faceImg.image =  [UIImage imageNamed:@"male"];
//        }
//    }
//
//    _univerLabel.text = [self.showCommentModel.createUser objectForKey:@"universityName"];
//    _commentContentLab.text = self.showCommentModel.content;
//    
//    _commentTimeLab.text = self.showCommentModel.createTime;
//}
@end