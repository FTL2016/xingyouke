//
//  PickUiview.h
//  Starucan
//
//  Created by vgool on 16/2/14.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickUiview;
@protocol PickUiviewDelegate <NSObject>
@optional
-(void)SureBtn:(PickUiview*)meetview didClickTitle:(NSString *)title;
@end




@interface PickUiview : UIView
@property (strong, nonatomic)UIPickerView *customPicker;
@property(nonatomic,strong)id<PickUiviewDelegate>delagate;
- (void)showInView:(UIView *)view;
@end
