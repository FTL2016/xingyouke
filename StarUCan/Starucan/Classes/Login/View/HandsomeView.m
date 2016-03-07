//
//  HandsomeView.m
//  Starucan
//
//  Created by vgool on 16/1/12.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "HandsomeView.h"

@implementation HandsomeView
{
    NSArray *dataArray;
    NSMutableArray *btnArray;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivedUibutton:) name:@"UibuttonEnable" object:nil];
    return self;
}
-(id)initWithFrame:(CGRect)frame andData:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        btnArray = [[NSMutableArray alloc]init];
        dataArray = array;
        [self initBtn];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(frame.size.width -YTHAdaptation(110), frame.size.height-YTHAdaptation(30), YTHAdaptation(100), YTHAdaptation(30));
        [button setTitle:@"换一换" forState: UIControlStateNormal];
        [button addTarget:self action:@selector(HYH) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:YTHColor(119, 190, 255) forState:UIControlStateNormal];
        [self addSubview:button];
    }
    return self;
}

-(void)initBtn{
    //    self.backgroundColor = [UIColor blackColor];
    NSInteger h = 0;
    NSInteger g = 0;
    CGFloat xx = 0.0;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    for (int i = 0; i<dataArray.count; i++) {
        //根据计算文字的大小
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [dataArray[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        CGFloat x;
        if (g == 0) {
            x = arc4random() % 50 + 10;
            if (xx>0) {
                while ((xx-x>0?xx-x:-(xx-x))<20) {
                    x = arc4random() % 50 + 10;
                }
            }
            xx = x;
        }else{
            x = arc4random() % 11 + 5 + rect.size.width;
        }
        if (x+rect.origin.x+length+40>self.frame.size.width-10) {
            h++;
            g=0;
            if (g == 0) {
                x = arc4random() % 50 + 10;
                if (xx>0) {
                    while ((xx-x>0?xx-x:-(xx-x))<20) {
                        x = arc4random() % 50 + 10;
                    }
                }
                xx = x;
            }else{
                x = arc4random() % 11 + 5 + rect.size.width;
            }
            rect.origin.x = 0;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        button.frame = CGRectMake(x+rect.origin.x, 10+h*(40), length +YTHAdaptation(40),YTHAdaptation(30));
        button.enabled = YES;
        rect = button.frame;
        g++;
        [button setTitle:dataArray[i] forState:UIControlStateNormal];
        button.backgroundColor = YTHColor(169, 214, 255);
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([_kYDataArray containsObject:dataArray[i]]) {
            button.selected = YES;
            button.layer.borderWidth = 1;//设置边框的宽度，当然可以不要
            button.layer.borderColor = [[UIColor redColor] CGColor];//设置边框的颜色
        }
        self.button=button;
        [self addSubview:button];
        [btnArray addObject:button];
    }
}

-(void)HYH{
    if ([self.delegate respondsToSelector:@selector(labelAddStart)] ) {
        [self.delegate labelAddStart];
    }
    for (UIButton *btn in btnArray) {
        [btn removeFromSuperview];
    }
    [btnArray removeAllObjects];
    [self initBtn];
}

-(void)reloadDataArray:(NSArray *)array{
    dataArray = array;
    for (UIButton *btn in btnArray) {
        [btn removeFromSuperview];
    }
    [btnArray removeAllObjects];
    [self initBtn];
}

-(void)removeBtnSelected:(NSString *)title{
    UIButton *btn = btnArray[[dataArray indexOfObject:title]];
    btn.selected = NO;
    btn.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
    btn.layer.borderColor = [[UIColor redColor] CGColor];//设置边框的颜色
}

-(void)buttonAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(handsomeView:didClickTag:didClickTitle:)] ) {
        [self.delegate handsomeView:self didClickTag:btn didClickTitle:btn.title];
    }
}
- (void)receivedUibutton:(NSNotification*)notification
{
    self.button.enabled = NO;
}


@end
