//
//  YHTHomeCollectionViewCell.m
//  Starucan
//
//  Created by Lonely丶晏袁杰 on 16/1/7.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "YHTHomeCollectionViewCell.h"
#import "YHTHomeImageModel.h"
#import "UIImageView+WebCache.h"
#import "HomeViewController.h"
@interface YHTHomeCollectionViewCell()
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation YHTHomeCollectionViewCell


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:self.imageView];
    
    }
    
    return self;
}


-(void)setModel:(YHTHomeImageModel *)model{
    NSString *modelSrting =model.photoUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:modelSrting] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error&&image) {
            CGFloat imageWidth = (YTHScreenWidth-30)/2.0f;
            CGSize size = image.size;
            size.height = imageWidth/size.width*size.height;
            size.width = imageWidth;
            
            if (_delegate&&(size.height!=model.height)) {
                
                [_delegate tihuan:model andSize:size];
                
            }
        
        }
    
    }];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
