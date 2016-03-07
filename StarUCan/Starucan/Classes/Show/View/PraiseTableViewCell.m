//
//  PraiseTableViewCell.m
//  Starucan
//
//  Created by vgool on 16/2/22.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "PraiseTableViewCell.h"

@implementation PraiseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *buttoncomment = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
        UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        
        
//        commentLabel.text = [NSString stringWithFormat:@"评论%@", [self.showdic objectForKey:@"commitCount"]];
         commentLabel.text = @"评论";
        commentLabel.font = [UIFont systemFontOfSize:14];
        commentLabel.textAlignment = NSTextAlignmentCenter;
        commentLabel.textColor = [UIColor grayColor];
        [buttoncomment addSubview:commentLabel];
//        [buttoncomment addTarget:self action:@selector(buttonComment:) forControlEvents:UIControlEventTouchUpInside];
        self.commentLabel = commentLabel;
        self.buttoncomment = buttoncomment;
        [self.contentView addSubview:buttoncomment];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(110, 0, 100, 44)];
        
        UILabel *praiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        praiseLabel.text = @"赞";
//        praiseLabel.text =[NSString stringWithFormat:@"赞%@",[self.showdic objectForKey:@"praiseCount"]];
        praiseLabel.font = [UIFont systemFontOfSize:14];
        praiseLabel.textColor = [UIColor grayColor];
        [button addSubview:praiseLabel];
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.praiseLabel = praiseLabel;
        self.button = button;
        //self.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:button];
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 100, 2)];
        _arrowImg.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_arrowImg];

        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
