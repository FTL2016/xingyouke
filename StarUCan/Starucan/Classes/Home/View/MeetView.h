//
//  MeetView.h
//  Starucan
//
//  Created by vgool on 16/1/26.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeetView;
@protocol MeetViewDelegate <NSObject>
@optional
-(void)universityBtn:(MeetView*)meetview;
@end



@interface MeetView : UIView
@property (nonatomic, strong)NSMutableArray *dataArrays;
@property(nonatomic,strong)id<MeetViewDelegate>delagate;
@end
