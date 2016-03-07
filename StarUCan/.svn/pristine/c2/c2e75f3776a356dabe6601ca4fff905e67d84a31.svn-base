//
//  MyTopTableViewCell.m
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MyTopTableViewCell.h"

@implementation MyTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.创建标题
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.numberOfLines = 0;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        // 4.创建正文
        UILabel *introLabel = [[UILabel alloc] init];
        introLabel.numberOfLines = 0;
        introLabel.font = [UIFont systemFontOfSize:12];
        introLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:introLabel];
        self.introLabel = introLabel;
        //时间
        UILabel *commentTime = [[UILabel alloc]init];
        commentTime.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:commentTime];
        self.commentTimeLab  = commentTime;
        //图
        UIImageView *imagV = [[UIImageView alloc]init];
        [self.contentView addSubview:imagV];
        self.imaV = imagV;
        //
        UILabel *parCountLabel = [[UILabel alloc]init];
        parCountLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:parCountLabel];
        self.parCountLabel = parCountLabel;
        
        
    }
    return self;
}
-(void)setMyLayoutFrame:(MyTopicLayoutFtame *)myLayoutFrame
{
    _myLayoutFrame = myLayoutFrame;
    // 设置数据
    [self settingData];
    [self settingFrame];
}
- (void)settingData
{
     ShowCommentModel *model = self.myLayoutFrame.model;
    self.nameLabel.text = model.name;
    self.introLabel.text = model.content;
    self.commentTimeLab.text = model.createTime;
    self.imaV.image = [UIImage imageNamed:@"s_talk"];
    self.parCountLabel.text = [NSString stringWithFormat:@"%@",model.participatCount];
    

}
-(void)settingFrame
{
    self.introLabel.frame = self.myLayoutFrame.introF;
    self.nameLabel.frame = self.myLayoutFrame.nameF;
    self.commentTimeLab.frame = self.myLayoutFrame.commentTimeF;
    self.imaV.frame = self.myLayoutFrame.imagV;
    self.parCountLabel.frame = self.myLayoutFrame.parCountF;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
