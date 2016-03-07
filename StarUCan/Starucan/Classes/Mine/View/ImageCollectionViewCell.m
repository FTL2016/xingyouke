//
//  ImageCollectionViewCell.m
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ImageCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews
{
    _imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(YTHScreenWidth-70)/3, 120)];
    [self.contentView addSubview:_imagV];
}
-(void)setModel:(ShowDetailModel *)model
{
    _model = model;
    NSArray *photosUrlArr = [_model.photoUrl componentsSeparatedByString:@","];
    NSMutableArray *photoNameList = [[NSMutableArray alloc]init];
    for (NSString *photoUrl in photosUrlArr) {
        [photoNameList addObject:photoUrl];
    }
    
    //    [imgView setImageWithURL:[NSURL URLWithString:model.photoUrl]];
    [_imagV sd_setImageWithURL:[NSURL URLWithString:[photoNameList objectAtIndex:0]]];

    
    
    
    
}
@end
