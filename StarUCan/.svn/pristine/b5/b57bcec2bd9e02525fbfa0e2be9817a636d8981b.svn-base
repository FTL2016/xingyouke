//
//  CommentLayFrame.m
//  Starucan
//
//  Created by vgool on 16/2/15.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "CommentLayFrame.h"

@implementation CommentLayFrame
-(void)setShowCommentModel:(ShowCommentModel *)showCommentModel
{
    if (_showCommentModel!=showCommentModel) {
        
        _showCommentModel = showCommentModel;
        [self layoutFrame];

    }
    
}
#define GXNameFont [UIFont systemFontOfSize:12]
#define GXTextFont [UIFont systemFontOfSize:14]
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
    CGSize nameSize  = [self user_getSize:GXTextFont With:(YTHScreenWidth-60) Hight:1000 String:[self.showCommentModel.createUser objectForKey:@"name"]];
    CGFloat nameLabelW = nameSize.width;
    CGFloat nameLabelH = nameSize.height;
    CGFloat nameLabelY = iconViewY + (CGRectGetMaxY(self.iconF) - iconViewH) * 0.5;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    // 设置性别的frame
    CGFloat vipViewX = CGRectGetMaxX(self.nameF) + 5;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = 14;
    CGFloat vipViewH = 14;
    self.sex= CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    //学校
    
    CGSize uniserSize;
    NSDictionary *dicrary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
    if (!IsNilOrNull([self.showCommentModel.createUser objectForKey:@"universityName"])) {
        uniserSize =  [[self.showCommentModel.createUser objectForKey:@"universityName"] boundingRectWithSize:CGSizeMake(YTHScreenWidth-10, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dicrary context:nil].size;
        CGFloat uniserSizeW = uniserSize.width;
        CGFloat uniserSizeH = uniserSize.height;
        CGFloat uniserSizeY = CGRectGetMaxY(self.nameF) + padding;
        self.uniserF = CGRectMake(nameLabelX, uniserSizeY, uniserSizeW, uniserSizeH);
        
        // 设置正文的frame
        CGSize introSize = [self sizeWithString:self.showCommentModel.content font:GXTextFont maxSize:CGSizeMake(YTHScreenWidth-nameLabelX-10, MAXFLOAT)];
        CGFloat introLabelW = introSize.width;
        CGFloat introLabelH = introSize.height;
        CGFloat introLabelX = CGRectGetMaxX(self.iconF) + padding;
        CGFloat introLabelY = CGRectGetMaxY(self.uniserF) + padding;
        self.introF = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
        
        // 计算行高
        self.cellHeight = CGRectGetMaxY(self.introF) + padding;
    }else{
        
        // 设置正文的frame
        CGSize introSize = [self sizeWithString:self.showCommentModel.content font:GXTextFont maxSize:CGSizeMake(YTHScreenWidth-nameLabelX-10, MAXFLOAT)];
        CGFloat introLabelW = introSize.width;
        CGFloat introLabelH = introSize.height;
        CGFloat introLabelX = CGRectGetMaxX(self.iconF) + padding;
        CGFloat introLabelY = CGRectGetMaxY(self.nameF) + padding;
        self.introF = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
        
        
        
         self.cellHeight = CGRectGetMaxY(self.introF) + padding;
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
