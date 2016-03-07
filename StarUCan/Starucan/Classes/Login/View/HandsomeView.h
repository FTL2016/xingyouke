//
//  HandsomeView.h
//  Starucan
//
//  Created by vgool on 16/1/12.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HandsomeView;
@protocol HandsomeDelegate<NSObject>
@optional
- (void)handsomeView:(HandsomeView *)zheView didClickTag:(UIButton *)button didClickTitle:(NSString *)title;
-(void)labelAddStart;
@end

@interface HandsomeView : UIView
-(id)initWithFrame:(CGRect)frame andData:(NSMutableArray *)array;
@property (nonatomic, weak) id<HandsomeDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *kYDataArray;
-(void)removeBtnSelected:(NSString *)title;
-(void)reloadDataArray:(NSArray *)array;
@property(nonatomic,strong)UIButton *button;



@end