//
//  IAPagedFlowCell.h
//  Starucan
//
//  Created by vgool on 16/1/21.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAFollowTypeModel.h"
#import "IADigUpModel.h"
@interface IAPagedFlowCell : UIImageView
@property (weak, nonatomic) IADigUpModel *model;
@property (weak ,nonatomic) IAFollowTypeModel *typeModel;
@property (nonatomic, strong) void (^clickPagedFlowCell) ();
@end
