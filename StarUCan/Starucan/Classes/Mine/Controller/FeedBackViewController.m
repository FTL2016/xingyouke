//
//  FeedBackViewController.m
//  Starucan
//
//  Created by vgool on 16/1/29.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SuggessViewController.h"
#import "TestViewController.h"
@interface FeedBackViewController ()<UITextViewDelegate>
@property(retain,strong)UIScrollView *scrollview;
@property(retain,strong)UIView *viewbg;
@end
#define BWMWidth [[UIScreen mainScreen]bounds].size.width
#define BWMHeight [[UIScreen mainScreen] bounds].size.height
#define BWMDongTaiZhi(dongTaiZhi) (dongTaiZhi/320.0f)*[[UIScreen mainScreen]bounds].size.width
@implementation FeedBackViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btn_tile"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.tabBarController.tabBar.hidden=YES;
     [self _initCreat];
    [self _loadNavigationViews];
    self.view.backgroundColor=YTHBaseVCBackgroudColor;
}

// 是否是3.5英寸
#define threeInch ([UIScreen mainScreen].bounds.size.height == 480.0)
#define NaM MineColor(250, 90, 0)
- (void)_loadNavigationViews
{
    // 左边的取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, 0, 30, 30);
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickCode
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)_initCreat
{
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BWMWidth, BWMHeight)];
    if (threeInch) {
        self.scrollview.contentSize = CGSizeMake(BWMWidth,BWMHeight+150);
    }
    
    [self.view addSubview:self.scrollview];
    self.viewbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BWMWidth, YTHAdaptation(201))];
    self.viewbg.backgroundColor = YTHColor(255, 69, 82);
   // self.viewbg.backgroundColor =NaM;
    [self.scrollview addSubview:self.viewbg];
       UIImageView *lgImageV = [[UIImageView alloc]initWithFrame:CGRectMake((BWMWidth-YTHAdaptation(124))/2, (YTHAdaptation(201)-YTHAdaptation(124))/2,YTHAdaptation(124), YTHAdaptation(124))];
    lgImageV.image = [UIImage imageNamed:@"logo"];
    [self.viewbg addSubview:lgImageV];
    
    UIButton *suggestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    suggestButton.backgroundColor=[UIColor whiteColor];
    suggestButton.frame = CGRectMake(0, CGRectGetMaxY(self.viewbg.frame), BWMWidth/2-1,330/2);
    [suggestButton addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:suggestButton];
    //图
    UIImageView *imageButton1 = [[UIImageView alloc]initWithFrame:CGRectMake((suggestButton.frame.size.width-66)/2, 33, 132/2,132/2)];
    imageButton1.image = [UIImage imageNamed:@"iconsuggest"];
    //防止拉伸
    imageButton1.contentMode=UIViewContentModeScaleAspectFit;
    [suggestButton addSubview:imageButton1];
    //字
    [suggestButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    suggestButton.contentEdgeInsets = UIEdgeInsetsMake(73, 0, 0, 0);
    [suggestButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //字体
    suggestButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    UIButton *bugButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bugButton.backgroundColor=[UIColor whiteColor];
    bugButton.frame = CGRectMake(CGRectGetMaxX(suggestButton.frame)+1, CGRectGetMaxY(self.viewbg.frame), BWMWidth/2-1,330/2);
    [bugButton addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:bugButton];
    //图
    UIImageView *imageBug = [[UIImageView alloc]initWithFrame:CGRectMake((suggestButton.frame.size.width-66)/2, 33, 132/2,132/2)];
    imageBug.image = [UIImage imageNamed:@"iconmistake"];
    //防止拉伸
    imageBug.contentMode=UIViewContentModeScaleAspectFit;
    [bugButton addSubview:imageBug];
    //字
    [bugButton setTitle:@"错误报告" forState:UIControlStateNormal];
    bugButton.contentEdgeInsets = UIEdgeInsetsMake(73, 0, 0, 0);
    [bugButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //字体
    bugButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    
    UIView *viewJoin = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bugButton.frame)+16, BWMWidth, 108/2)];
    viewJoin.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:viewJoin];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(16, 20, 26/2, 32/2)];
    imgV.image = [UIImage imageNamed:@"icongroup"];
    imgV.contentMode=UIViewContentModeScaleAspectFit;
    [viewJoin addSubview:imgV];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+16, 20, 200, 15)];
    // label.backgroundColor = [UIColor yellowColor];
    label.text = @"加入官方测试群一起吐槽赢大奖";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    [viewJoin addSubview:label];
    
    
    
    UIButton *morerightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    morerightBtn.frame = CGRectMake(BWMWidth-32, 20, 16, 16);
    [morerightBtn setImage:[UIImage imageNamed:@"moreright"] forState:UIControlStateNormal];
    [morerightBtn addTarget:self action:@selector(buttonMore) forControlEvents:UIControlEventTouchUpInside];
    [viewJoin addSubview:morerightBtn];
    UITapGestureRecognizer* faceTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alertFace:)];
    faceTapGesture.numberOfTapsRequired = 1;
    [viewJoin addGestureRecognizer:faceTapGesture];
    
    
    
    
    
}
- (void)alertFace:(UITapGestureRecognizer *)gesture {
    TestViewController *suggestVC = [[TestViewController alloc]init];
    [self.navigationController pushViewController:suggestVC animated:YES];
}

//意见反馈
-(void)buttonAction1:(UIButton *)btn
{
    SuggessViewController *suggestVC = [[SuggessViewController alloc]init];
    
    suggestVC.typeId = [NSString stringWithFormat:@"%d",1];
    
    [self.navigationController pushViewController:suggestVC animated:YES];
}
-(void)buttonAction2:(UIButton *)btn
{
    SuggessViewController *suggestVC = [[SuggessViewController alloc]init];
    
    suggestVC.typeId = [NSString stringWithFormat:@"%d",2];
    [self.navigationController pushViewController:suggestVC animated:YES];
}
-(void)buttonMore
{
    TestViewController *suggestVC = [[TestViewController alloc]init];
    [self.navigationController pushViewController:suggestVC animated:YES];
    
    
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