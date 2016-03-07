//
//  WordViewController.h
//  Starucan
//
//  Created by vgool on 16/1/16.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordViewController;
@protocol WordsomeDelegate<NSObject>
@optional
- (void)wordsomeView:(WordViewController *)wordView  didClickTitle:(NSString *)title;
@end




@interface WordViewController : UIViewController
@property (nonatomic, weak) id<WordsomeDelegate> delegate;

@end
