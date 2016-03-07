//
//  ShowDetailViewController.m
//  Starucan
//
//  Created by vgool on 16/1/22.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "kSuggessPhotoCollectionViewCell.h"
#import "ShowDetailModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD+NJ.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
#import "ShowCommentModel.h"
#import "ShowTableViewCell.h"
#import "CommentViewController.h"
#import "AnswerViewController.h"
#import "ShowDetailModel.h"
#import "MyFanTableViewCell.h"
#import "VIPhotoView.h"
#import "CommentLayFrame.h"
#import "PraiseTableViewCell.h"
@interface ShowDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *sex;
    CGFloat _kPhotoCollectionViewJJ;
    UICollectionView *_kPhotoCollectionView;
    UICollectionViewFlowLayout *_kPhotoCollectionViewFlowLayout;
    UIScrollView *_kTitleView;
    CGRect _kMarkRect;
    NSMutableArray *_kTitleArrays;
    AppDelegate *myDelegate;
    VIPhotoView *_kVIPhotoView;
   
    
    PraiseTableViewCell *praisecell;
    
    
}
//
@property(nonatomic,strong)UIImageView *headImgV;//头像
@property(nonatomic,strong)UIView *headView;//头试图
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)UILabel *nameLabel;//姓名
@property(nonatomic,strong)UIImageView *sexImV;//性别
@property(nonatomic,strong)UILabel *uniserLabel;//学校
@property(nonatomic,strong)UIButton *addAttionBtn;//加关注
@property(nonatomic,strong)UIView *viewBgDesc;//文字详情view
@property(nonatomic,strong)UILabel *labelDesc;
@property(nonatomic,strong)UIButton *praiseButton;
//大图
@property(nonatomic,strong)UIImageView *bigImage;
@property (strong, nonatomic) NSMutableArray *photoNameList;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *jason;
@property(nonatomic,strong)NSDictionary *commentJason;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSDictionary *attenJason;
@property(nonatomic,strong)NSDictionary *praiseJason;
@property(nonatomic,strong)NSDictionary *praiseListJason;
@property(nonatomic,strong) NSDictionary *showdic;
@property(nonatomic,strong)NSMutableArray *sourceArray;
@property (nonatomic, assign) BOOL flag;
@property(nonatomic,strong) NSString *bigString;

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title= @"详情";
    NSLog(@"uuid详情%@",self.uuid);
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    _kTitleArrays = [[NSMutableArray alloc]init];
    self.photoNameList = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestDatatable:) name:@"requestTable" object:nil];
    self.flag = YES;
  
    //请求数据
    [self requestData];
    //
    [self requestTable];
    
    [self _initTableView];
    
    [self _initHeadView];
    
    [self _initLabel];
    
    [self _initComment];
    
    [self _initViewBgDesc];
    
}
- (void)requestDatatable:(NSNotification*)notification
{
    [self requestTable];
}

-(void)requestTable
{
    NSString *url1 = @"v1/comment";
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/comment/%@/comments",uS,_pinglun];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"评论%@",responseObject);
        self.commentJason =responseObject;
        NSLog(@"评论 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2)
        {
            self.data = [[NSMutableArray alloc]init];
            NSArray *commontArry = [responseObject objectForKey:@"commonts"];
            for (NSDictionary *dict in commontArry) {
                
                ShowCommentModel *commontModel = [[ShowCommentModel alloc]initContentWithDic:dict];
                
                CommentLayFrame *myFrame = [[CommentLayFrame alloc]init];
                myFrame.showCommentModel = commontModel;
                [self.data addObject:myFrame];
                
                
            }
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"评论错误 %ld",(long)[operation.response statusCode]);
        self.commentJason = operation.responseObject;
        NSLog(@"登录%@", self.commentJason);
        [MBProgressHUD showError:[self.commentJason objectForKey:@"info"]];
        
    }];
    
    
}

-(void)requestData
{
    
    NSString *url1 = @"v1/show";
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/%@",uS,self.uuid];
    NSLog(@"详情拼接之后%@",urlStr);
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"详情%@",responseObject);
        self.jason = responseObject;
        NSLog(@"详情 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2)
        {
            
            NSDictionary *showdic = [responseObject objectForKey:@"show"];
            self.showdic = showdic;
            //内容
            self.userUuid = [showdic objectForKey:@"userUuid"];
            //评论
            _pinglun = [showdic objectForKey:@"uuid"];
            _attenuuid = [[showdic objectForKey:@"user"]objectForKey:@"uuid"];
            [self _initTableView];
            [self _initHeadView];
              [self _initComment];
            [self _initViewBgDesc];
            [self requestTable];
            self.labelDesc.text = [showdic objectForKey:@"content"];
            self.labelDesc.backgroundColor =[UIColor clearColor];
            
            
            CGSize size;
            NSDictionary *dicrary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
            size =  [self.labelDesc.text boundingRectWithSize:CGSizeMake(self.labelDesc.frame.size.width, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dicrary context:nil].size;
            float f;
            f=size.height;
            
            self.labelDesc.numberOfLines = 0;
            self.labelDesc.frame = CGRectMake(10, 5, YTHScreenWidth-20, size.height);
            //            [self.labelDesc sizeToFit];
            //self.viewBgDesc.backgroundColor = [UIColor orangeColor];
            
            
            //是否关注
            if (!IsNilOrNull([[showdic objectForKey:@"user"]objectForKey:@"userRelStatus"])) {
                NSString *userRelStatus=[[showdic objectForKey:@"user"]objectForKey:@"userRelStatus"];
                if ([userRelStatus isEqualToString:@"0"]) {
                    
                    [self.addAttionBtn setImage:[UIImage imageNamed:@"attention_add"] forState:UIControlStateNormal];
                    
                }else if ([userRelStatus isEqualToString:@"1"])
                {
    
                    [self.addAttionBtn setImage:[UIImage imageNamed:@"attention_yet"] forState:UIControlStateNormal];
                }else if ([userRelStatus isEqualToString:@"2"])
                {
                    [self.addAttionBtn setImage:[UIImage imageNamed:@"attention_together"] forState:UIControlStateNormal];
                    
                    
                }
            }else{
                //[self.addAttionBtn removeFromSuperview];
                self.addAttionBtn.hidden = NO;
            }
            
            
            self.praiseuuid = [showdic objectForKey:@"uuid"];
            //图片
            NSArray *photosUrlArr = [[NSString stringWithFormat:@"%@",[showdic objectForKey:@"photoUrl"]] componentsSeparatedByString:@","];
            
            for (NSString *photoUrl in photosUrlArr) {
                [self.photoNameList addObject:photoUrl];
            }
            
            [self.bigImage sd_setImageWithURL:[NSURL URLWithString:[self.photoNameList objectAtIndex:0]]];
            _bigString =[self.photoNameList objectAtIndex:0];
            self.bigImage.userInteractionEnabled = YES;
            UITapGestureRecognizer  * faceTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alertFace:)];
            faceTapGesture.numberOfTapsRequired = 1;
            [self.bigImage addGestureRecognizer:faceTapGesture];
            
            
            
            if (self.photoNameList.count>1) {
                [self.photoNameList removeObjectAtIndex:0];
                [self _initCollectionView];
                _headView.frame = CGRectMake(0, 0, YTHScreenWidth, 400);
                _viewBgDesc.frame = CGRectMake(0, CGRectGetMaxY(_kPhotoCollectionView.frame), YTHScreenWidth, size.height+10);
                _headView.frame = CGRectMake(0, 0, YTHScreenWidth, 400+f+10);
                
                _tableView.tableHeaderView = _headView;
                
                
            }
            //标签
            NSArray *labellid=[showdic objectForKey:@"labels"];
            
            for (NSDictionary *labelDict in labellid) {
                NSString *labelArry = [labelDict objectForKey:@"name"];
                [_kTitleArrays addObject:labelArry];
            }
            [self _initLabel];
            
            if (_kTitleArrays.count>0) {
                _headView.frame = CGRectMake(0, 0, YTHScreenWidth, 400+f+50);
                
                _tableView.tableHeaderView = _headView;
            }
            
            //姓名
            _nameLabel.text=[[showdic objectForKey:@"user"]objectForKey:@"name"];
            CGSize sizeName;

            sizeName =  [_nameLabel.text boundingRectWithSize:CGSizeMake(YTHScreenWidth-150, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dicrary context:nil].size;
            _nameLabel.frame = CGRectMake(YTHAdaptation(60), YTHAdaptation(10), sizeName.width, sizeName.height);
            self.sexImV.frame =CGRectMake(CGRectGetMaxX(_nameLabel.frame)+3, YTHAdaptation(10),YTHAdaptation(15), YTHAdaptation(15));
            
            
            
            //大学
            if (!IsNilOrNull([[showdic objectForKey:@"user"]objectForKey:@"universityName"])) {
                _uniserLabel.text = [[showdic objectForKey:@"user"]objectForKey:@"universityName"];
            }
            //性别
            NSString *sexurl = [[showdic objectForKey:@"user"] objectForKey:@"sex"];
            if ([sexurl isEqualToString:@"0"]) {
                self.sexImV.image = [UIImage imageNamed:@"sex_male"];
            }else if ([sexurl isEqualToString:@"1"])
            {
                  self.sexImV.image = [UIImage imageNamed:@"sex_female"];
            }
        
            
            //头像
            self.urlString = [[showdic objectForKey:@"user"]objectForKey:@"avatar"];
            NSLog(@"头像%@",self.urlString);
            
            if (!IsNilOrNull([[showdic objectForKey:@"user"]objectForKey:@"avatar"])&&!self.urlString.length==0) {
                [self.headImgV sd_setImageWithURL:[NSURL URLWithString:self.urlString]];
                
            }else{
                if ([sexurl isEqualToString:@"0"]) {
                    self.headImgV.image =  [UIImage imageNamed:@"female"];
                }else if ([sexurl isEqualToString:@"1"]){
                    self.headImgV.image =  [UIImage imageNamed:@"male"];
                }
            }
            
        }
        [self.tableView reloadData];
        [_kPhotoCollectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"详情错误 %ld",(long)[operation.response statusCode]);
        self.jason = operation.responseObject;
        NSLog(@"登录%@", self.jason);
        [MBProgressHUD showError:[self.jason objectForKey:@"info"]];
    }];
    
    
}
#pragma mark-底下评论
-(void)_initComment
{
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, YTHScreenHeight-YTHAdaptation(46), YTHScreenWidth,YTHAdaptation(46))];
    [self.view addSubview:commentView];
    commentView.backgroundColor = [UIColor whiteColor];
    
    UIButton *praiseButton = [[UIButton alloc]initWithFrame:CGRectMake(YTHAdaptation(30), YTHAdaptation(10), YTHAdaptation(18),YTHAdaptation(18) )];
    [praiseButton setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
    praiseButton.tag = 10;
    [praiseButton addTarget:self action:@selector(buttonCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.praiseButton = praiseButton;
    [commentView addSubview:praiseButton];
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(YTHScreenWidth/2, 0, YTHScreenWidth/2, YTHAdaptation(46))];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commentBtn.tag = 20;
    [commentBtn addTarget:self action:@selector(buttonCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:commentBtn];
    
    
}
#pragma mark - 点击评论-赞
-(void)buttonCommentBtn:(UIButton *)btn
{
    if(btn.tag==10){
        NSLog(@"评论/赞");
        btn.selected = !btn.selected;
        if (btn.selected==YES) {
            NSString *uS = Url;
            
            NSString *ueltext = [NSString stringWithFormat:@"v1/show/%@/praise", self.praiseuuid];
            NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
            NSLog(@"登录密码=%@",myDelegate.accessToken);
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
            [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/%@/praise",uS, self.praiseuuid];
            NSLog(@"赞拼接之后%@",urlStr);
            [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"赞%@",responseObject);
                self.praiseJason = responseObject;
                NSLog(@"赞 %ld",(long)[operation.response statusCode]);
                if ([operation.response statusCode]/100==2)
                {
                    [self.praiseButton setImage:[UIImage imageNamed:@"icon_zan_red"] forState:UIControlStateNormal];
                    
                    
                    
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"赞 %ld",(long)[operation.response statusCode]);
                self.praiseJason = operation.responseObject;
                NSLog(@"赞%@", self.praiseJason);
                [MBProgressHUD showError:[self.praiseJason objectForKey:@"info"]];
                
                
            }];
            
            
            
            
}else if(btn.tag==20){
            
            
            
            NSString *uS = Url;
            
            NSString *ueltext = [NSString stringWithFormat:@"v1/show/%@/praise", self.praiseuuid];
            NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
            NSLog(@"登录密码=%@",myDelegate.accessToken);
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
            [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/%@/praise",uS, self.praiseuuid];
            NSLog(@"赞拼接之后%@",urlStr);
            
            [manager DELETE:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"赞%@",responseObject);
                self.praiseJason = responseObject;
                NSLog(@"赞 %ld",(long)[operation.response statusCode]);
                if ([operation.response statusCode]/100==2)
                {
                    
                    [self.praiseButton setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
                    
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"赞 %ld",(long)[operation.response statusCode]);
                self.praiseJason = operation.responseObject;
                NSLog(@"赞%@", self.praiseJason);
                [MBProgressHUD showError:[self.praiseJason objectForKey:@"info"]];
                
                
            }];
            
            
            
            
        }
        
    }else if (btn.tag==20)
    {
        CommentViewController *commentVC = [[CommentViewController alloc]init];
        commentVC.uuid = self.uuid;
        commentVC.userUuid = self.userUuid;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
    
}
-(void)_initHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 400)];
    headView.backgroundColor = [UIColor whiteColor];
    self.headView = headView;
    [self.tableView.tableHeaderView addSubview:self.headView];
    //  headView.backgroundColor = [UIColor blueColor];
    // self.tableView.tableHeaderView = headView;
    
    //头像
    UIImageView *headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(YTHAdaptation(10),YTHAdaptation(15),YTHAdaptation(40),YTHAdaptation(40))];
    [headImgV.layer setMasksToBounds:YES];
    [headImgV.layer setCornerRadius:YTHAdaptation(20)];
    headImgV.layer.borderColor = [UIColor whiteColor].CGColor;
    headImgV.layer.borderWidth = 1;
    self.headImgV = headImgV;
    [self.headView addSubview:headImgV];
    //名字
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(YTHAdaptation(60), YTHAdaptation(10), YTHAdaptation(50),YTHAdaptation(20))];
    nameLabel.text = @"顾梦慈";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = YTHColor(91, 91, 91);
   // nameLabel.backgroundColor = [UIColor yellowColor];
    self.nameLabel = nameLabel;
    [self.headView addSubview:nameLabel];
    //性别
    UIImageView *sexImV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), YTHAdaptation(15),YTHAdaptation(15), YTHAdaptation(15))];
    sexImV.image = [UIImage imageNamed:@"sex_female"];
    self.sexImV = sexImV;
    [self.headView addSubview:sexImV];
    //达人
//    UIImageView *expertImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sexImV.frame)+YTHAdaptation(5), YTHAdaptation(15), YTHAdaptation(40), YTHAdaptation(14))];
//    expertImage.image = [UIImage imageNamed:@"tarento"];
//    [self.headView addSubview:expertImage];
//    //达人名字
//    UILabel *expertLabel = [[UILabel alloc]initWithFrame:CGRectMake(YTHAdaptation(10), 0, YTHAdaptation(35), YTHAdaptation(14))];
//    expertLabel.text = @"模特";
//    expertLabel.font = [UIFont systemFontOfSize:12];
//    expertLabel.textColor = [UIColor blackColor];
//    [expertImage addSubview:expertLabel];
    //学校
    UILabel *uniserLabel = [[UILabel alloc]initWithFrame:CGRectMake(YTHAdaptation(60), YTHAdaptation(40), YTHAdaptation(200), YTHAdaptation(30))];
    uniserLabel.text = @"";
    uniserLabel.font = [UIFont systemFontOfSize:12];
    uniserLabel.textColor =YTHColor(197, 197, 197);
    self.uniserLabel=uniserLabel;
    [self.headView addSubview:uniserLabel];
    UIButton *addAttionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAttionBtn.frame = CGRectMake(YTHScreenWidth-YTHAdaptation(59),YTHAdaptation(30),YTHAdaptation(49), YTHAdaptation(20));
    
    [addAttionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    addAttionBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    //    [addAttionBtn.layer setMasksToBounds:YES];
    //    [addAttionBtn.layer setCornerRadius:YTHAdaptation(4.5)];
    //    addAttionBtn.layer.borderColor = [UIColor blueColor].CGColor;
    //    addAttionBtn.layer.borderWidth = 1;
    [addAttionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    self.addAttionBtn = addAttionBtn;
    [self.headView addSubview:addAttionBtn];
    //大图
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(YTHAdaptation(10), CGRectGetMaxY(uniserLabel.frame)+YTHAdaptation(10), YTHScreenWidth-YTHAdaptation(20), YTHAdaptation(175))];
    self.bigImage = bigImage;
    [self.headView addSubview:bigImage];
    //    self.photoNameList = [[NSMutableArray alloc] initWithObjects:@"0.tiff",@"1.tiff",@"2.tiff",@"3.tiff",@"4.tiff",nil];
}
#pragma mark - 小图
-(void)_initCollectionView
{
    //小图
    
    _kPhotoCollectionViewJJ = (YTHScreenWidth-20-83*4)/3.0f;
    _kPhotoCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _kPhotoCollectionViewFlowLayout.sectionInset =  UIEdgeInsetsMake(8, 10, 8, 10);
    _kPhotoCollectionViewFlowLayout.minimumInteritemSpacing = 0;
    _kPhotoCollectionViewFlowLayout.minimumLineSpacing = 10;
    _kPhotoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bigImage.frame)+10, YTHScreenWidth, 99) collectionViewLayout:_kPhotoCollectionViewFlowLayout];
    _kPhotoCollectionView.delegate = self;
    _kPhotoCollectionView.dataSource = self;
    _kPhotoCollectionView.bounces = NO;
    _kPhotoCollectionView.backgroundColor = [UIColor whiteColor];
    [_kPhotoCollectionView
     registerClass:[kSuggessPhotoCollectionViewCell class]
     forCellWithReuseIdentifier:@"kSuggessPhotoCollectionViewCellId"];
    
    [self.headView addSubview:_kPhotoCollectionView];
    
    [_kPhotoCollectionView reloadData];
    
}
#pragma mark-发布文字
-(void)_initViewBgDesc
{
    UIView *viewBgDesc = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bigImage.frame)+10, YTHScreenWidth, 25)];
    
    // viewBgDesc.backgroundColor = [UIColor whiteColor];
    self.viewBgDesc = viewBgDesc;
    [self.view addSubview:viewBgDesc];
    UILabel *labelDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, YTHScreenWidth-20, 25)];
    
    labelDesc.textColor = [UIColor blackColor];
    labelDesc.numberOfLines = 0;
    labelDesc.font = [UIFont systemFontOfSize:14];
    [viewBgDesc addSubview:labelDesc];
    self.labelDesc = labelDesc;
    [self.headView addSubview:viewBgDesc];
    
    
}

#pragma mark-标签
-(void)_initLabel
{
    //    _kTitleView = [[UIScrollView alloc]init];
    //    if (self.photoNameList.count<1) {
    //        _kTitleView.frame =CGRectMake(10, CGRectGetMaxY(self.viewBgDesc.frame)+10, YTHScreenWidth-20, 44);
    //        self.headView.frame = CGRectMake(0, 0, YTHScreenWidth, 380);
    //        [self.tableView reloadData];
    //    }else{
    //        _kTitleView.frame =CGRectMake(10, CGRectGetMaxY(_kPhotoCollectionView.frame)+10, YTHScreenWidth-20, 44);
    //        self.headView.frame = CGRectMake(0, 0, YTHScreenWidth, 350+99);
    //        [self.tableView reloadData];
    //    }
    //    _kTitleView.backgroundColor = [UIColor redColor];
    //_kTitleView.backgroundColor = [UIColor yellowColor];
    _kMarkRect = CGRectMake(0,0,0,0);
    [self.headView addSubview:_kTitleView];
    for (NSString *title in _kTitleArrays) {
        [self _addTitleBtn:title andAdd:NO];
    }
    
}
#pragma mark - uitableview
-(void)_initTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, YTHAdaptation(64), YTHScreenWidth, YTHScreenHeight-115)style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    tableView.tableHeaderView = self.headView;
    [self.view addSubview:tableView];
    
    
}
#pragma mark-关注
- (void)attention:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        NSString *uS = Url;
        
        NSString *ueltext = [NSString stringWithFormat:@"v1/user/%@/follow",_attenuuid];
        NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
        NSLog(@"登录密码=%@",myDelegate.accessToken);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
        [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@/follow",uS,_attenuuid];
        NSLog(@"关注拼接之后%@",urlStr);
        //用户id 传过去
        [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"关注%@",responseObject);
            self.attenJason = responseObject;
            NSLog(@"关注 %ld",(long)[operation.response statusCode]);
            if ([operation.response statusCode]/100==2)
            {
                [self.addAttionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"关注 %ld",(long)[operation.response statusCode]);
            self.attenJason = operation.responseObject;
            NSLog(@"关注%@", self.attenJason);
            [MBProgressHUD showError:[self.attenJason objectForKey:@"info"]];
            
        }];
        
        
    }else{
        NSString *uS = Url;
        NSString *ueltext = [NSString stringWithFormat:@"v1/user/%@/follow",_attenuuid];
        NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
        NSLog(@"登录密码=%@",myDelegate.accessToken);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
        [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@/follow",uS,_attenuuid];
        
        
        
        [manager DELETE:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"取消关注%@",responseObject);
            self.attenJason = responseObject;
            NSLog(@"取消关注 %ld",(long)[operation.response statusCode]);
            if ([operation.response statusCode]/100==2)
            {
                [self.addAttionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"取消关注 %ld",(long)[operation.response statusCode]);
            self.attenJason = operation.responseObject;
            NSLog(@"取消关注%@", self.attenJason);
            [MBProgressHUD showError:[self.attenJason objectForKey:@"info"]];
            
        }];
        
    }
    
    
}
#pragma mark tableView的代理和数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            if (self.flag) {
                
                return self.data.count;
            }else{
                
                return _sourceArray.count;
            }
        }
            break;
        default:
            return 0;
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    switch (indexPath.section) {
        case 0:
        {
           praisecell = [[PraiseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
            
            [praisecell.buttoncomment addTarget:self action:@selector(buttonComment:) forControlEvents:UIControlEventTouchUpInside];
             [praisecell.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//            UIButton *buttoncomment = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
//            UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
//            
//            
//            commentLabel.text = [NSString stringWithFormat:@"评论%@", [self.showdic objectForKey:@"commitCount"]];
//            commentLabel.font = [UIFont systemFontOfSize:14];
//            commentLabel.textAlignment = NSTextAlignmentCenter;
//            commentLabel.textColor = [UIColor grayColor];
//            [buttoncomment addSubview:commentLabel];
//            [buttoncomment addTarget:self action:@selector(buttonComment:) forControlEvents:UIControlEventTouchUpInside];
//            arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 100, 2)];
//            arrowImg.backgroundColor = [UIColor redColor];
//            arrowImg.hidden = NO;
//            [buttoncomment addSubview:arrowImg];
//            [cell.contentView addSubview:buttoncomment];
//            
//            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(110, 0, 100, 44)];
//            
//            UILabel *praiseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
//            
//            praiseLabel.text =[NSString stringWithFormat:@"赞%@",[self.showdic objectForKey:@"praiseCount"]];
//            praiseLabel.font = [UIFont systemFontOfSize:14];
//            praiseLabel.textColor = [UIColor grayColor];
//            [button addSubview:praiseLabel];
//            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//            praiseImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 100, 2)];
//            praiseLabel.textAlignment = NSTextAlignmentCenter;
//            praiseImg.backgroundColor = [UIColor redColor];
//            praiseImg.hidden = YES;
//            [button addSubview:praiseImg];
//            [cell.contentView addSubview:button];
            return praisecell;
        }
            break;
        case 1:
        {
            if (self.flag) {
                static NSString *indetify = @"showcommentcell";
                ShowTableViewCell *showTableCell = [tableView dequeueReusableCellWithIdentifier:indetify];
                if (showTableCell==nil) {
                    showTableCell=[[ShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetify];
                }
                showTableCell.myLayoutFrame = self.data[indexPath.row];
                //            showTableCell.backgroundColor = [UIColor yellowColor];
                return showTableCell;
            }else{
               
                static NSString *identify = @"kIdentifier";
                MyFanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
                if (cell == nil) {
                    cell = [[MyFanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                }
                cell.flag = self.flag;
                cell.showModel = _sourceArray[indexPath.row];
                
                
                return cell;
                
            }
            
        }
            break;
    }
    return cell;
    
}
#pragma mark -赞列表,评论列表
-(void)buttonAction:(UIButton *)btn
{
    
   
    self.flag = NO;
    //赞列表
    NSLog(@"赞列表");
    NSString *userUuid =_pinglun;
    NSString *url1 = [NSString stringWithFormat:@"v1/show/%@/praises",userUuid];
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/%@/praises",uS,_pinglun];
    NSLog(@"赞列表拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" 赞列表%ld",(long)[operation.response statusCode]);
        _sourceArray = [[NSMutableArray alloc]init];
        
        
        if ([operation.response statusCode]/100==2)
        {
            NSLog(@"赞列表%@",responseObject);
            NSArray *usersArray = [responseObject objectForKey:@"users"];
            for (NSDictionary *dict in usersArray) {
                ShowDetailModel *model = [[ShowDetailModel alloc]initContentWithDic:dict];
                [self.sourceArray addObject:model];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"赞列表错误 %ld",(long)[operation.response statusCode]);
        _praiseListJason = operation.responseObject;
        [MBProgressHUD showError:[_praiseListJason objectForKey:@"info"]];
        
    }];
    [UIView animateWithDuration:0.15 animations:^{
        praisecell.arrowImg.frame = CGRectMake(100, 44, 100, 2);
    }];
    
}
-(void)buttonComment:(UIButton *)btn
{
    
   
    
    self.flag = YES;
    [self requestTable];
    [UIView animateWithDuration:0.15 animations:^{
        praisecell.arrowImg.frame = CGRectMake(0, 44, 100, 2);
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
        case 1:
        {
            if (self.flag) {
                CommentLayFrame *weiboF = self.data[indexPath.row];
                return weiboF.cellHeight;
            }
            return 100;
        }
            
            break;
        default:
            return 0;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
        AnswerViewController *answerVC = [[AnswerViewController alloc]init];
        
        NSInteger row = [indexPath row];
        
        CommentLayFrame *layoutFrame = [self.data objectAtIndex:row];
        
        ShowCommentModel *model = layoutFrame.showCommentModel
        ;
        
        answerVC.nameTitle = [NSString stringWithFormat:@"%@",[model.createUser objectForKey:@"name"]];
        answerVC.uuid = [NSString stringWithFormat:@"%@",[model.createUser objectForKey:@"uuid"]];
        answerVC.authorUuid = [NSString stringWithFormat:@"%@",model.authorUuid];
        answerVC.pinglun = self.pinglun;
        [self.navigationController pushViewController:answerVC animated:YES];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
        
    }else
    {
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)_addTitleBtn:(NSString *)title andAdd:(BOOL)add{
    if (!_kTitleView) {
        _kTitleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.viewBgDesc.frame) , YTHScreenWidth, 44)];
        _kTitleView.backgroundColor = [UIColor yellowColor];
        //_kTitleView.backgroundColor = YTHBaseVCBackgroudColor;
        _headView.frame = CGRectMake(0, 0, YTHScreenWidth, CGRectGetMaxY(self.viewBgDesc.frame));
        
        _tableView.tableHeaderView = _headView;
        [self.headView addSubview:_kTitleView];
    }
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGFloat length = [title boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    CGFloat xxxx = _kMarkRect.origin.x + _kMarkRect.size.width + length + 30;
    if (_kMarkRect.origin.y == 0) {
        _kMarkRect.origin.y = 10;
    }
    if (xxxx>_kTitleView.frame.size.width-10) {
        _kMarkRect.origin.y += 37;
        _kMarkRect.origin.x = 0;
        _kMarkRect.size.width = 0;
    }
    UIView *kMarkView = [[UIView alloc]initWithFrame:CGRectMake(_kMarkRect.origin.x + _kMarkRect.size.width + 10, _kMarkRect.origin.y, length+20, 27)];
    [_kTitleView addSubview:kMarkView];
    _kMarkRect = kMarkView.frame;
    UILabel *kTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, length+20, 27)];
    kTitleLabel.backgroundColor = YTHColor(169, 214, 255);
    kTitleLabel.layer.cornerRadius = 4;
    kTitleLabel.layer.masksToBounds = YES;
    kTitleLabel.textAlignment = NSTextAlignmentCenter;
    kTitleLabel.font = [UIFont systemFontOfSize:12];
    kTitleLabel.textColor = [UIColor blackColor];
    kTitleLabel.text = title;
    [kMarkView addSubview:kTitleLabel];
    UIButton *kDeleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    kDeleteButton.frame = CGRectMake(CGRectGetMaxX(kMarkView.frame)-10, kMarkView.frame.origin.y-10, 20, 20);
    //    [kDeleteButton setTitle:@"X" forState:UIControlStateNormal];
    [kDeleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    //    [kDeleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [kDeleteButton addTarget:self action:@selector(btnDeleteClick:)];
    [kDeleteButton addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [_kTitleView addSubview:kDeleteButton];
    if (add) {
        [_kTitleArrays addObject:title];
    }
    kDeleteButton.tag = [_kTitleArrays indexOfObject:title] + 999;
    _kTitleView.contentSize = CGSizeMake(YTHScreenWidth, CGRectGetMaxY(kMarkView.frame)+10);
    // self.viewLabel.height =kMarkView.height;
    float h;
    NSLog(@"frame标签%f",kMarkView.frame.origin.y);
    
}

#pragma mark -collection代理
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(83, 83);
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoNameList.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame = self.view.bounds;
    UIImageView *aimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [aimg sd_setImageWithURL:self.photoNameList[indexPath.row] placeholderImage:nil];
    [self magnifyingPhoto:aimg.image];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    kSuggessPhotoCollectionViewCell *kPhotoCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kSuggessPhotoCollectionViewCellId"  forIndexPath:indexPath];
    kPhotoCollectionViewCell.kSuggessPhotoCollectionViewCellDelegate = self;
    if (indexPath.row==self.photoNameList.count) {
        [kPhotoCollectionViewCell setPhotoImage:self.photoNameList[indexPath.row] andDeleteBtnHidden:NO];
    }else{
        [kPhotoCollectionViewCell setPhotoImage:self.photoNameList[indexPath.row] andDeleteBtnHidden:YES];
    }
    return kPhotoCollectionViewCell;
}
-(void)magnifyingPhoto:(UIImage *)image{
    _kVIPhotoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andImage:image];
    _kVIPhotoView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [_kVIPhotoView setContentMode:UIViewContentModeScaleAspectFit];
    _kVIPhotoView.alpha = 0;
    [self.view addSubview:_kVIPhotoView];
    [UIView animateWithDuration:0.3 animations:^{
        _kVIPhotoView.alpha = 1;
    } completion:^(BOOL finished) {
        //创建一个点击手势
        UITapGestureRecognizer*kVIPhotoViewTap=[[UITapGestureRecognizer alloc]init];
        //给手势添加事件处理程序
        [kVIPhotoViewTap addTarget:self action:@selector(closeVIPhotoView)];
        //指定点击几下触发响应
        kVIPhotoViewTap.numberOfTapsRequired=1;
        //指定需要几个手指点击
        kVIPhotoViewTap.numberOfTouchesRequired=1;
        //给self.view 添加点击手势
        [_kVIPhotoView addGestureRecognizer:kVIPhotoViewTap];
    }];
}
-(void)closeVIPhotoView{
    [_kVIPhotoView removeFromSuperview];
    _kVIPhotoView = nil;
}
- (void)alertFace:(UITapGestureRecognizer *)gesture {
    CGRect frame = self.view.bounds;
    UIImageView *aimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [aimg sd_setImageWithURL:_bigString placeholderImage:nil];
    [self magnifyingPhoto:aimg.image];
    
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