//
//  MyTopicLayoutFtame.m
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MyTopicLayoutFtame.h"

@implementation MyTopicLayoutFtame
-(void)setModel:(ShowCommentModel *)model
{
    _model = model;
    
    
    [self layoutFrame];
    
}
#define GXNameFont [UIFont systemFontOfSize:14]
#define GXTextFont [UIFont systemFontOfSize:16]

- (void)layoutFrame
{
    // 设置昵称的Frame
    CGFloat nameLabelX = 10;
    // 计算文字的宽高
    CGSize nameSize = [self sizeWithString:self.model.name font:GXNameFont maxSize:CGSizeMake(YTHScreenWidth, MAXFLOAT)];
    
    
    CGFloat nameLabelW = nameSize.width;
    CGFloat nameLabelH = nameSize.height;
    CGFloat nameLabelY = 20;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    // 设置正文的frame
    CGSize introSize = [self sizeWithString:self.model.content font:GXTextFont maxSize:CGSizeMake(YTHScreenWidth-20, MAXFLOAT)];
    CGFloat introLabelW = introSize.width;
    CGFloat introLabelH = introSize.height;
    CGFloat introLabelX =10;
    CGFloat introLabelY = CGRectGetMaxY(self.nameF) + 5;
    self.introF = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
    
    
    self.imagV = CGRectMake(YTHScreenWidth-100, CGRectGetMaxY(self.introF)+15, 20, 10);
    self.parCountF = CGRectMake((CGRectGetMaxX(self.imagV)+5), CGRectGetMaxY(self.introF)+10, 30, 20);
    

    
    
    
    
    //时间
    self.commentTimeF = CGRectMake(10,CGRectGetMaxY(self.introF)+10 , 100, 30);
    // 计算行高
    self.cellHeight = CGRectGetMaxY(self.commentTimeF) + 10;

    

    
    
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



@end
