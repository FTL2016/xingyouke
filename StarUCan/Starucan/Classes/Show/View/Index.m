//
//  Index.m
//  Starucan
//
//  Created by vgool on 16/1/13.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "Index.h"

@implementation Index
{
    UIImageView *_indexImageView;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _indexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [self addSubview:_indexImageView];
        
    }
    return self;
}
-(void)setPhotoImage:(UIImage *)image
{
    _indexImageView.image = image;
}
@end
