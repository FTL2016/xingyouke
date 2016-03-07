//
//  MineViewController.m
//  星优客
//
//  Created by vgool on 15/12/30.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "MineViewController.h"
#import "AppDelegate.h"
#import "NSData+AES256.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginFirstViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+NJ.h"
#import "UserInfoViewController.h"
#import "MyFanViewController.h"
#import "MyAttentionViewController.h"
#import "StretchableTableHeaderView.h"
#import "MyShowViewController.h"
#import "MyTopicViewController.h"
#import "ImageListController.h"
#import "SettingViewController.h"
@interface MineViewController ()
{
    AppDelegate *myDelegate;
}
@property(nonatomic,strong) UIImageView *faceImg;
@property(nonatomic,strong) UILabel *userNameLab;
@property(nonatomic,strong)UIImageView *sexImv;
@property(nonatomic,strong)UILabel *signLabel;
@property(nonatomic,strong)UILabel *attentionLabel;//关注
@property(nonatomic,strong)UILabel *fansLabel;//粉丝
@property(nonatomic,strong)UILabel *popularLabel ;
@property(nonatomic,strong)NSDictionary *dictMine;
@property(nonatomic,strong)NSString *attentionString;//关注
@property(nonatomic,strong)NSString *popularString;
@property(nonatomic,strong)NSString *fansString;//
@property(nonatomic,strong)UIImageView *popularImv;
@property(nonatomic,strong)UIImageView *headImg;
@property (nonatomic, strong) StretchableTableHeaderView *stretchableTableHeaderView;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.userNameLab.text=[myDelegate.userInfo objectForKey:@"name"];
    
    NSString *urlString = [myDelegate.userInfo objectForKey:@"avatar"];
    if (!IsNilOrNull(urlString)&&!urlString.length==0) {
        [self.faceImg sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
    }else{
        NSString *sexurl=[myDelegate.userInfo objectForKey:@"sex"];
        if ([sexurl isEqualToString:@"2"]) {
            self.faceImg.image =  [UIImage imageNamed:@"female"];
        }else if ([sexurl isEqualToString:@"1"]){
            self.faceImg.image =  [UIImage imageNamed:@"male"];
        }
        
    }
    
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_tile"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
   // self.navigationController.navigationBar.barTintColor  = YTHColor(255, 32, 52);

}
-(instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    

    self.navigationItem.title = @"个人中心";
    // 设置组间距
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 15;
    [self requestData];
    [self setHead];
    [self _loadNavigationViews];
}
- (void)_loadNavigationViews
{
    
    
    //编辑
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    // sendButton.imgName = @"button_icon_ok.png";
    [sendButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    
}

- (void)editAction
{
    UserInfoViewController  *userInfo = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userInfo animated:YES];
    
}
#pragma mark-请求数据
-(void)requestData
{
    NSString *userUuid =[myDelegate.userInfo objectForKey:@"uuid"];
    NSString *url1 = [NSString stringWithFormat:@"v1/user/%@",userUuid];
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"我的 %ld",(long)[operation.response statusCode]);
        self.dictMine = responseObject;
        if ([operation.response statusCode]/100==2)
        {
            NSLog(@"%@",responseObject);
            
            myDelegate.userInfo = [responseObject objectForKey:@"userInfo"];
            
            //性别
            NSString *sexurl = [[responseObject objectForKey:@"userInfo"]objectForKey:@"sex"];
            if ([sexurl isEqualToString:@"1"]) {
                self.sexImv.image = [UIImage imageNamed:@"sex_male"];
            }else if ([sexurl isEqualToString:@"2"])
            {
                  self.sexImv.image = [UIImage imageNamed:@"sex_female"];
            }
            
            
            //头像
            NSString *urlString = [[responseObject objectForKey:@"userInfo"]objectForKey:@"avatar"];
            NSLog(@"头像%@",urlString);
            
            if (!IsNilOrNull([[responseObject objectForKey:@"userInfo"]objectForKey:@"avatar"])&&!urlString.length==0) {
                //                    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.urlString]] placeholderImage:nil];
                [self.faceImg sd_setImageWithURL:[NSURL URLWithString:urlString]];
                
            }else{
                if ([sexurl isEqualToString:@"2"]) {
                    self.faceImg.image =  [UIImage imageNamed:@"female"];
                }else if ([sexurl isEqualToString:@"1"]){
                    self.faceImg.image =  [UIImage imageNamed:@"male"];
                }
            }
            
            self.userNameLab.text = [[responseObject objectForKey:@"userInfo"]objectForKey:@"name"];
            
            if (!IsNilOrNull([[responseObject objectForKey:@"userInfo"]objectForKey:@"signature"])) {
                self.signLabel.text =[[responseObject objectForKey:@"userInfo"]objectForKey:@"signature"];
                
            }else{
                self.signLabel.text = @"哈哈";
            }
            
            
            self.popularString = [[responseObject objectForKey:@"userInfo"]objectForKey:@"popularity"];
            NSLog(@"人气%@",self.popularString);
            self.fansString = [[responseObject objectForKey:@"userInfo"]objectForKey:@"fans"];
            NSLog(@"粉丝%@",self.fansString);
            self.attentionString = [[responseObject objectForKey:@"userInfo"]objectForKey:@"follows"];
            NSLog(@"人气%@",self.attentionString);
            self.popularLabel.text = [NSString stringWithFormat:@"%@",self.popularString];
            self.fansLabel.text = [NSString stringWithFormat:@"%@",self.fansString];
            self.attentionLabel.text = [NSString stringWithFormat:@"%@",self.attentionString];
            NSString *popularityStatus = [[responseObject objectForKey:@"userInfo"]objectForKey:@"popularityStatus"];
            if ([popularityStatus isEqualToString:@"0"]) {
                _popularImv.image = [UIImage imageNamed:@"icon_zan_red"];
                
            }else if ([popularityStatus isEqualToString:@"1"])
            {
                _popularImv.image = [UIImage imageNamed:@"icon_zan_red"];
            }else if ([popularityStatus isEqualToString:@"2"])
            {
                _popularImv.image = [UIImage imageNamed:@"icon_zan"];
            }
            
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我的 错误%ld",(long)[operation.response statusCode]);
        self.dictMine = operation.responseObject;
        NSLog(@"登录%@", self.dictMine);
        [MBProgressHUD showError:[ self.dictMine objectForKey:@"info"]];
    }];
    
}
#pragma mark - 表头
- (void)setHead{
    UIImageView *headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_background"]];
    headImg.frame = CGRectMake(0, 0, YTHScreenWidth, 252);
    headImg.userInteractionEnabled = YES;
    self.headImg = headImg;
    // self.tableView.tableHeaderView = headImg;
    
    self.stretchableTableHeaderView = [[StretchableTableHeaderView alloc] init];
    
    [self.stretchableTableHeaderView stretchHeaderForTableView:self.tableView withView:headImg];
    
    
    //头像
    UIImageView *faceImg = [[UIImageView alloc]initWithFrame:CGRectMake(YTHScreenWidth/2-43, 20, 86, 86)];
    faceImg.image = [UIImage imageNamed:@"female"];
    self.faceImg = faceImg;
    [headImg addSubview:faceImg];
    
    [faceImg.layer setMasksToBounds:YES];
    [faceImg.layer setCornerRadius:43];
    faceImg.layer.borderColor = [UIColor whiteColor].CGColor;
    faceImg.layer.borderWidth = 1;
    faceImg.userInteractionEnabled = YES;
    
    
    //姓名
    UILabel *userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(YTHScreenWidth/2-40, CGRectGetMaxY(faceImg.frame)+18, 120, 30)];
    userNameLab.text = @"昵称";
    userNameLab.font= [UIFont systemFontOfSize:14];
    self.userNameLab = userNameLab;
    [headImg addSubview:userNameLab];
    //性别
    UIImageView *sexImv = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userNameLab.frame), CGRectGetMaxY(faceImg.frame)+18, 16, 16)];
    sexImv.image = [UIImage imageNamed:@"sex_female"];
    self.sexImv = sexImv;
    [headImg addSubview:sexImv];
    
    
    //个性签名
    
    UILabel *signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userNameLab.frame)+5, YTHScreenWidth, 30)];
    signLabel.text = @"个性签名";
    signLabel.textColor = [UIColor blackColor];
    signLabel.font = [UIFont systemFontOfSize:12];
    self.signLabel = signLabel;
    signLabel.textAlignment = NSTextAlignmentCenter;
    [headImg addSubview:signLabel];
    
    NSArray *titleArray =@[@"关注",@"粉丝",@"人气"];
    
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*YTHScreenWidth/3, 190, YTHScreenWidth/3, 47);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        // button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headImg addSubview:button];
        button.tag =i;
        [button addTarget:self action:@selector(receiveClick:) forControlEvents:UIControlEventTouchUpInside];
        button.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //        //线
        //        UIView *segmentView =[[UIView alloc] initWithFrame:CGRectMake(-1+i*YTHScreenWidth/3, 255, 1, 31)];
        //        segmentView.backgroundColor =[UIColor grayColor];
        //        [headImg addSubview:segmentView];
        
        switch (i) {
            case 0:
            {
                UILabel *attentionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 30)];
                //attentionLabel.text = self.attentionString;
                
                attentionLabel.textColor = [UIColor blackColor];
                attentionLabel.textAlignment = NSTextAlignmentCenter;
                attentionLabel.font = [UIFont systemFontOfSize:14];
                self.attentionLabel=attentionLabel;
                [button addSubview:attentionLabel];
                
            }
                break;
            case 1:
            {
                UILabel *fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 30)];
                fansLabel.text = @"456";
                fansLabel.textColor = [UIColor blackColor];
                fansLabel.textAlignment = NSTextAlignmentCenter;
                fansLabel.font = [UIFont systemFontOfSize:14];
                self.fansLabel = fansLabel;
                [button addSubview:fansLabel];
                
            }
                break;
            case 2:
            {
                UILabel *popularLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 30)];
                popularLabel.text = @"789";
                popularLabel.textColor = [UIColor blackColor];
                popularLabel.textAlignment = NSTextAlignmentCenter;
                popularLabel.font = [UIFont systemFontOfSize:14];
                self.popularLabel=popularLabel;
                
                [button addSubview:popularLabel];
                
                
                UIImageView *popularImv = [[UIImageView alloc]initWithFrame:CGRectMake(button.width/2+10, 10, 15, 15)];
                popularImv.image = [UIImage imageNamed:@"icon_zan_red"];
                self.popularImv =popularImv;
                [button addSubview:popularImv];
                
                
            }
                
            default:
                break;
        }
    }
    
    
    //    NSLog(@"=====biaotou====%f", self.tableView.tableHeaderView.frame.size.height);
}
-(void)receiveClick:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            YTHLog(@"点击1");
        {
            MyAttentionViewController *myAttenVC = [[MyAttentionViewController alloc]init];
            [self.navigationController pushViewController:myAttenVC animated:YES];
        }
            
            
            break;
        case 1:
        {
            MyFanViewController *myfanVC = [[MyFanViewController alloc]init];
            [self.navigationController pushViewController:myfanVC animated:YES];
        }
            YTHLog(@"点击2");
            break;
        case 2:
            YTHLog(@"点击3");
            break;
        default:
            break;
    }
}
#pragma mark - 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (0==section) {
        return 2;
    }
    
    if (1==section) {
        return 1;
    }
    if (2==section) {
        return 1;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (0==indexPath.section) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    
    if (0==indexPath.section && 0==indexPath.row) {
        cell.textLabel.text = @"我的秀";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"icon_my_show"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (0==indexPath.section && 1==indexPath.row) {
        cell.textLabel.text = @"我的话题";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"icon_my_topic"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (1==indexPath.section && 0==indexPath.row) {
        cell.textLabel.text = @"我的收藏";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"icon_my_collect"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (2==indexPath.section && 0==indexPath.row) {
        cell.textLabel.text = @"用户设置";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"icon_my_set"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
                MyShowViewController *myVC = [[MyShowViewController alloc]init];
                [self.navigationController pushViewController:myVC animated:YES];
     //另外一种展示
//        ImageListController *imagVC = [[ImageListController alloc]init];
//        [self.navigationController pushViewController:imagVC animated:YES];
    }if (indexPath.section==0&&indexPath.row==1) {
        MyTopicViewController *topVC = [[MyTopicViewController alloc]init];
        [self.navigationController pushViewController:topVC animated:YES];
        
    }
    if (indexPath.section==2) {
        SettingViewController *setting = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
}

CGFloat ImageHeight = 252.0;
//CGFloat ImageWidth = YTHScreenWidth;

//#pragma mark -UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //拿到向下滑动的偏移量（距离）
//    CGFloat yOffset = self.tableView.contentOffset.y;
//
//    if (yOffset < 0) { //从边界向下滑动
//        //计算滑动之后，图片增加之后的高度
//        CGFloat height = ABS(yOffset) + ImageHeight;
//
//        //原宽度/原高度=新宽度/新高度
//        //计算滑动之后，图片增加之后的宽度
//        CGFloat width = YTHScreenWidth/ImageHeight * height;
//
//
//        CGRect frame = CGRectMake(-(width - YTHScreenWidth)/2, 0, width, height);
//        self.headImg.frame = frame;
//    }else
//    {
//        //向上滑动
//        self.headImg.top = -yOffset;
//
//    }
//
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
