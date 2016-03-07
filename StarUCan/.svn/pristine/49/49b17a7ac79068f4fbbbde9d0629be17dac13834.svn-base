//
//  LookViewController.h
//  Starucan
//
//  Created by vgool on 16/1/17.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LookViewController;
@protocol LookViewDelegate<NSObject>
@optional
- (void)looksomeView:(LookViewController *)wordView  didClickTitle:(NSString *)title;
@end

@interface LookViewController : UIViewController
@property (nonatomic, weak) id<LookViewDelegate> delegate;
@end
