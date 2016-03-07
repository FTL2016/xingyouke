//
//  SUCTabBarViewController.m
//  Starucan
//
//  Created by vgool on 16/2/9.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "SUCTabBarViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "WXNavigationController.h"
#import "ShowViewController.h"
#import "TalkViewController.h"
#import "XYTabBar.h"
#import "AppDelegate.h"
#import "LoginFirstViewController.h"
#import "TopicViewController.h"
#import "ShowPhotoViewController.h"
#import "LoginFirstViewController.h"
#import "ShowViewController.h"
#import "XZMPublishViewController.h"
@interface SUCTabBarViewController ()<XYTabBarDelegate,UITabBarControllerDelegate>
{
    AppDelegate *myDelegate;
}
@property (nonatomic,strong)UIView * viewGray;

@end

@implementation SUCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    self.delegate = self;
    // Do any additional setup after loading the view.
    HomeViewController*home = [[HomeViewController alloc] init];
    [self createChildVCWithVC:home Title:@"首页" Image:@"icon_home_show" SelectedImage:@"icon_home_show_fill"];
    
    TalkViewController *discover = [[TalkViewController alloc] init];
    
    [self createChildVCWithVC:discover Title:@"话题" Image:@"icon_home_topic" SelectedImage:@"icon_home_topic_fill"];
    
    NewsViewController *message = [[NewsViewController alloc] init];
    [self createChildVCWithVC:message Title:@"消息" Image:@"icon_home_message" SelectedImage:@"icon_home_message_fill"];
    
    MineViewController *profile = [[MineViewController alloc] init];
    [self createChildVCWithVC:profile Title:@"我的" Image:@"icon_home_myself" SelectedImage:@"icon_home_myself_fill"];
    
    XYTabBar *tabBar = [[XYTabBar alloc] init];
    tabBar.delegate = self;
    [[XYTabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self setValue:tabBar forKey:@"tabBar"];
    self.tabBar.translucent = NO;
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"tabbar_bg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:10]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUInteger count = self.tabBar.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.tabBar.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.tabBar.width / count;
        }
    }
}
-(void)createChildVCWithVC:(UIViewController *)childVC Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedimage
{
    //设置子控制器的文字
    // childVC.tabBarItem.title =title;
    // childVC.navigationItem.title =title;
    //等价于
    childVC.title = title;//同时设置tabbar和navigation的标题
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *selectedtextAttrs = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName] = YTHColor(114, 114, 114);
    selectedtextAttrs[NSForegroundColorAttributeName] = YTHColor(255, 69, 82);
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    //设置子控制器的图片
    childVC.tabBarItem.image =[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //这句话的意思是声明这张图片按照原始的样子显示出来，不要自动渲染成其他颜色
    
    //childVC.view.backgroundColor = RandomColor;
    
    //给子控制器包装导航控制器
    WXNavigationController *nav = [[WXNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

#pragma mark - tabbar代理方法
-(void)tabBarDidClickPlusButton:(XYTabBar *)tabBar
{
   
    XZMPublishViewController *showVC = [[XZMPublishViewController alloc]init];
    WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:showVC];
    [self presentViewController:nav animated:NO completion:nil];

}

-(void)buttonAction:(UIButton *)btn
{
    
    
    NSLog(@"dianji");
    
    
    if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])) {
        ShowViewController *showVC = [[ShowViewController alloc]init];
        WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:showVC];
        [self presentViewController:nav animated:NO completion:nil];

     //   [self.navigationController pushViewController:showVC animated:YES];
        return;
        
    }else{
       
        LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
        WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:loginVC];
       
        [self presentViewController:nav animated:YES completion:nil];

    }
    
}
-(void)buttonTitle:(UIButton *)btn
{
    NSLog(@"dianji");
    if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])) {
        TopicViewController *topicVC = [[TopicViewController alloc]init];
        
        WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:topicVC];
        [self presentViewController:nav animated:NO completion:nil];
       // [self.navigationController pushViewController:topicVC animated:YES];
        return;
        
    }else{
        LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
        WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:NO completion:nil];
        
       // [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}


-(void)takePhoto
{
    
}

-(void)takeFromAlbum
{
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
     
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        //还有再加一个账号判断
        if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])&&!myDelegate.account.length==0) {
            return YES;
        }else{
            LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
            WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
       
    }
      return YES;
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
