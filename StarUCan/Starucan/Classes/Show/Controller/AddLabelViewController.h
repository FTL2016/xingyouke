//
//  AddLabelViewController.h
//  Starucan
//
//  Created by vgool on 16/1/16.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddLabelViewController;
@protocol AddLabelDelegate<NSObject>
@optional
- (void)AddLabelView:(AddLabelViewController *)zheView didClickTag:(NSString *)idKey didClickTitle:(NSString *)title;
@end
@interface AddLabelViewController : UIViewController
@property (nonatomic, weak) id<AddLabelDelegate> delegate;
@end
