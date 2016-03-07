//
//  MobileBandViewController.m
//  Starucan
//
//  Created by vgool on 16/1/29.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MobileBandViewController.h"
#import "AppDelegate.h"
#import "NSData+AES256.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD+NJ.h"
@interface MobileBandViewController ()<UITextFieldDelegate>
{
    NSTimer *yanzhengmaTimer;
    int yanzhengmaIndex;
    AppDelegate *myDelegate;
}
@property (nonatomic, weak) UIButton *getBtn;
@property (nonatomic, weak) UITextField *authCodeTF;//验证码输入框
@property (nonatomic, weak) UITextField *phoneTF;
@property (nonatomic, weak)NSDictionary *jsonDict;
@property (nonatomic, weak) UIButton *loginBtn;


@end

@implementation MobileBandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    // Do any additional setup after loading the view.
    self.title =@"手机绑定";
    
    [self _initCreat];
    
    [self setPhoneTextFied];
    
    [self setauthCodeTextFied];
    
    [self setGetAuthcodeButton];
    
    [self setLoginButton];
    
}
-(void)_initCreat
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 30)];
    label.text = @"绑定手机能保证您的账号安全，快速登录以及找回秘密";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
}
#pragma mark - 设置手机号输入框
- (void)setPhoneTextFied{
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(16, 32, YTHScreenWidth-32, 40)];
    phoneTF.delegate = self;
    phoneTF.borderStyle = UITextBorderStyleNone;
    phoneTF.backgroundColor = [UIColor whiteColor];
    phoneTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [phoneTF.layer setMasksToBounds:YES];
    [phoneTF.layer setCornerRadius:4.5];
    phoneTF.layer.borderWidth = 1;
    phoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    phoneTF.leftViewMode = UITextFieldViewModeAlways;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"+86   ";
    lab.textColor = YTHColor(118, 118, 118);
    [phoneTF.leftView addSubview:lab];
    phoneTF.placeholder = @"请输入手机号";
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
   // [phoneTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF = phoneTF;
    [self.view addSubview:phoneTF];
}
#pragma mark - 请输入短信中的验证码
- (void)setauthCodeTextFied{
    UITextField *authCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.phoneTF.frame)+10, YTHScreenWidth-32, 40)];
    authCodeTF.delegate = self;
    authCodeTF.borderStyle = UITextBorderStyleNone;
    authCodeTF.backgroundColor = [UIColor whiteColor];
    authCodeTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [authCodeTF.layer setMasksToBounds:YES];
    [authCodeTF.layer setCornerRadius:4.5];
    authCodeTF.layer.borderWidth = 1;
    authCodeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
    authCodeTF.leftViewMode = UITextFieldViewModeAlways;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
    [authCodeTF.leftView addSubview:lab];
    authCodeTF.placeholder = @"请输入短信中的验证码";
    authCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    authCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
   // [authCodeTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.authCodeTF = authCodeTF;
    [self.view addSubview:authCodeTF];
}
#pragma mark - 设置获取验证码按钮
- (void)setGetAuthcodeButton{
    UIButton *getBtn = [[UIButton alloc]initWithFrame:CGRectMake(YTHScreenWidth-115, CGRectGetMaxY(self.phoneTF.frame)+10, 98, 40)];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getBtn.backgroundColor = [UIColor redColor];
    [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [getBtn addTarget:self action:@selector(getAuth:) forControlEvents:UIControlEventTouchUpInside];
    self.getBtn = getBtn;
    [self.view addSubview:getBtn];
}
-(void)getAuth:(UIButton *)btn
{
    if (![self isValidatePhone:self.phoneTF.text]) {
        [MBProgressHUD showError:@"手机号格式不正确"];
        return;
    }
    if (self.phoneTF.text.length != 11){
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    
    //获取验证码参数
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"mobile"] =self.phoneTF.text;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/base/authcode",url];
    
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.jsonDict = responseObject;
        NSLog(@"error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            [MBProgressHUD showSuccess:@"发送成功"];
            self.getBtn.enabled = NO;
            if (yanzhengmaTimer) {
                [yanzhengmaTimer invalidate];
                yanzhengmaTimer  = nil;
            }
            yanzhengmaIndex = 60;
            [self huoquyanzhengmaBtLoad];
            yanzhengmaIndex--;
            yanzhengmaTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(huoquyanzhengmaBtLoad) userInfo:nil repeats:YES];
        }else{
            
            self.getBtn.enabled = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:[ self.jsonDict objectForKey:@"info"]];
        NSLog(@"-----error code %ld",(long)[operation.response statusCode]);
        //[MBProgressHUD showError:@"未知错误"];
        
    }];
    
}
- (void) huoquyanzhengmaBtLoad{
    if (yanzhengmaIndex <= 0) {
        self.getBtn.enabled = YES;
        [yanzhengmaTimer invalidate];
        yanzhengmaTimer  = nil;
        [self.getBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    }else{
        [self.getBtn setTitle:[NSString stringWithFormat:@"%ds后重发",yanzhengmaIndex] forState: UIControlStateDisabled];
    }
    yanzhengmaIndex--;
}
#pragma mark - 验证手机号合法性
- (BOOL)isValidatePhone:(NSString *)phone {
    
    NSString *phoneRegex = @"^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
    
}
#pragma mark - 设置登录按钮
- (void)setLoginButton{
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(16,150, YTHScreenWidth-32, 40)];
    
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
#pragma mark -点击登录按钮
- (void)clickLoginBtn:(id)sender{
    NSString *userUuid =[myDelegate.userInfo objectForKey:@"uuid"];
    NSString *url1 = [NSString stringWithFormat:@"v1/user/%@/bindAccount",userUuid];
    NSString *text = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);    // 封装请求参数
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"mobile"] =self.phoneTF.text;
    md[@"authCode"] =self.authCodeTF.text;;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/user/%@/bindAccount",url,userUuid];
    [manager PUT:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     self.jsonDict = responseObject;
                NSLog(@"手机绑定 %ld",(long)[operation.response statusCode]);
        NSLog(@"手机绑定%@",responseObject);
        if ([operation.response statusCode]/100==2) {
                                            //登录账号
            //            myDelegate.account = self.accountTF.text;
                        myDelegate.userInfo = [responseObject objectForKey:@"userInfo"];
                       
                    }

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"手机绑定error code %ld",(long)[operation.response statusCode]);
        
                self.jsonDict = operation.responseObject;
        
                [MBProgressHUD showError:[ self.jsonDict objectForKey:@"info"]];
        
    }];
//    [manager POST:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // self.jsonDict = [[NSDictionary alloc]init];
//        self.jsonDict = responseObject;
//        NSLog(@"手机绑定 %ld",(long)[operation.response statusCode]);
//        NSLog(@"手机绑定%@",self.jsonDict);
//        if ([operation.response statusCode]/100==2) {
//                                //登录账号
////            myDelegate.account = self.accountTF.text;
//            myDelegate.userInfo = [responseObject objectForKey:@"userInfo"];
//           
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"手机绑定error code %ld",(long)[operation.response statusCode]);
//        
//        self.jsonDict = operation.responseObject;
//       
//        [MBProgressHUD showError:[ self.jsonDict objectForKey:@"info"]];
//        
//    }];
//    
    
    
    
    
    
}

#pragma mark -TextField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
//    if (textField==self.passwordTF) {
//        if (self.phoneTF.text.length==0) {
//            [MBProgressHUD showError:@"手机号不能为空"];
//        }
        if (self.authCodeTF.text.length==0) {
            [MBProgressHUD showError:@"验证码不能为空"];
            
        }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (textField==self.phoneTF) {
        if (![self isValidatePhone:toBeString]) {
            self.getBtn.enabled=NO;
            [self.getBtn setBackgroundImage: [UIImage imageNamed:@"button_verify_off"] forState:UIControlStateNormal];
        }else{
            self.getBtn.enabled = YES;
            [self.getBtn setBackgroundImage:[UIImage imageNamed:@"button_verify_on"] forState:UIControlStateNormal];
        }
    }
   
        
    
    
    return YES;
    
}
#pragma mark - 验证密码合法性
- (BOOL)isValidatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,15}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
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
