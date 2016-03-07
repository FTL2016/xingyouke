//
//  YHTHomeCollectionViewCell.h
//  Starucan
//
//  Created by Lonely丶晏袁杰 on 16/1/7.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHTHomeImageModel;
@class HomeViewController;
@interface YHTHomeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)YHTHomeImageModel *model;
@property (nonatomic, assign)HomeViewController *delegate;
@end
