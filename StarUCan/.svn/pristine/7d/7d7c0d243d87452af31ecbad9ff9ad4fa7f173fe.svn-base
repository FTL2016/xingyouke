//
//  AccountSetViewController.m
//  Starucan
//
//  Created by vgool on 16/1/29.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "AccountSetViewController.h"
#import "PasswordSetViewController.h"
#import "MobileBandViewController.h"
@interface AccountSetViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation AccountSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    self.title = @"账号设置";
    [self _loadNavigationViews];
    [self _initTableView];
}
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
-(void)_initTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight)style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (0==section) {
        return 1;
    }
    
    
        return 2;
    
   
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
        cell.textLabel.text = @"登录密码";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (1==indexPath.section && 0==indexPath.row) {
        cell.textLabel.text = @"手机绑定";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (1==indexPath.section && 1==indexPath.row) {
        cell.textLabel.text = @"微信绑定";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        PasswordSetViewController *passVC = [[PasswordSetViewController alloc]init];
        [self.navigationController pushViewController:passVC animated:YES];
    }if (indexPath.section==1&&indexPath.row==0) {
        MobileBandViewController *mobileVC = [[MobileBandViewController alloc]init];
        [self.navigationController pushViewController:mobileVC animated:YES];
            }
    if (indexPath.section==1&&indexPath.row==1) {
        [self alertTitle:nil message:@"是否解绑" delegate:self cancelBtn:@"取消" otherBtnName:@"确定"];
        
    }

}
#pragma mark - 提示框
- (UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:aDeleagte cancelButtonTitle:cancelName otherButtonTitles:otherbuttonName, nil];
    [alert show];
    alert.tag = 52;
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 52) {
            NSLog(@"确定");
           
        }
    }
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
