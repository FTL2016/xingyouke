//
//  IADigUpModel.h
//  Starucan
//
//  Created by vgool on 16/1/21.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IADigUpModel : NSObject
@property (nonatomic, copy) NSString *starId;
@property (nonatomic, copy) NSString *starName;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *starImage;
@property (nonatomic, copy) NSString *relationName;
@property (nonatomic, copy) NSString *sourceUrl;
@property (readwrite) CGPoint positionInTupu;
@end
