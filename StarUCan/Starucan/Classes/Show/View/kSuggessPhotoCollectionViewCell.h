//
//  kSuggessPhotoCollectionViewCell.h
//  vgool
//
//  Created by Lonely丶晏袁杰 on 15/12/18.
//  Copyright © 2015年 chenyanming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuggessViewController;
@interface kSuggessPhotoCollectionViewCell : UICollectionViewCell
-(void)setPhotoImage:(NSString *)image andDeleteBtnHidden:(BOOL)hidden;
-(void)setImage:(UIImage *)image andDeleteBtnHidden:(BOOL)hidden;

@property(nonatomic, assign)SuggessViewController *kSuggessPhotoCollectionViewCellDelegate;
-(void)setPhotoImageLayer:(BOOL)layer;
@end
