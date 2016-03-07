//
//  HMWaterflowLayout.h
//  02-瀑布流
//
//  Created by apple on 15/3/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    /** 列数 */
    NSUInteger columnsCount;
    /** 每一行的间距 */
    CGFloat rowMargin;
    /** 每一列的间距 */
    CGFloat columnMargin;
    /** 上下左右的间距 */
    UIEdgeInsets insets;
    /** 实现头视图  这个属性是高度 */
    CGFloat HeaderViewHeight;
} HMWaterflowLayoutSetting;

@class HMWaterflowLayout;

@protocol HMWaterflowLayoutDelegate <NSObject>
@required
/**
 * 返回indexPath位置cell的高度
 */
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width;

@optional
// 粗粒度设计的特点：用一个方法搞定所有数据、要求返回所有数据
- (HMWaterflowLayoutSetting)settingInWaterflowLayout:(HMWaterflowLayout *)layout;
@end

@interface HMWaterflowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<HMWaterflowLayoutDelegate> delegate;
@end
