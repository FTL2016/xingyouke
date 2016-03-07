//
//  MeetView.m
//  Starucan
//
//  Created by vgool on 16/1/26.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MeetView.h"
#import "PagedFlowView.h"
#import "IAPagedFlowCell.h"
#import "IAFollowTypeModel.h"
#import "IADigUpModel.h"
#import "UnListViewController.h"
#import "HMWaterflowLayout.h"
#import "YHTHomeCollectionViewCell.h"
#import "YHTHomeImageModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "MBProgressHUD+NJ.h"
#import "YHTHomeHeaderView.h"
@interface MeetView()<PagedFlowViewDelegate,PagedFlowViewDataSource,UITableViewDataSource,UITableViewDelegate,HMWaterflowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_digUpArray;
    UITableView *_kCatTableView;
    NSArray *_kCatTableViewTitles;
    NSMutableDictionary *_kIdMutabDict;
    
    int start;
    int count;
    AppDelegate *myDelegate;
    NSString *labelId;
}
@property (strong, nonatomic)PagedFlowView *pageFlowView;
@property (strong, nonatomic)UIImageView *pageFlowBgImage;
@property (strong, nonatomic)UIView *viewButton;
@property (strong, nonatomic)UIScrollView *catScrollView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIView *collectionViewHeaderView;

@property (nonatomic, strong)UIButton *unisverButton;
@property (nonatomic, strong) UIButton *allButton;
@property(nonatomic,strong)NSDictionary *jason;
@end
@implementation MeetView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!myDelegate) {
            myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        }
        
        self.backgroundColor = YTHBaseVCBackgroudColor;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonUniser:) name:@"noticeRefreshCollectList" object:nil];
        
        _digUpArray = [[NSMutableArray alloc]init];
        
        _catScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 40)];
        
        [self addSubview:_catScrollView];
        
        [self.catScrollView setContentSize:CGSizeMake(0, 280)];
        start = 1;
        count = 15;
        //上面按钮
        [self _initButton];//初始化两个按钮
        [self _initCreat];//创建轮播图
        [self _initDataArray];//初始化数据源
        [self _initTableView];//
        [self _initCollectionView];
    }
    return self;
}
-(void)_initDataArray{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"universityId"]=myDelegate.universityId;
    md[@"labelId"]=labelId;
    NSLog(@"id学校%@",myDelegate.universityId);
    NSLog(@"id标签%@",labelId);
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/show/meets",url];
    
    //数据请求
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jasonDic = responseObject;
        
        NSLog(@"瀑布流error code %ld",(long)[operation.response statusCode]);
        
        if ([operation.response statusCode]/100==2) {
            NSLog(@"瀑布流%@",jasonDic);
            
            self.dataArrays = [NSMutableArray array];
            NSArray *showArry = [jasonDic objectForKey:@"shows"];
            
            for (NSDictionary *dict in showArry) {
                YHTHomeImageModel *model =[[YHTHomeImageModel alloc]initContentWithDic:dict];
                
                CGFloat imageWidth = (YTHScreenWidth-YTHAdaptation(30))/2.0f;
                
                model.width = imageWidth;
                model.height = imageWidth;
                
                [self.dataArrays addObject:model];
            }
        }
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"瀑布流error code %ld",(long)[operation.response statusCode]);
        
        self.jason = operation.responseObject;
        
        [MBProgressHUD showError:[ self.jason objectForKey:@"info"]];
    
    }];
    
    
}

-(void)_initTableView
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url1 = Url;
    NSString *url =[NSString stringWithFormat:@"%@v1/label/cats",url1];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //self.jason =responseObject;
        
        NSLog(@"标签%@",responseObject);
        
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        
        if (!_kIdMutabDict) {
            _kIdMutabDict = [[NSMutableDictionary alloc]init];
        }
        
        [_kIdMutabDict removeAllObjects];
        
        if ([operation.response statusCode]/100==2)
        {
            NSArray *arry = [responseObject objectForKey:@"labelCats"];
            
            myDelegate.labelId =[responseObject objectForKey:@"labelCats"];
            
            for (NSDictionary *dic in arry)
            {
                
                [_kIdMutabDict setObject:[dic objectForKey:@"uuid"] forKey:[dic objectForKey:@"name"]];
            
            }
            
            _kCatTableViewTitles = [NSMutableArray arrayWithArray:_kIdMutabDict.allKeys];
        }
#warning 修改
        [_kCatTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"标签错误error code %ld",(long)[operation.response statusCode]);
        
    }];
    _kCatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, YTHScreenWidth, 300) style:UITableViewStylePlain];
    _kCatTableView.delegate = self;
    _kCatTableView.dataSource = self;
    _kCatTableView.bounces = NO;
    
    //透明图
    UIButton *kCatScrollViewBgView = [UIButton buttonWithType:UIButtonTypeCustom];
    kCatScrollViewBgView.frame = CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight);
    [self.catScrollView addSubview:kCatScrollViewBgView];
    [self.catScrollView addSubview:_kCatTableView];
    [self.catScrollView addSubview:_kCatTableView];
    [self.catScrollView bringSubviewToFront:_kCatTableView];
    [_kCatTableView reloadData];
    self.catScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, 0);
    CGFloat kCatScrollViewCntentSizeHeight;
    if (YTHScreenHeight- self.viewButton.frame.origin.y + self.viewButton.frame.size.height>_kCatTableView.frame.size.height) {
        kCatScrollViewCntentSizeHeight = YTHScreenHeight- self.viewButton.frame.origin.y + self.viewButton.frame.size.height;
    }else{
        kCatScrollViewCntentSizeHeight = _kCatTableView.frame.size.height;
    }
    self.catScrollView.contentSize = CGSizeMake(YTHScreenWidth, kCatScrollViewCntentSizeHeight);
    [kCatScrollViewBgView addTarget:self action:@selector(kCatkCatTabelViewFooterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)_initButton
{
    UIView *viewButton = [[UIView alloc]initWithFrame:CGRectMake(0, 64, YTHScreenWidth, 40)];
    self.viewButton=viewButton;
    viewButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewButton];
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(0, 0, YTHScreenWidth/2, 40);
    [allButton setTitle:@"所有类别" forState:UIControlStateNormal];
    [allButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    allButton.tag = 1;
    [allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.allButton=allButton;
    [viewButton addSubview:allButton];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allButton.frame)+1, 9, 0.5, 21)];
    lineV.backgroundColor = YTHColor(197, 197, 197);
    [viewButton addSubview:lineV];
    
    UIButton *unisverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unisverButton.frame = CGRectMake(YTHScreenWidth/2+1, 0, YTHScreenWidth/2, 40);
    [unisverButton setTitle:@"大学" forState:UIControlStateNormal];
    unisverButton.tag = 2;
    [unisverButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [unisverButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.unisverButton = unisverButton;
    [viewButton addSubview:unisverButton];
}
//所有类别和大学的点击方法
-(void)buttonAction:(UIButton *)btn
{
    if (btn.tag==1) {
        
        //下拉页面的收放。
        NSLog(@"所有类别");
        
        [self bringSubviewToFront:self.catScrollView];
        
        if (self.catScrollView.frame.size.height == 0) {
            NSLog(@"点击");
            
            _kCatTableView.frame = CGRectMake(0, 0, YTHScreenWidth, 0);
            
            //self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, 0);
            
            self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, YTHScreenHeight- self.viewButton.frame.origin.y + self.viewButton.frame.size.height);
            
            
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^(void){
                
                _kCatTableView.frame = CGRectMake(0, 0, YTHScreenWidth, 300);
            
            }completion:^(BOOL finished){}];
        
        
        }else{
            self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, YTHScreenHeight- self.viewButton.frame.origin.y + self.viewButton.frame.size.height);
            
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^(void){
                self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, 0);
                
            } completion:^(BOOL finished){}];
        }
        
        
    }else if (btn.tag)
    {
        NSLog(@"大学");
               if ([self.delagate respondsToSelector:@selector(universityBtn:)]) {
            [self.delagate universityBtn:self];
        }
        
        
    }
    
}

-(void)_initCreat
{
    self.collectionViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 104, YTHScreenWidth, 130)];
    
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"type"] =@"1";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/banner",url];
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jasonDic = responseObject;
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            
            NSLog(@"轮播图%@",jasonDic);
            NSArray *cinemaList = [jasonDic objectForKey:@"banners"];
            // [self.imageURLs removeAllObjects];
            for (NSDictionary *dict in cinemaList) {
                NSString *urlString = [NSString stringWithFormat:@"%@",dict[@"photourl"]];
                [_digUpArray addObject:urlString];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        
    }];
    
    
    
    
    _pageFlowView = [[PagedFlowView alloc]initWithFrame:CGRectMake(0, 40, YTHScreenWidth, 144)];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.3;
    _pageFlowView.minimumPageScale = 0.8;
    _pageFlowView.orientation = PagedFlowViewOrientationHorizontal;
    _pageFlowView.scrollView.contentSize = CGSizeMake(INFINITY, _pageFlowView.scrollView.contentSize.height);
    
    
    [self.collectionViewHeaderView addSubview:_pageFlowView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goClickPagedFlowCell:)];
    [_pageFlowView.scrollView addGestureRecognizer:gesture];
    
}
#pragma mark PagedFlowView Datasource
#define TupuSize3 CGSizeMake(150, 200)
-(void) goClickPagedFlowCell:(id) sender
{
    
}
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return _digUpArray.count;
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedFlowView *)flowView {
    NSLog(@"Scrolled to page # %ld", (long)pageNumber);
}
//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    self.pageFlowView.minimumPageScale = 0.8;
    //     IAGameDigUpModel *digUp = _digUpArray[index%_digUpArray.count];
    
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init] ;
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    imageView.image = [UIImage imageNamed:[_digUpArray objectAtIndex:index]];
    return imageView;
}
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(TupuSize3.width-20, TupuSize3.height-20);
}
-(void)kCatkCatTabelViewFooterBtnClick{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^(void){
        self.catScrollView.frame = CGRectMake(0, self.viewButton.frame.origin.y + self.viewButton.frame.size.height, YTHScreenWidth, 0);
    } completion:^(BOOL finished){}];
    
}

-(void)_initCollectionView{
    HMWaterflowLayout *layout = [[HMWaterflowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    layout.headerReferenceSize = CGSizeMake(YTHScreenWidth, YTHAdaptation(20));
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, YTHScreenWidth, YTHScreenHeight) collectionViewLayout:layout];
    //注册代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
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
-(void)tihuan:(YHTHomeImageModel *)model andSize:(CGSize)size{
    NSLog(@"执行");
    model.width = size.width;
    model.height = size.height;
    [self performSelector:@selector(collectReload) withObject:self afterDelay:0.1];
    
}
-(void)collectReload
{
    [_collectionView reloadData];
}

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
    // cell.backgroundColor = [UIColor cyanColor];
    return cell;
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
- (void)buttonUniser:(NSNotification*)notification
{
    NSLog(@"学校%@",myDelegate.university_name);
    
    [_unisverButton setTitle:myDelegate.university_name forState:UIControlStateNormal];
    [self _initDataArray];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCatTabelViewCellId = @"kCatTabelViewCellId";
    UITableViewCell *kCatTabelViewCell = [tableView dequeueReusableCellWithIdentifier:kCatTabelViewCellId];
    if (!kCatTabelViewCell) {
        kCatTabelViewCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCatTabelViewCellId];
    }
    kCatTabelViewCell.textLabel.text = _kCatTableViewTitles[indexPath.row];
    kCatTabelViewCell.textLabel.font = [UIFont systemFontOfSize:14];
    
    //       [[_kIdMutabDict objectForKey:[_kCatTableViewTitles[indexPath.row]];
    
    return kCatTabelViewCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 15.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _kCatTableViewTitles.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_allButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    labelId = [_kIdMutabDict objectForKey:_kCatTableViewTitles[indexPath.row]];
    NSLog(@"标签id%@",labelId);
    [self kCatkCatTabelViewFooterBtnClick];
    [self _initDataArray];
    // [self catTableViewDidSelect:indexPath.row];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == _kCatTableView) {
        UIButton *kCatTabelViewFooterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat kTopAndBottom = (15 - 6)/2.0f;
        CGFloat kLeftAndRight = (YTHScreenWidth - 16)/2.0f;
        kCatTabelViewFooterBtn.imageEdgeInsets = UIEdgeInsetsMake(kTopAndBottom, kLeftAndRight, kTopAndBottom, kLeftAndRight);
        [kCatTabelViewFooterBtn setImage:[UIImage imageNamed:@"slide"] forState:UIControlStateNormal];
        kCatTabelViewFooterBtn.backgroundColor = [UIColor whiteColor];
        kCatTabelViewFooterBtn.frame = CGRectMake(0, 0, YTHScreenWidth, 15.0f);
        UIView *kGXian = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 0.4)];
        kGXian.backgroundColor = [UIColor colorWithRed:154.0f/255.0f green:154.0f/255.0f blue:154.0f/255.0f alpha:0.7f];
        // kGXian.backgroundColor = [UIColor redColor];
        [kCatTabelViewFooterBtn addSubview:kGXian];
        [kCatTabelViewFooterBtn addTarget:self action:@selector(kCatkCatTabelViewFooterBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return kCatTabelViewFooterBtn;
    }
    return nil;
}


@end
