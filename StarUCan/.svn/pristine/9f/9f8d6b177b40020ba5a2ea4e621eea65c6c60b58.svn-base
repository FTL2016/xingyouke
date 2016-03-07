//
//  HMWaterflowLayout.m
//  02-瀑布流
//
//  Created by apple on 15/3/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMWaterflowLayout.h"

#define HMCollectionW self.collectionView.frame.size.width

/** 每一行之间的间距 */
static const CGFloat HMDefaultRowMargin = 10;
/** 每一列之间的间距 */
static const CGFloat HMDefaultColumnMargin = 10;
/** 每一列之间的间距 top, left, bottom, right */
static const UIEdgeInsets HMDefaultInsets = {10, 10, 10, 10};
/** 默认的列数 */
static const int HMDefaultColumsCount = 3;

@interface HMWaterflowLayout()
{
    HMWaterflowLayoutSetting _abc;
}
/** 每一列的最大Y值 */
@property (nonatomic, strong) NSMutableArray *columnMaxYs;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/** 这行代码的目的：能够使用self.setting调用setting方法 */
- (HMWaterflowLayoutSetting)setting;
@end

@implementation HMWaterflowLayout

#pragma mark - 懒加载
- (NSMutableArray *)columnMaxYs
{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark - 实现内部的方法
/**
 * 决定了collectionView的contentSize
 */
- (CGSize)collectionViewContentSize
{
    // 找出最长那一列的最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }

    return CGSizeMake(0, destMaxY + self.setting.insets.bottom);
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 重置每一列的最大Y值
    [self.columnMaxYs removeAllObjects];
    for (NSUInteger i = 0; i<self.setting.columnsCount; i++) {
        [self.columnMaxYs addObject:@(self.setting.insets.top)];
    }
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 说明所有元素（比如cell、补充控件、装饰控件）的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 说明cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算indexPath位置cell的布局属性 */
    
    // 水平方向上的总间距
    CGFloat xMargin = self.setting.insets.left + self.setting.insets.right + (self.setting.columnsCount - 1) * self.setting.columnMargin;
    // cell的宽度
    CGFloat w = (HMCollectionW - xMargin) / self.setting.columnsCount;
    // cell的高度
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath withItemWidth:w];
    
    // clothes.w clothes.h
    // w     ---> h
    // w * clothes.h / clothes.w

    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    // cell的x值
    CGFloat x = self.setting.insets.left + destColumn * (w + self.setting.columnMargin);
    // cell的y值
    CGFloat HeaderViewHeight = 0;
    if(indexPath.row<2){
        HeaderViewHeight = self.setting.HeaderViewHeight;
    }
    CGFloat y = destMaxY + self.setting.rowMargin + HeaderViewHeight;
    // cell的frame
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

// 细粒度

#pragma mark - 处理代理数据
- (HMWaterflowLayoutSetting)setting
{
    if ([self.delegate respondsToSelector:@selector(settingInWaterflowLayout:)]) {
        return [self.delegate settingInWaterflowLayout:self];
    }
    
    HMWaterflowLayoutSetting setting;
    setting.rowMargin = HMDefaultRowMargin;
    setting.columnMargin = HMDefaultColumnMargin;
    setting.columnsCount = HMDefaultColumsCount;
    setting.insets = HMDefaultInsets;
    return setting;
}
@end
