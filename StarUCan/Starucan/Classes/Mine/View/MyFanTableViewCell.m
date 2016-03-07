//
//  MyFanTableViewCell.m
//  Starucan
//
//  Created by vgool on 16/1/26.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MyFanTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
@implementation MyFanTableViewCell
{
     AppDelegate *myDelegate;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    UIImageView *headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    [headImgV.layer setMasksToBounds:YES];
    [headImgV.layer setCornerRadius:20];
    headImgV.layer.borderColor = [UIColor grayColor].CGColor;
    headImgV.layer.borderWidth = 1;
    self.headImgV = headImgV;
    [self.contentView addSubview:self.headImgV];
    
    //名字
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
    nameLabel.text = @"顾梦慈";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.backgroundColor = [UIColor yellowColor];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:self.nameLabel];
    //性别
    UIImageView *sexImV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 15, 15, 15)];
    //sexImV.image = [UIImage imageNamed:@"sex_female"];
    self.sexImV = sexImV;
    [self.contentView addSubview:sexImV];
    //学校
    UILabel *uniserLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 30)];
    uniserLabel.text = @"dsa";
    uniserLabel.font = [UIFont systemFontOfSize:12];
    uniserLabel.textColor = [UIColor grayColor];
    self.uniserLabel=uniserLabel;
    [self.contentView addSubview:self.uniserLabel];
   
        
        UIButton *addAttionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addAttionBtn.frame = CGRectMake(YTHScreenWidth-100, 10, 50, 30);
        
        [addAttionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        addAttionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [addAttionBtn.layer setMasksToBounds:YES];
        [addAttionBtn.layer setCornerRadius:4.5];
        addAttionBtn.layer.borderColor = [UIColor blueColor].CGColor;
        addAttionBtn.layer.borderWidth = 1;
        [addAttionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
        self.addAttionBtn = addAttionBtn;
        [self.contentView addSubview:addAttionBtn];
    
   

    
    
    //3.微博图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    return self;

}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setShowModel:(ShowDetailModel *)showModel
{
    if (_showModel!=showModel) {
        _showModel=showModel;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:self.showModel.avatar
                                       ]];
    
    
    //性别
    NSString *sexurl = self.showModel.sex;
    if ([sexurl isEqualToString:@"0"]) {
        self.sexImV.image = [UIImage imageNamed:@"sex_male"];
    }else if ([sexurl isEqualToString:@"2"])
    {
          self.sexImV.image = [UIImage imageNamed:@"sex_female"];
    }
    
    
    //头像
    NSString *urlString = self.showModel.avatar;
    
    
    if (!IsNilOrNull(self.showModel.avatar)&&!urlString.length==0) {
        //                    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.urlString]] placeholderImage:nil];
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
    }else{
        if ([sexurl isEqualToString:@"0"]) {
            self.headImgV.image =  [UIImage imageNamed:@"female"];
        }else if ([sexurl isEqualToString:@"1"]){
            self.headImgV.image =  [UIImage imageNamed:@"male"];
        }
    }
    
    
    
    
    
    self.nameLabel.text = self.showModel.name;
    self.uniserLabel.text = self.showModel.universityName;
    
    
    
    if (self.flag) {
        
        //是否关注
        if (!IsNilOrNull(self.showModel.userRelStatus)) {
            NSString *userRelStatus=self.showModel.userRelStatus;
            if ([userRelStatus isEqualToString:@"0"]) {
                
                [self.addAttionBtn setTitle:@"未关注" forState:UIControlStateNormal];
                
            }else if ([userRelStatus isEqualToString:@"1"])
            {
                [self.addAttionBtn setTitle:@"已关注" forState:UIControlStateNormal];
            }else if ([userRelStatus isEqualToString:@"2"])
            {
                [self.addAttionBtn setTitle:@"互相关注" forState:UIControlStateNormal];
                
            }
        }else{
            //[self.addAttionBtn removeFromSuperview];
            //          [self.addAttionBtn setTitle:@"未关注" forState:UIControlStateNormal];
            self.addAttionBtn.hidden = NO;
            [self.addAttionBtn.layer setMasksToBounds:YES];
            [self.addAttionBtn.layer setCornerRadius:4.5];
            self.addAttionBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            self.addAttionBtn.layer.borderWidth = 1;
        }
        

    }else{
        [self.addAttionBtn.layer setMasksToBounds:YES];
        [self.addAttionBtn.layer setCornerRadius:4.5];
        self.addAttionBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.addAttionBtn.layer.borderWidth = 1;
        
    }
       NSDictionary *showMapDic = self.showModel.showMap;
    NSArray *showArray = [showMapDic objectForKey:@"shows"];
    if (showArray.count!=0) {
        for (NSDictionary *dict in showArray) {
            photosUrlArr = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"photoUrl"]] componentsSeparatedByString:@","];
            
            
        }
        NSMutableArray *photoListArry = [[NSMutableArray alloc]init];
        for (NSString *photoUrl in photosUrlArr) {
            [photoListArry addObject:photoUrl];
        }
        
        
        //是否有图片
        NSString *thumbnailImage = [photoListArry objectAtIndex:0];
       
            float x = 0;
            //有图片暂时显示一个
            for (int i = 0; i <1; i++){
                
                _imgView.hidden = NO;
                _imgView.frame = CGRectMake(60+x+10, CGRectGetMaxY(self.uniserLabel.frame)+3, 50, 50);
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:photoListArry[i]]];
            x+=58;
            }
      }else
    {
        _imgView.hidden = YES;
    }
    
    
    
    
    
    
    
    
   
}
#pragma mark-关注
- (void)attention:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        NSString *uS = Url;
        
        NSString *ueltext = [NSString stringWithFormat:@"v1/user/%@/follow",self.showModel.uuid];
        NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
        NSLog(@"登录密码=%@",myDelegate.accessToken);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
        [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@/follow",uS,self.showModel.uuid];
        NSLog(@"关注拼接之后%@",urlStr);
        //用户id 传过去
        [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"关注%@",responseObject);
//            self.attenJason = responseObject;
            NSLog(@"关注 %ld",(long)[operation.response statusCode]);
            if ([operation.response statusCode]/100==2)
            {
                [self.addAttionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"关注 %ld",(long)[operation.response statusCode]);
//            self.attenJason = operation.responseObject;
//            NSLog(@"关注%@", self.attenJason);
//            [MBProgressHUD showError:[self.attenJason objectForKey:@"info"]];
            
        }];
//
        
    }else{
        NSString *uS = Url;
        NSString *ueltext = [NSString stringWithFormat:@"v1/user/%@/follow",self.showModel.uuid];
        NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
        NSLog(@"登录密码=%@",myDelegate.accessToken);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
        [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@/follow",uS,self.showModel.uuid];
        
        
        
        [manager DELETE:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"取消关注%@",responseObject);
           // self.attenJason = responseObject;
            NSLog(@"取消关注 %ld",(long)[operation.response statusCode]);
            if ([operation.response statusCode]/100==2)
            {
                [self.addAttionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"取消关注 %ld",(long)[operation.response statusCode]);
            //self.attenJason = operation.responseObject;
           // NSLog(@"取消关注%@", self.attenJason);
//            [MBProgressHUD showError:[self.attenJason objectForKey:@"info"]];
            
        }];
        
        
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
