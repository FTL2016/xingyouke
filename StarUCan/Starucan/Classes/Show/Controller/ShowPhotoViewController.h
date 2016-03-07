//
//  ShowPhotoViewController.h
//  Starucan
//
//  Created by vgool on 16/1/8.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPhotoViewController : UIViewController
-(void)deletePhotoImage:(UIImage *)image;
@property (nonatomic, assign)NSInteger currentItem;  //当前选中（显示）的单元格
@property (strong, nonatomic) NSMutableArray *photoNameList;
@end
