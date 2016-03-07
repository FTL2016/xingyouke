//
//  SettingViewController.m
//  Starucan
//
//  Created by vgool on 16/1/29.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountSetViewController.h"
#import "FeedBackViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *myDelegate;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self _initTableView];
    
}
-(void)_initTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight)style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];

   

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (0==section) {
        return 1;
    }
    
    if (1==section) {
        return 2;
    }
    if (2==section) {
        return 1;
    }
    
    else{
    return 1;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        cell.textLabel.text = @"账号设置";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
   
    if (1==indexPath.section &&indexPath.row==0) {
        cell.textLabel.text = @"清理缓存";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (1==indexPath.section &&indexPath.row==1)
    {
        cell.textLabel.text = @"意见反馈";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (2==indexPath.section &&indexPath.row==0) {
        cell.textLabel.text = @"关于星优客";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    if (3==indexPath.section) {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        AccountSetViewController *accountVC = [[AccountSetViewController alloc]init];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    if (indexPath.section==1&&indexPath.row==1) {
        FeedBackViewController *feedVC = [[FeedBackViewController alloc]init];
         self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:feedVC animated:YES];
    }
    if (3==indexPath.section) {
        myDelegate.userInfo = [NSMutableDictionary dictionary];
        LoginViewController *loginV = [[LoginViewController alloc]init];
      
        [self.navigationController pushViewController:loginV animated:YES];
        
        
        
        
        
               NSLog(@"退出登录");
    }
}
//section底部间距
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
