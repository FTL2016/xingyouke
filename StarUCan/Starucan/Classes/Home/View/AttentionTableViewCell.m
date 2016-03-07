//
//  AttentionTableViewCell.m
//  Starucan
//
//  Created by vgool on 16/1/25.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation AttentionTableViewCell
#define GXNameFont [UIFont systemFontOfSize:14]
#define GXTextFont [UIFont systemFontOfSize:12]
- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    _kTitleArrays = [[NSMutableArray alloc]init];
    // 1.创建头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView.layer setMasksToBounds:YES];
    [iconView.layer setCornerRadius:24];
    iconView.layer.borderColor = [UIColor grayColor].CGColor;
    iconView.layer.borderWidth = 1;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    // 2.创建昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = GXNameFont;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.numberOfLines = 0;
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
    //uniserLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:uniserLabel];
    self.uniserLabel = uniserLabel;
    
    // 4.创建正文
    UILabel *introLabel = [[UILabel alloc] init];
    introLabel.numberOfLines = 0;
    introLabel.font = GXTextFont;
    [self.contentView addSubview:introLabel];
    self.introLabel = introLabel;
    
    // 5.创建配图
    UIImageView *pictureView = [[UIImageView alloc] init];
    [self.contentView addSubview:pictureView];
    self.pictureView = pictureView;
    
    
    
    //评论
    UIButton *commentButton = [[UIButton alloc]init];
    [self.contentView addSubview:commentButton];
    self.commentButton = commentButton;
    //
    UIImageView *commentImg = [[UIImageView alloc] init];
    [commentButton addSubview:commentImg];
    self.commentImg = commentImg;
    UILabel *commentLabel = [[UILabel alloc]init];
    [commentButton addSubview:commentLabel];
    commentLabel.textColor = YTHColor(197, 197, 197);
    commentLabel.font = [UIFont systemFontOfSize:12];
    self.commentLabel=commentLabel;
    
    
    //评论
    UIButton *praiseButton = [[UIButton alloc]init];
        [self.contentView addSubview:praiseButton];
    self.praiseButton = praiseButton;
    //
    UIImageView *praiseImg = [[UIImageView alloc] init];
    [praiseButton addSubview:praiseImg];
    self.praiseImg = praiseImg;
    UILabel *praiseLabel = [[UILabel alloc]init];
    [praiseButton addSubview:praiseLabel];
    praiseLabel.textColor = YTHColor(197, 197, 197);
    praiseLabel.font = [UIFont systemFontOfSize:12];
    self.praiseLabel=praiseLabel;
    
    
    
    //评论
    UIButton *shareButton = [[UIButton alloc]init];
    [self.contentView addSubview:shareButton];
    self.shareButton = shareButton;
    //
    UIImageView *shareImg = [[UIImageView alloc] init];
    [shareButton addSubview:shareImg];
    self.shareImg = shareImg;
    UILabel *shareLabel = [[UILabel alloc]init];
    [shareButton addSubview:shareLabel];
    shareLabel.textColor = YTHColor(197, 197, 197);
    shareLabel.font = [UIFont systemFontOfSize:12];
    self.shareLabel=shareLabel;

    //标签
    UIImageView *labelImg = [[UIImageView alloc] init];
        [self.contentView addSubview:labelImg];
    self.labelImg = labelImg;
//
    _kTitleView = [[UIScrollView alloc]init];
    [self.contentView addSubview:_kTitleView];
    //_kTitleView.backgroundColor = [UIColor yellowColor];
    
    
    
    //线
    UIView *lineView = [[UIView alloc]init];
    self.lineView = lineView;
    [self.contentView addSubview:lineView];
    
    //线
    UIView *lineViewSec = [[UIView alloc]init];
    self.lineViewSec = lineViewSec;
    [praiseButton addSubview:lineViewSec];
    
    //线
    UIView *lineViewThir = [[UIView alloc]init];
    self.lineViewThri = lineViewThir;
    [self.contentView addSubview:lineViewThir];
    
    
    
    
     return self;
}
-(void)setMyLayoutFrame:(MyShowLayoutFrame *)myLayoutFrame
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
    ShowDetailModel *model = self.myLayoutFrame.showModel;
        // 设置头像
    self.iconView.image = [UIImage imageNamed:model.avatar];
    
    //设置标题
    self.nameLabel.text = [model.user objectForKey:@"name"];
    // 设置内容
    self.introLabel.text = model.content;
    // 设置配图
    if (model.photoUrl) {
        //图片
        NSArray *photosUrlArr = [model.photoUrl componentsSeparatedByString:@","];
        self.photoNameList = [[NSMutableArray alloc]init];
        
        for (NSString *photoUrl in photosUrlArr) {
            [self.photoNameList addObject:photoUrl];
        }
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:[self.photoNameList objectAtIndex:0]]];
        
        self.pictureView.hidden = NO;
    } else {
        self.pictureView.hidden = YES;
    }
    
    
    
    
    //性别
    NSString *sexurl = [model.user objectForKey:@"sex"];
    if ([sexurl isEqualToString:@"1"]) {
        self.sexImV.image = [UIImage imageNamed:@"sex_male"];
    }else if ([sexurl isEqualToString:@"2"])
    {
          self.sexImV.image = [UIImage imageNamed:@"sex_female"];
    }
    
    
    
    //头像
    NSString *urlString = [model.user objectForKey:@"avatar"];
    
    
    if (!IsNilOrNull([model.user objectForKey:@"avatar"])&&!urlString.length==0) {
        //                    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.urlString]] placeholderImage:nil];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
    }else{
        if ([sexurl isEqualToString:@"2"]) {
            self.iconView.image =  [UIImage imageNamed:@"female"];
        }else if ([sexurl isEqualToString:@"1"]){
            self.iconView.image =  [UIImage imageNamed:@"male"];
        }
    }
    
    
    
    //学校
    self.uniserLabel.text = [model.user objectForKey:@"universityName"];
    
    
    
    //评论
    self.commentLabel.text =  [NSString stringWithFormat:@"%@",model.commitCount];
    
    //赞
    self.praiseLabel.text =  [NSString stringWithFormat:@"%@",model.praiseCount];
    
    
    
    //标签
    NSArray *labellid=model.labels;
    if (labellid.count!=0) {
        self.labelImg.image = [UIImage imageNamed:@"lable_blue"];
        
        for (NSDictionary *labelDict in labellid) {
            NSString *labelArry = [labelDict objectForKey:@"name"];
            [_kTitleArrays addObject:labelArry];
            _kMarkRect = CGRectMake(0, 0, 0, 0);
            [self.contentView addSubview:_kTitleView];
            for (NSString *title in _kTitleArrays) {
                [self _addTitleBtn:title andAdd:NO];
            }
        }
        
        
    }
    

    //线
    self.lineView.backgroundColor = YTHColor(197, 197, 197);
     self.lineViewSec.backgroundColor = YTHColor(197, 197, 197);
     self.lineViewThri.backgroundColor = YTHColor(197, 197, 197);
    //
    self.commentImg.image = [UIImage imageNamed:@"talk"];
    self.praiseImg.image = [UIImage imageNamed:@"s_praise"];
    self.shareImg.image = [UIImage imageNamed:@"s_share"];
    self.shareLabel.text = @"分享";
    
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
    self.pictureView.frame = self.myLayoutFrame.pictrueF;
    self.uniserLabel.frame = self.myLayoutFrame.uniserF;
    self.commentButton.frame = self.myLayoutFrame.commentF;
    self.praiseLabel.frame = self.myLayoutFrame.praiseF;
    self.labelImg.frame = self.myLayoutFrame.labelF;
    _kTitleView.frame = self.myLayoutFrame.labelCommentF;
    self.lineView.frame = self.myLayoutFrame.lineF;
    self.commentImg.frame = self.myLayoutFrame.commentImgF;
    self.commentLabel.frame = self.myLayoutFrame.commentLabelF;
    self.lineViewSec.frame = self.myLayoutFrame.lineSecF;
    self.praiseImg.frame = self.myLayoutFrame.praiseImgF;
    self.praiseButton.frame = self.myLayoutFrame.praiseF;
    self.praiseLabel.frame = self.myLayoutFrame.praiseLabelF;
    self.lineViewThri.frame = self.myLayoutFrame.lineThriF;
    
    
    self.shareImg.frame = self.myLayoutFrame.shareImgF;
    self.shareButton.frame = self.myLayoutFrame.shareF;
    self.shareLabel.frame = self.myLayoutFrame.shareLabelF;
    
}
-(void)_addTitleBtn:(NSString *)title andAdd:(BOOL)add{
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGFloat length = [title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    CGFloat xxxx = _kMarkRect.origin.x + _kMarkRect.size.width + length + 30;
    if (_kMarkRect.origin.y == 0) {
        _kMarkRect.origin.y = 10;
    }
    if (xxxx>_kTitleView.frame.size.width-10) {
        _kMarkRect.origin.y += 37;
        _kMarkRect.origin.x = 0;
        _kMarkRect.size.width = 0;
    }
    UIView *kMarkView = [[UIView alloc]initWithFrame:CGRectMake(_kMarkRect.origin.x + _kMarkRect.size.width + 10, _kMarkRect.origin.y, length+20, 16)];
    [_kTitleView addSubview:kMarkView];
    _kMarkRect = kMarkView.frame;
    UILabel *kTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, length+20, 16)];
    kTitleLabel.backgroundColor = YTHColor(169, 214, 255);
    kTitleLabel.layer.cornerRadius = 4;
    kTitleLabel.layer.masksToBounds = YES;
    kTitleLabel.textAlignment = NSTextAlignmentCenter;
    kTitleLabel.font = [UIFont systemFontOfSize:12];
    kTitleLabel.textColor = [UIColor whiteColor];
    kTitleLabel.text = title;
    [kMarkView addSubview:kTitleLabel];
    UIButton *kDeleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    kDeleteButton.frame = CGRectMake(CGRectGetMaxX(kMarkView.frame)-10, kMarkView.frame.origin.y-10, 20, 16);
 
    [_kTitleView addSubview:kDeleteButton];
    if (add) {
        [_kTitleArrays addObject:title];
    }
    kDeleteButton.tag = [_kTitleArrays indexOfObject:title] + 999;
    _kTitleView.contentSize = CGSizeMake(YTHScreenWidth, CGRectGetMaxY(kMarkView.frame)+10);
    // self.viewLabel.height =kMarkView.height;
    float h;
    NSLog(@"frame标签%f",kMarkView.frame.origin.y);
    
    
}

//-(void)setShowModel:(ShowDetailModel *)showModel
//{
//    if (_showModel!=showModel) {
//        _showModel=showModel;
//        [self setNeedsLayout];
//    }
//}
//-(void)layoutSubviews{
//     [super layoutSubviews];
//    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[self.showModel.user objectForKey:@"avatar"]]];
//    
//    
//    //性别
//    NSString *sexurl = [self.showModel.user objectForKey:@"sex"];
//    if ([sexurl isEqualToString:@"0"]) {
//        self.sexImV.image = [UIImage imageNamed:@"sex_male"];
//    }else if ([sexurl isEqualToString:@"1"])
//    {
//          self.sexImV.image = [UIImage imageNamed:@"sex_female"];
//    }
//    
//    
//    //头像
//  NSString *urlString = [self.showModel.user objectForKey:@"avatar"];
//  
//    
//    if (!IsNilOrNull([self.showModel.user objectForKey:@"avatar"])&&!urlString.length==0) {
//        //                    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.urlString]] placeholderImage:nil];
//        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:urlString]];
//        
//    }else{
//        if ([sexurl isEqualToString:@"0"]) {
//            self.headImgV.image =  [UIImage imageNamed:@"female"];
//        }else if ([sexurl isEqualToString:@"1"]){
//            self.headImgV.image =  [UIImage imageNamed:@"male"];
//        }
//    }
//
//    
//    
//    
//    
//    self.nameLabel.text = [self.showModel.user objectForKey:@"name"];
//    self.uniserLabel.text = [self.showModel.user objectForKey:@"universityName"];
//    //图片
//    NSArray *photosUrlArr = [self.showModel.photoUrl componentsSeparatedByString:@","];
//    self.photoNameList = [[NSMutableArray alloc]init];
//    
//    for (NSString *photoUrl in photosUrlArr) {
//        [self.photoNameList addObject:photoUrl];
//    }
//    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:[self.photoNameList objectAtIndex:0]]];
//   
////内容
//    self.labelDesc.text = self.showModel.content;
//    [_kTitleArrays removeAllObjects];
//    //标签
//    NSArray *labellid=self.showModel.labels;
//    for (NSDictionary *labelDict in labellid) {
//        NSString *labelArry = [labelDict objectForKey:@"name"];
//        [_kTitleArrays addObject:labelArry];
//    }
//    [self _initLabel];
//    
//    self.praiseLabel.text = [NSString stringWithFormat:@"赞%@",self.showModel.praiseCount];
//    self.commentLabel.text = [NSString stringWithFormat:@"评论%@",self.showModel.commitCount];
//    
//    
//}
//-(void)_initLabel
//{
//    _kTitleView = [[UIScrollView alloc]init];
//    
//    _kTitleView.frame =CGRectMake(10, CGRectGetMaxY(self.bigImage.frame)+40, YTHScreenWidth-20, 44);
//    
//    
//    //_kTitleView.backgroundColor = [UIColor redColor];
//    //_kTitleView.backgroundColor = [UIColor yellowColor];
//    _kMarkRect = CGRectMake(0, 0, 0, 0);
//    [self.contentView addSubview:_kTitleView];
//    for (NSString *title in _kTitleArrays) {
//        [self _addTitleBtn:title andAdd:NO];
//    }
//    
//
//}
//-(void)_addTitleBtn:(NSString *)title andAdd:(BOOL)add{
//    if (!_kTitleView) {
//        _kTitleView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 0, YTHScreenWidth-54, 44)];
//        _kTitleView.backgroundColor = [UIColor yellowColor];
//        //_kTitleView.backgroundColor = YTHBaseVCBackgroudColor;
//        [self.contentView addSubview:_kTitleView];
//    }
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
//    CGFloat length = [title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
//    CGFloat xxxx = _kMarkRect.origin.x + _kMarkRect.size.width + length + 30;
//    if (_kMarkRect.origin.y == 0) {
//        _kMarkRect.origin.y = 10;
//    }
//    if (xxxx>_kTitleView.frame.size.width-10) {
//        _kMarkRect.origin.y += 37;
//        _kMarkRect.origin.x = 0;
//        _kMarkRect.size.width = 0;
//    }
//    UIView *kMarkView = [[UIView alloc]initWithFrame:CGRectMake(_kMarkRect.origin.x + _kMarkRect.size.width + 10, _kMarkRect.origin.y, length+20, 27)];
//    [_kTitleView addSubview:kMarkView];
//    _kMarkRect = kMarkView.frame;
//    UILabel *kTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, length+20, 27)];
//    kTitleLabel.backgroundColor = YTHColor(169, 214, 255);
//    kTitleLabel.layer.cornerRadius = 4;
//    kTitleLabel.layer.masksToBounds = YES;
//    kTitleLabel.textAlignment = NSTextAlignmentCenter;
//    kTitleLabel.font = [UIFont systemFontOfSize:12];
//    kTitleLabel.textColor = [UIColor whiteColor];
//    kTitleLabel.text = title;
//    [kMarkView addSubview:kTitleLabel];
//    UIButton *kDeleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    kDeleteButton.frame = CGRectMake(CGRectGetMaxX(kMarkView.frame)-10, kMarkView.frame.origin.y-10, 20, 20);
//    //    [kDeleteButton setTitle:@"X" forState:UIControlStateNormal];
//    [kDeleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//    //    [kDeleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //    [kDeleteButton addTarget:self action:@selector(btnDeleteClick:)];
//    [kDeleteButton addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_kTitleView addSubview:kDeleteButton];
//    if (add) {
//        [_kTitleArrays addObject:title];
//    }
//    kDeleteButton.tag = [_kTitleArrays indexOfObject:title] + 999;
//    _kTitleView.contentSize = CGSizeMake(YTHScreenWidth, CGRectGetMaxY(kMarkView.frame)+10);
//    // self.viewLabel.height =kMarkView.height;
//    float h;
//    NSLog(@"frame标签%f",kMarkView.frame.origin.y);
//
//    
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
