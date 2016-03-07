//
//  NickNameViewController.m
//  Starucan
//
//  Created by vgool on 16/1/27.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "NickNameViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
@interface NickNameViewController ()
{
    AppDelegate *myDelegate;

}
@property (nonatomic, strong) UITextField *nickField;

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }

    // Do any additional setup after loading the view.
    self.title = @"我的昵称";
    self.view.backgroundColor = YTHBaseVCBackgroudColor;
    [self _initCreat];
    [self _loadNavigationViews];
}
- (void)_loadNavigationViews
{
    // 左边的取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, 0, 30, 30);
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    //发送按钮
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    // sendButton.imgName = @"button_icon_ok.png";
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    
}
-(void)clickCode
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)sendAction
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"name"] = _nickField.text;
    NSString *urlUpdate = @"v1/user/";
    NSString *url1 = [NSString stringWithFormat:@"%@%@",urlUpdate,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"URL11=%@",url1);
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    NSLog(@"加密后密码%@",text);
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //请求头
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/user/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager PUT:urlStr parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"更新信息%@",responseObject);
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2)
        {
            
            myDelegate.userInfo = [responseObject objectForKey:@"userInfo"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"完成error code %ld",(long)[operation.response statusCode]);
    }];
    

    
}
-(void)_initCreat
{
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 10, YTHScreenWidth, 44)];
    viewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBg];
    _nickField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 44)];
    _nickField.text = self.nickName;
    _nickField.font = [UIFont systemFontOfSize:14];
    _nickField.textColor = [UIColor blackColor];
    [_nickField becomeFirstResponder];
    
    UITextPosition* start = [_nickField positionFromPosition:0 inDirection:UITextLayoutDirectionLeft offset:0];
    if (start) {
        [_nickField setSelectedTextRange:[_nickField textRangeFromPosition:start toPosition:start]];
    }
    [viewBg addSubview:_nickField];
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
