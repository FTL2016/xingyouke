//
//  PasswordSetViewController.m
//  Starucan
//
//  Created by vgool on 16/1/29.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "PasswordSetViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
#import "MBProgressHUD+NJ.h"
#import <CommonCrypto/CommonDigest.h>

@interface PasswordSetViewController ()<UITextFieldDelegate>
{
    AppDelegate *myDelegate;
    
}
@property (nonatomic, weak) UITextField *accountTF;
@property (nonatomic, weak) UITextField *passwordTF;
@property (nonatomic, weak) UIButton *loginBtn;

@end

@implementation PasswordSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"密码设置";
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    [self _loadNavigationViews];
    [self _initCreat];
    [self setAccountTextFied];
    [self setPasswordTextFied];
    [self setLoginButton];
    
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
-(void)_initCreat
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 30)];
    label.text = @"设置密码后，您可以使用手机号+密码来登录";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
}
#pragma mark - 设置帐号输入框
- (void)setAccountTextFied{
    UITextField *accountTF = [[UITextField alloc] initWithFrame:CGRectMake(16, 32, YTHScreenWidth-32, 40)];
    accountTF.delegate = self;
    accountTF.borderStyle = UITextBorderStyleNone;
    accountTF.backgroundColor = [UIColor whiteColor];
    accountTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [accountTF.layer setMasksToBounds:YES];
    [accountTF.layer setCornerRadius:4.5];
    accountTF.layer.borderWidth = 1;
    accountTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    accountTF.leftViewMode = UITextFieldViewModeAlways;
    //    [accountTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
    // passView.backgroundColor = [UIColor orangeColor];
    UIImageView *accountImv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 16, 16)];
    accountImv.image = [UIImage imageNamed:@"user"];
    [accountView addSubview:accountImv];
    
    [accountTF.leftView addSubview:accountView];
    accountTF.font = [UIFont systemFontOfSize:14];
    accountTF.placeholder = @"请设置密码";
    accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // accountTF.tag = YTHLoginTextFieldAccount;
    self.accountTF = accountTF;
    [self.view addSubview:accountTF];
}
#pragma mark - 设置密码输入框
- (void)setPasswordTextFied{
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.accountTF.frame)+20, YTHScreenWidth-32, 40)];
    passwordTF.delegate = self;
    passwordTF.borderStyle = UITextBorderStyleNone;
    passwordTF.backgroundColor = [UIColor whiteColor];
    passwordTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [passwordTF.layer setMasksToBounds:YES];
    [passwordTF.layer setCornerRadius:4.5];
    passwordTF.layer.borderWidth = 1;
    passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    //    [passwordTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    UIView *passView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
    // passView.backgroundColor = [UIColor orangeColor];
    UIImageView *passImv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 16, 16)];
    passImv.image = [UIImage imageNamed:@"key"];
    [passView addSubview:passImv];
    [passwordTF.leftView addSubview:passView];
    passwordTF.font = [UIFont systemFontOfSize:14];
    passwordTF.placeholder = @"请确认密码";
    passwordTF.secureTextEntry = YES;
    // passwordTF.tag = YTHLoginTextFieldPassword;
    passwordTF.returnKeyType = UIReturnKeyGo;
    //    UIButton *eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    eyeButton.frame = CGRectMake(YTHScreenWidth-30-30
    //                                 , CGRectGetMaxY(self.accountTF.frame)+30, 24,24 );
    //    [eyeButton setImage:[UIImage imageNamed:@"look_off"] forState:UIControlStateNormal];
    //    [eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:eyeButton];
    
    self.passwordTF = passwordTF;
    [self.view addSubview:passwordTF];
    //    [self.view insertSubview:self.passwordTF belowSubview:eyeButton];
}
#pragma mark - 设置登录按钮
- (void)setLoginButton{
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(16,CGRectGetMaxY(self.passwordTF.frame)+44, YTHScreenWidth-32, 40)];
    
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_tile"] forState:UIControlStateNormal];
    loginBtn.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn.layer setCornerRadius:4.5];
    loginBtn.layer.borderWidth = 1;
    
    [loginBtn setTitle:@"完成" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    // self.loginBtn.enabled = NO;
    [self.view addSubview:loginBtn];
}
- (void)clickLoginBtn:(id)sender
{
    if (![self.accountTF.text isEqualToString:self.passwordTF.text]){
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"password"] = [self md5:self.passwordTF.text];
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
            [MBProgressHUD showSuccess:@"设置成功"];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"完成error code %ld",(long)[operation.response statusCode]);
    }];
    
    
}
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
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
