//
//  MyShowLayoutFrame.m
//  Starucan
//
//  Created by vgool on 16/1/27.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MyShowLayoutFrame.h"

@implementation MyShowLayoutFrame
-(void)setShowModel:(ShowDetailModel *)showModel
{
    if (_showModel!=showModel) {
        _showModel = showModel;
        [self layoutFrame];
    }
}
#define GXNameFont [UIFont systemFontOfSize:14]
#define GXTextFont [UIFont systemFontOfSize:16]

- (void)layoutFrame
{
    
    // 间隙
    CGFloat padding = 10;
    // 设置头像的Frame
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewW = 48;
    CGFloat iconViewH = 48;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    
    
    // 设置昵称的Frame
    CGFloat nameLabelX = CGRectGetMaxX(self.iconF) + padding;
    // 计算文字的宽高
    CGSize nameSize = [self sizeWithString:[self.showModel.user objectForKey:@"name"] font:GXNameFont maxSize:CGSizeMake(YTHScreenWidth, MAXFLOAT)];
    
//    CGRect nameSizeW = [self user_getSize:[UIFont systemFontOfSize:14] With:<#(CGFloat)#> Hight:<#(CGFloat)#> String:<#(NSString *)#>];
    CGFloat nameLabelW = nameSize.width;
    CGFloat nameLabelH = nameSize.height;
    CGFloat nameLabelY = iconViewY + (CGRectGetMaxY(self.iconF) - iconViewH) * 0.5;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    // 设置性别的frame
    CGFloat vipViewX = CGRectGetMaxX(self.nameF) + padding;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = 14;
    CGFloat vipViewH = 14;
    self.sex= CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
      //学校
    
    CGSize uniserSize;
    NSDictionary *dicrary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
    uniserSize =  [[self.showModel.user objectForKey:@"universityName"] boundingRectWithSize:CGSizeMake(YTHScreenWidth-10, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dicrary context:nil].size;
    float f;
   
    
    CGFloat uniserSizeW = uniserSize.width;
    CGFloat uniserSizeH = uniserSize.height;
    CGFloat uniserSizeY = CGRectGetMaxY(self.nameF) + padding;
    self.uniserF = CGRectMake(nameLabelX, uniserSizeY, uniserSizeW, uniserSizeH);
    CGFloat pictureViewX = iconViewX;
    CGFloat pictureVIewY = CGRectGetMaxY(self.uniserF) + padding;
    CGFloat pictureViewW = YTHScreenWidth-20;
    CGFloat pictureViewH = 170;
    self.pictrueF = CGRectMake(pictureViewX, pictureVIewY, pictureViewW, pictureViewH);
    
    // 设置配图的frame
    if (self.showModel.content) {
       
        // 设置正文的frame
        CGSize introSize = [self sizeWithString:self.showModel.content font:GXTextFont maxSize:CGSizeMake(YTHScreenWidth-20, MAXFLOAT)];
        CGFloat introLabelW = introSize.width;
        CGFloat introLabelH = introSize.height;
        CGFloat introLabelX = iconViewX;
        CGFloat introLabelY = CGRectGetMaxY(self.pictrueF) + padding;
        self.introF = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
       //标签
            self.labelF = CGRectMake(introLabelX, CGRectGetMaxY(self.introF)+15, 16, 16);
        //标签内容
        self.labelCommentF =CGRectMake(CGRectGetMaxX(self.labelF)+10, CGRectGetMaxY(self.introF), YTHScreenWidth-64, 40);
    
        //线
        self.lineF =CGRectMake(0, CGRectGetMaxY(self.labelCommentF), YTHScreenWidth, 0.5);
        //评论
        self.commentF = CGRectMake(0,CGRectGetMaxY(self.lineF)+1, YTHScreenWidth/3, 40);
        self.commentImgF = CGRectMake(YTHScreenWidth/3/2-16, 15, 20, 10);
        self.commentLabelF = CGRectMake(CGRectGetMaxX(self.commentImgF), 15, 20, 10);
        
        //线2
        self.lineSecF  =CGRectMake(CGRectGetMaxX(self.commentF), 5, 1, 30);
        self.praiseF = CGRectMake(CGRectGetMaxX(self.commentF)+1, CGRectGetMaxY(self.lineF)+1, YTHScreenWidth/3, 40);
         self.praiseImgF = CGRectMake(YTHScreenWidth/3/2-16, 15, 18, 10);
        self.praiseLabelF = CGRectMake(CGRectGetMaxX(self.praiseImgF), 15, 20, 10);
        
        //线3
         self.lineSecF  =CGRectMake(CGRectGetMaxX(self.praiseF), 5, 1, 30);
        //分享
        self.shareF = CGRectMake(CGRectGetMaxX(self.praiseF)+1, CGRectGetMaxY(self.lineF)+1, YTHScreenWidth/3, 40);
        self.shareImgF = CGRectMake(YTHScreenWidth/3/2-16, 15, 17, 10);
        self.shareLabelF = CGRectMake(CGRectGetMaxX(self.praiseImgF), 15, 25, 10);
        
       
        // 计算行高
        self.cellHeight = CGRectGetMaxY(self.commentF);
    }else
    {
         self.labelF = CGRectMake(10,  CGRectGetMaxY(self.pictrueF) + padding, 16, 16);
         self.labelCommentF =CGRectMake(CGRectGetMaxX(self.labelF)+10, CGRectGetMaxY(self.pictrueF), YTHScreenWidth-64, 40);
        // 没有文字的行高
        self.cellHeight = CGRectGetMaxY(self.pictrueF) + padding;
    }
    
    
    
    
    
    
    
    
    
}
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    // 文本用什么字体字号计算
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字范围超出了指定范围，返回的就是指定范围
    // 如果将来计算的文字的范围小于指定的范围，返回的就是真实的范围
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

-(CGSize)user_getSize:(UIFont *)font With:(CGFloat)with Hight:(CGFloat)hight String:(NSString *)str{
    CGSize size;
    //iOS7之后有新的计算方法
    //拿到操作系统版本号
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version floatValue]>=7.0) {
        //7以后
        //带有字体属性的字典
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        size =  [str boundingRectWithSize:CGSizeMake(with, hight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //7以前
        //字符串根据条件计算自身size的方法: font 字体和字号;lineBreakMode 换行方式;constrainedToSize: 规定计算范围(横向和纵向计算的最大值)
        size = [str sizeWithFont:font constrainedToSize:CGSizeMake(with,hight) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}
@end
