//
//  HomeViewController.m
//  星优客
//
//  Created by vgool on 15/12/30.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomBarItem.h"
#import "UINavigationItem+CustomItem.h"
#import "SearchViewController.h"
#import "CycleScrollView.h"
#import "GXHttpTool.h"
#import "ScrollListModelModel.h"
#import "ZxlDataServiece.h"
#import "UIImageView+WebCache.h"
#import "SUCUser.h"
#import "HMWaterflowLayout.h"
#import "YHTHomeCollectionViewCell.h"
#import "YHTHomeImageModel.h"
#import "YHTHomeHeaderView.h"
#import "AFHTTPRequestOperationManager.h"
#import "ImagePlayerView.h"
#import "ShowDetailViewController.h"
#import "AppDelegate.h"
#import "LoginFirstViewController.h"
#import "NSData+AES256.h"
#import "MBProgressHUD+NJ.h"
#import "ShowDetailModel.h"
#import "AttentionTableViewCell.h"
#import "MeetView.h"
#import "UnListViewController.h"
#import "WXNavigationController.h"
#import "MyShowLayoutFrame.h"
#define YTHUserInfo [SUCUser initWithUserInfo]
@interface HomeViewController ()<HMWaterflowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ImagePlayerViewDelegate,UITableViewDataSource,UITableViewDelegate,MeetViewDelegate>
{
    UIImageView *arrowImg;
    int start;
    int count;
    AppDelegate *myDelegate;
    UIScrollView *_kTitleView;
    CGRect _kMarkRect;
    NSMutableArray *_kTitleArrays;
    MeetView *meetV;
    
}
@property(nonatomic,strong) CycleScrollView *cycleScorllView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic)NSMutableArray *cycleArray;

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArrays;
@property (nonatomic, strong)UIView *collectionViewHeaderView;
@property (nonatomic, strong)UILabel *videoTitleLabel;
//视频view
@property (nonatomic, strong)UIView *viewVideo;
@property (nonatomic, strong) ImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property(nonatomic,strong)NSDictionary *cycleDict;


//
@property(nonatomic,strong)UIImageView *headImgV;//头像
@property(nonatomic,strong)UIView *headView;//头试图
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)UILabel *nameLabel;//姓名
@property(nonatomic,strong)UIImageView *sexImV;//性别
@property(nonatomic,strong)UILabel *uniserLabel;//学校
@property(nonatomic,strong)UIImageView *bigImage;
@property(nonatomic,strong)UIView *viewBgDesc;//文字详情view
@property(nonatomic,strong)UILabel *labelDesc;
@property(nonatomic,strong)NSDictionary *attenDic;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSDictionary *commentJason;
@property(nonatomic,strong)UIButton *buttonMeet;
@property(nonatomic,strong) UIButton *buttonPoint;
@property(nonatomic,strong)UIButton *buttonAtten;


@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //试图将要出现的时候显示tableBar,解决在遇见的大学搜索页面返回主页面时，tableBar不显示的问题
    self.tabBarController.tabBar.hidden= NO;
    
}


//重写GET方法，在调用Get方法的时候，初始化属性
- (NSMutableArray *)imageURLs
{
    if (!_imageURLs) {
#warning 首页轮播图的请求地址    http://192.168.30.25:8082/ythbk/app/home/getHomeJosn
        NSMutableArray *imageURLs = [NSMutableArray array];
        _imageURLs = imageURLs;
    }
    return _imageURLs;
}

//重写GET方法，在调用Get方法的时候，初始化属性
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        self.scrollView.frame = CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight+300);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (ImagePlayerView *)imagePlayerView
{
    
    //imagePlayerView封装好的轮播试图。
    if (!_imagePlayerView) {
        ImagePlayerView *imagePlayerView= [[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHAdaptation(175))];//175
        
        _imagePlayerView = imagePlayerView;
        
        _imagePlayerView.backgroundColor = [UIColor grayColor];
        
        _imagePlayerView.scrollInterval = 2.0f;
        
        _imagePlayerView.pageControlPosition = ICPageControlPosition_BottomRight;
        
        _imagePlayerView.hidePageControl = NO;
        
        //imagePlayerView添加到collectionViewHeaderView的时候初始化
        [self.collectionViewHeaderView addSubview:self.imagePlayerView];
    
    }
    
    return _imagePlayerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    self.cycleArray = [[NSMutableArray alloc]init];
    
    _kTitleArrays = [[NSMutableArray alloc]init];
    
    self.data = [[NSMutableArray alloc]init];
    
    start = 1;
    //count = 15;
    count = 20;
    
    self.title = @"首页";
    
    self.navigationItem.hidesBackButton =YES;
    
    //设置navigationBar
    [self _initNation];
    
    //创建轮播图
    [self _initCycle];
    
    [self _initDataArray];
    
    [self _initCollectionView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)_initNation
{
    
    ////设置标题视图
    UIView *viewbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth-200, 44)];
    [self.navigationItem setItemWithCustomView:viewbg itemType:center];
    
    
    NSArray *titleArray = @[@"焦点",@"遇见",@"关注"];
    
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = viewbg.frame.size.width/3;
    [buttonPoint setFrame:CGRectMake(0, 7, width, 30)];
    [buttonPoint setTitle:titleArray[0] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonPoint addTarget:self action:@selector(buttonPoint:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonPoint = buttonPoint;
    [viewbg addSubview:buttonPoint];
    
    
    
    UIButton *buttonMeet = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMeet setFrame:CGRectMake(width, 7, width, 30)];
    [buttonMeet setTitle:titleArray[1] forState:UIControlStateNormal];
    [buttonMeet setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
    [buttonMeet addTarget:self action:@selector(buttonMeet:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonMeet =buttonMeet;
    [viewbg addSubview:buttonMeet];
    
    
    
    UIButton *buttonAtten = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonAtten setFrame:CGRectMake(width*2, 7, width, 30)];
    [buttonAtten setTitle:titleArray[2] forState:UIControlStateNormal];
    [buttonAtten setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
    [buttonAtten addTarget:self action:@selector(buttonAtten:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonAtten =buttonAtten;
    [viewbg addSubview:buttonAtten];
    
    
    
    self.buttonPoint.transform = CGAffineTransformMakeScale(1.2,1.2);
    self.buttonMeet.transform = CGAffineTransformMakeScale(0.9,0.9);
    self.buttonAtten.transform =CGAffineTransformMakeScale(0.9,0.9);
    
    
    // 右边的搜索按钮
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    CustomBarItem *rightUtem = [self.navigationItem setItemWithCustomView:searchButton itemType:right];
    [searchButton addTarget:self action:@selector(pushToSearchViewControll) forControlEvents:UIControlEventTouchUpInside];
    [rightUtem setOffset:18];
}
#pragma mark - 焦点
-(void)buttonPoint:(UIButton *)btn
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         btn.transform = CGAffineTransformMakeScale(1.2,1.2);
                         self.buttonMeet.transform = CGAffineTransformMakeScale(0.9,0.9);
                         self.buttonAtten.transform =CGAffineTransformMakeScale(0.9,0.9);
                          [self.buttonAtten setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [self.buttonMeet setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         
                     }
                     completion:^(BOOL finished) {
                         //隐藏状态栏，iOS7要改info里面的属性
                         
                     }];

   
    
    [self.tableview removeFromSuperview];
    [self.headView removeFromSuperview];
    [meetV removeFromSuperview];
    [self.collectionView removeFromSuperview];
    [self _initCycle];
    [self _initDataArray];
    [self _initCollectionView];
}
#pragma mark - 遇见
-(void)buttonMeet:(UIButton *)btn
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         btn.transform = CGAffineTransformMakeScale(1.2,1.2);
                         self.buttonPoint.transform = CGAffineTransformMakeScale(0.9,0.9);
                         self.buttonAtten.transform =CGAffineTransformMakeScale(0.9,0.9);
                         [self.buttonAtten setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [self.buttonPoint setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         
                         
                     }
                     completion:^(BOOL finished) {
                       
                         
                     }];
   
    [meetV removeFromSuperview];
    [self.tableview removeFromSuperview];
    
    [self.headView removeFromSuperview];
    [self.collectionView removeFromSuperview];
    meetV = [[MeetView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight)];
    meetV.delagate = self;
    [self.view addSubview:meetV];
}
#pragma mark - 关注
-(void)buttonAtten:(UIButton *)btn
{

    [UIView animateWithDuration:0.3
                     animations:^{
                         btn.transform = CGAffineTransformMakeScale(1.2,1.2);
                         self.buttonPoint.transform = CGAffineTransformMakeScale(0.9,0.9);
                         self.buttonMeet.transform =CGAffineTransformMakeScale(0.9,0.9);
                         [self.buttonPoint setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [self.buttonMeet setTitleColor:YTHColor(255, 159, 164) forState:UIControlStateNormal];
                         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         
                     }
                     completion:^(BOOL finished) {
                        
                        
                     }];
    
    [self.collectionView removeFromSuperview];
    [meetV removeFromSuperview];
    [self requestAtten];
    [self _initTableView];
}
#pragma mark - 遇见大学点击事件
-(void)universityBtn:(MeetView *)meetview
{
    UnListViewController *unListVC = [[UnListViewController alloc]init];
    [self.navigationController pushViewController:unListVC animated:YES];
    
}
-(void)pushToSearchViewControll
{
    //点击进入搜索页面
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
//轮播图
#pragma mark-uitableView
-(void)_initTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, YTHScreenWidth, YTHScreenHeight-115)style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableview = tableView;
    
    //为什么要注释掉
    //[self.view addSubview:tableView];
    
}

#pragma mark-轮播图
-(void)_initCycle
{
    
    
    self.collectionViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 411)];//411

    
    // pageControl.backgroundColor= [UIColor whiteColor];
    
    //创建一个轮播图
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    md[@"type"] =@"0";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/banner",url];
    
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jasonDic = responseObject;
        
        //NSDictionary *dataDic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        
        self.cycleDict =responseObject;
        
        self.cycleDict = jasonDic;
        
        if ([operation.response statusCode]/100==2) {
            
            //打印的是一个字典
            NSLog(@"轮播图%@",jasonDic);
            
            NSArray *cinemaList = [jasonDic objectForKey:@"banners"];
            
            [self.imageURLs removeAllObjects];
            
            for (NSDictionary *dict in cinemaList) {
                
                //YTHLog(@"%@",dict);
                
                NSString *urlString =dict[@"photourl"];
                
                [self.imageURLs addObject:urlString];
                
                NSString *uuid  = [NSString stringWithFormat:@"%@",[dict objectForKey:@"uuid"]];
                
                //uuid是什么东西
                NSLog(@"id轮播%@",uuid);
                
                [self.cycleArray addObject:uuid];
            }
        }
        
        [self.imagePlayerView initWithCount:self.imageURLs.count delegate:self];
        
        [_collectionView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        
        
    }];
    
    
    //视频view
    UIView *viewVideo = [[UIView alloc]initWithFrame:CGRectMake(0,175, YTHScreenWidth, 96/2)];
    self.viewVideo=viewVideo;
    [self.collectionViewHeaderView addSubview:viewVideo];
    
    //视频标题 Label
    UILabel *videoTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(YTHScreenWidth/2-75, 0, 150, 96/2)];
    videoTitleLabel.text = @"第21期校园达人仿";
    videoTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.videoTitleLabel = videoTitleLabel;
    [viewVideo addSubview:videoTitleLabel];
    UIImageView *imagVideo = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.videoTitleLabel.frame)-13, 14, 10, 16)];
    imagVideo.image = [UIImage imageNamed:@"movie"];
    [viewVideo addSubview:imagVideo];
    // 这里是放视频的
    UIImageView *videoPhotoView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.viewVideo.frame), YTHScreenWidth-20, YTHAdaptation(188))];
    //videoPhotoView.image = [UIImage imageNamed:@"120-1"];
    [videoPhotoView sd_setImageWithURL:[NSURL URLWithString:@"http://7xpt4p.com1.z0.glb.clouddn.com/Fo1EWuwKAniihGA_LYt53Y9JEaDx"]];
    [self.collectionViewHeaderView addSubview:videoPhotoView];
    
}

-(void)tihuan:(YHTHomeImageModel *)model andSize:(CGSize)size{
    YTHLog(@"执行");
    model.width = size.width;
    model.height = size.height;
    [self performSelector:@selector(collectReload) withObject:self afterDelay:0.1];
    
}
-(void)collectReload
{
    [_collectionView reloadData];
    
}
-(void)_initDataArray{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"start"] = [NSString stringWithFormat:@"%d",start];
    md[@"count"] =[NSString stringWithFormat:@"%d",count];
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/show/focus",url];
    
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jasonDic = responseObject;
        NSLog(@"瀑布流error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            NSLog(@"瀑布流%@",jasonDic);
            self.dataArrays = [NSMutableArray array];
            NSArray *showArry = [jasonDic objectForKey:@"shows"];
            for (NSDictionary *dict in showArry) {
                YHTHomeImageModel *model = [[YHTHomeImageModel alloc]initContentWithDic:dict];
                
                CGFloat imageWidth = (YTHScreenWidth-YTHAdaptation(30))/2.0f;
                model.width = imageWidth;
                model.height = imageWidth;
                [self.dataArrays addObject:model];
            }
        }
        
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"瀑布流错误 %ld",(long)[operation.response statusCode]);
        NSDictionary *hMwatarDict = [[NSDictionary alloc]init];
        hMwatarDict = operation.responseObject;
        NSLog(@"瀑布流错误%@",hMwatarDict);
        [MBProgressHUD showError:[hMwatarDict objectForKey:@"info"]];

          }];
    
    
}

-(void)_initCollectionView{
    HMWaterflowLayout *layout = [[HMWaterflowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    layout.headerReferenceSize = CGSizeMake(YTHScreenWidth, YTHAdaptation(20));
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight-64-49) collectionViewLayout:layout];
    //注册代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.scrollView addSubview:self.collectionView];
    
    //添加collectionView的头试图
    [self.collectionView addSubview:self.collectionViewHeaderView];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[YHTHomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[YHTHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    
    self.collectionView.backgroundColor = [UIColor clearColor];
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={(YTHScreenWidth-YTHAdaptation(30))/2.0f,YTHAdaptation(130)};
//    return size;
//}
#pragma mark - <HMWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width {
    YHTHomeImageModel *model = self.dataArrays[indexPath.row];
    NSLog(@"%f  %f  %f",model.width,model.height,YTHScreenWidth);
    return model.height * width / model.width;
}
- (HMWaterflowLayoutSetting)settingInWaterflowLayout:(HMWaterflowLayout *)layout
{
    HMWaterflowLayoutSetting setting;
    setting.rowMargin = YTHAdaptation(10);
    setting.columnMargin = YTHAdaptation(10);
    setting.insets = UIEdgeInsetsMake(YTHAdaptation(0), YTHAdaptation(10), YTHAdaptation(10), YTHAdaptation(10));
    setting.columnsCount = 2;
    setting.HeaderViewHeight = self.collectionViewHeaderView.frame.size.height;
    return setting;
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArrays.count;
    
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    YHTHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.delegate = self;
    cell.model = self.dataArrays[indexPath.row];

    return cell;
}

//collectionView的点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])&&!myDelegate.account.length==0) {
        
        YHTHomeImageModel *imagLoveModel =self.dataArrays[indexPath.row];
        ShowDetailViewController *showVC = [[ShowDetailViewController alloc] init];
        
        showVC.uuid =imagLoveModel.uuid;
        
        [self.navigationController pushViewController:showVC animated:YES];
        return;
        
    }else{
        LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
        
        WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:loginVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}

//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"头部显示");
    if (kind == UICollectionElementKindSectionHeader) {
        YHTHomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        [headerView addSubview:self.collectionViewHeaderView];//头部广告栏
        return headerView;
    }
    return nil;
}
#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    [imageView sd_setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"点击了%ld", (long)index);
    switch (index) {
        case 0:
        {
//
            
            //还有再加一个账号判断
            if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])&&!myDelegate.account.length==0) {
               
                NSString *uuid  = [self.cycleArray objectAtIndex:index];
                NSLog(@"id轮播%@",uuid);
                ShowDetailViewController *showVC = [[ShowDetailViewController alloc] init];
                
                showVC.uuid =uuid;

                
                [self.navigationController pushViewController:showVC animated:YES];
                return;
                
            }else{
                LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
                WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:NO completion:nil];
            }

                      break;
        }
        case 1:
        {
            
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:
        {
            
            break;
        }
        default:
            break;
    }
}


#pragma mark - 关注请求
-(void)requestAtten
{
    NSString *url1 = @"v1/show/attentions";
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/attentions",uS];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.attenDic = responseObject;
        NSLog(@"关注error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {

            NSArray *showArray = [responseObject objectForKey:@"shows"];
            for (NSDictionary *dic in showArray) {
                ShowDetailModel *showModel = [[ShowDetailModel alloc]initContentWithDic:dic];
                MyShowLayoutFrame *myFrame = [[MyShowLayoutFrame alloc]init];
                myFrame.showModel = showModel;
                [self.data addObject:myFrame];
              
            }
            
        }
        
        
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"关注error code %ld",(long)[operation.response statusCode]);
         self.attenDic = operation.responseObject;
        NSLog(@"登录%@", self.attenDic);
        [MBProgressHUD showError:[self.attenDic objectForKey:@"info"]];
      }];
    
}

#pragma mark-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"kIdentifier";
    
    AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[AttentionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.myLayoutFrame = self.data[indexPath.section];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyShowLayoutFrame *weiboF = self.data[indexPath.section];
    return weiboF.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 0.1f;
    }
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
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