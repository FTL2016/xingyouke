//
//  ForgetPassViewController.m
//  Starucan
//
//  Created by vgool on 15/12/31.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "LoginFirstViewController.h"
#import "MBProgressHUD+NJ.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+AES256.h"
@interface ForgetPassViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    NSTimer *yanzhengmaTimer;
    int yanzhengmaIndex;
    AppDelegate *myDelegate;
    
}
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UITextField *phoneTF;
@property (nonatomic, weak) UIButton *getBtn;
@property (nonatomic, weak) UITextField *authCodeTF;//验证码输入框
@property (nonatomic, weak) UITextField *passwordTF;
@property (nonatomic, weak) UITextField *passwordSecondTF;

@property (nonatomic, weak) UIButton *regisBtn;
@property (nonatomic,strong)NSDictionary *jsonDict;
@property (nonatomic,strong)NSDictionary *regisDict;

@end

@implementation ForgetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    self.regisDict = [[NSDictionary alloc]init];
    self.jsonDict = [[NSDictionary alloc]init];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self _initNation];
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.contentSize = CGSizeMake(YTHScreenWidth, YTHScreenHeight+YTHAdaptation(50));
    scrollview.backgroundColor = YTHColor(235, 235, 241);
    scrollview.scrollEnabled = YES;
    scrollview.contentSize =CGSizeMake(YTHScreenWidth,YTHScreenHeight+YTHAdaptation(150));
    self.scrollView = scrollview;
    
    self.getBtn.enabled = YES;
    
    self.view = scrollview;
    //设置手机号输入框
    [self setPhoneTextFied];
    //请输入验证码
    [self setauthCodeTextFied];
    //验证码
    [self setGetAuthcodeButton];
    //点击空白处
    [self tapToDismissKB];
    //密码
    [self setPasswordTextFied];
    //注册按钮
    [self setRegisterButton];
   
    yanzhengmaIndex = 0;
    [self.getBtn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"button_verify_off.png"]]];

}
-(void)_initNation
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
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 设置点击空白处隐藏键盘
- (void)tapToDismissKB{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    // 设置成NO表示当前控件响应后会传播到其他控件上，默认为YES
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)dismissKeyboard{
    [self.phoneTF resignFirstResponder];
}

#pragma mark - 设置手机号输入框
- (void)setPhoneTextFied{
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(YTHAdaptation(16),YTHAdaptation(32), YTHScreenWidth-YTHAdaptation(32), YTHAdaptation(40))];
    phoneTF.delegate = self;
    
    phoneTF.borderStyle = UITextBorderStyleNone;
    phoneTF.backgroundColor = [UIColor whiteColor];
    
    phoneTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    
    [phoneTF.layer setMasksToBounds:YES];
    [phoneTF.layer setCornerRadius:4.5];
    phoneTF.layer.borderWidth = 1;
    
    phoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,YTHAdaptation(60),YTHAdaptation(45))];
    phoneTF.leftViewMode = UITextFieldViewModeAlways;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(60),YTHAdaptation(45))];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"+86   ";
    lab.textColor = YTHColor(118, 118, 118);
    [phoneTF.leftView addSubview:lab];
    // phoneTF.font = [UIFont systemFontOfSize:14];
    phoneTF.placeholder = @"请输入手机号";
    
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    [phoneTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phoneTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF = phoneTF;
    [self.view addSubview:phoneTF];
    
    
    
    
    
}
#pragma mark - 请输入短信中的验证码
- (void)setauthCodeTextFied{
    UITextField *authCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(YTHAdaptation(16), CGRectGetMaxY(self.phoneTF.frame)+YTHAdaptation(10), YTHScreenWidth-YTHAdaptation(32), YTHAdaptation(40))];
    authCodeTF.delegate = self;
    
    authCodeTF.borderStyle = UITextBorderStyleNone;
    authCodeTF.backgroundColor = [UIColor whiteColor];
    authCodeTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [authCodeTF.layer setMasksToBounds:YES];
    [authCodeTF.layer setCornerRadius:4.5];
    authCodeTF.layer.borderWidth = 1;
    
    authCodeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(20), YTHAdaptation(50))];
    authCodeTF.leftViewMode = UITextFieldViewModeAlways;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,YTHAdaptation(20), YTHAdaptation(50))];
    [authCodeTF.leftView addSubview:lab];
    authCodeTF.placeholder = @"请输入短信中的验证码";
    authCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    authCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [authCodeTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.authCodeTF = authCodeTF;
    [self.view addSubview:authCodeTF];
}
#pragma mark - 设置获取验证码按钮
- (void)setGetAuthcodeButton{
    UIButton *getBtn = [[UIButton alloc]initWithFrame:CGRectMake(YTHScreenWidth-YTHAdaptation(115), CGRectGetMaxY(self.phoneTF.frame)+YTHAdaptation(10),YTHAdaptation(98), YTHAdaptation(40))];
    
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    //getBtn.backgroundColor = [UIColor redColor];
    
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

    
    [manager GET:@"http://test.platform.vgool.cn/starucan/v1/base/authcode" parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [manager POST:@"http://test.platform.vgool.cn/starucan/v1/base/authcode" parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        self.jsonDict = responseObject;
//        
//        NSLog(@"error code %ld",(long)[operation.response statusCode]);
//        
//        if ([operation.response statusCode]/100==2) {
//            
//            
//            
//            [MBProgressHUD showSuccess:@"发送成功"];
//            
//            self.getBtn.enabled = NO;
//            
//            if (yanzhengmaTimer) {
//                
//                [yanzhengmaTimer invalidate];
//                yanzhengmaTimer  = nil;
//            
//            }
//            
//            yanzhengmaIndex = 60;
//            
//            [self huoquyanzhengmaBtLoad];
//            
//            yanzhengmaIndex--;
//            
//            yanzhengmaTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(huoquyanzhengmaBtLoad) userInfo:nil repeats:YES];
//        
//        }else{
//            
//            self.getBtn.enabled = YES;
//        }
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
    
}

#pragma mark - 设置密码输入框
- (void)setPasswordTextFied{
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(YTHAdaptation(16), CGRectGetMaxY(self.authCodeTF.frame)+YTHAdaptation(20), YTHScreenWidth-YTHAdaptation(32),YTHAdaptation(40))];
    passwordTF.delegate = self;
    
    passwordTF.borderStyle = UITextBorderStyleNone;
    passwordTF.backgroundColor = [UIColor whiteColor];
    passwordTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [passwordTF.layer setMasksToBounds:YES];
    [passwordTF.layer setCornerRadius:4.5];
    passwordTF.layer.borderWidth = 1;
    
    
    passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(40), YTHAdaptation(50))];
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(40), YTHAdaptation(50))];
    // passView.backgroundColor = [UIColor orangeColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(YTHAdaptation(15), YTHAdaptation(15), YTHAdaptation(16), YTHAdaptation(16))];
    // imgV.backgroundColor = [UIColor yellowColor];
    imgV.image = [UIImage imageNamed:@"key"];
    [passView addSubview:imgV];
    
    [passwordTF.leftView addSubview:passView];
    passwordTF.placeholder = @"密码(6~15个字符)";
    passwordTF.secureTextEntry = YES;
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.passwordTF = passwordTF;
    
    [self.view addSubview:passwordTF];
    
    UITextField *passwordSecondTF = [[UITextField alloc] initWithFrame:CGRectMake(YTHAdaptation(16), CGRectGetMaxY(passwordTF.frame)+YTHAdaptation(10), YTHScreenWidth-YTHAdaptation(32), YTHAdaptation(40))];
    passwordSecondTF.delegate = self;
    
    passwordSecondTF.borderStyle = UITextBorderStyleNone;
    passwordSecondTF.backgroundColor = [UIColor whiteColor];
    passwordSecondTF.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [passwordSecondTF.layer setMasksToBounds:YES];
    [passwordSecondTF.layer setCornerRadius:4.5];
    passwordSecondTF.layer.borderWidth = 1;
    
    
    passwordSecondTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(40), YTHAdaptation(50))];
    passwordSecondTF.leftViewMode = UITextFieldViewModeAlways;
    UIView *passSecView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTHAdaptation(40), YTHAdaptation(50))];
    // passView.backgroundColor = [UIColor orangeColor];
    UIImageView *imgVSec = [[UIImageView alloc]initWithFrame:CGRectMake(YTHAdaptation(15), YTHAdaptation(15), YTHAdaptation(16), YTHAdaptation(16))];
    imgVSec.image = [UIImage imageNamed:@"key_ture"];
    [passSecView addSubview:imgVSec];
    
    [passwordSecondTF.leftView addSubview:passSecView];
    passwordSecondTF.placeholder = @"再次输入密码";
    passwordSecondTF.secureTextEntry = YES;
    passwordSecondTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordSecondTF addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.passwordSecondTF = passwordSecondTF;
    
    [self.view addSubview:passwordSecondTF];
    
    
    
}

#pragma mark -获取验证码
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
#pragma mark - 设置注册按钮
- (void)setRegisterButton{
    UIButton *regisBtn = [[UIButton alloc]initWithFrame:CGRectMake(YTHAdaptation(15), CGRectGetMaxY(self.passwordSecondTF.frame)+YTHAdaptation(44), YTHScreenWidth-YTHAdaptation(30), YTHAdaptation(40))];
    regisBtn.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [regisBtn.layer setMasksToBounds:YES];
    [regisBtn.layer setCornerRadius:4.5];
    regisBtn.layer.borderWidth = 1;
    // regisBtn.backgroundColor = [UIColor orangeColor];
    [regisBtn setTitle:@"找回" forState:UIControlStateNormal];
    
    [regisBtn addTarget:self action:@selector(clickRegisBtn:) forControlEvents:UIControlEventTouchUpInside];
    [regisBtn setBackgroundImage:[UIImage imageNamed:@"btn_tile"] forState:UIControlStateNormal];
    regisBtn.enabled = NO;
    self.regisBtn = regisBtn;
    
    [self.view addSubview:regisBtn];
}
- (void)textChanged{
    self.regisBtn.enabled = (self.phoneTF.text.length>0 && self.passwordTF.text.length>0&&self.authCodeTF.text.length>0&&[self.passwordSecondTF.text isEqualToString:self.passwordTF.text]);
}
#pragma mark - 找回密码点击按钮
- (void)clickRegisBtn:(UIButton *)btn{
    if (![self isValidatePhone:self.phoneTF.text]) {
        [MBProgressHUD showError:@"手机号格式不正确"];
        return;
    }
    
    if (self.authCodeTF.text.length != 6) {
        [MBProgressHUD showError:@"请输入正确验证码"];
        return;
    }
    if (![self.passwordSecondTF.text isEqualToString:self.passwordTF.text]){
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
    if (![self isValidatePassword:self.passwordTF.text]) {
        [MBProgressHUD showError:@"请输入6-15位字符密码"];
    }
    
    if (self.phoneTF.text.length == 0 || self.passwordTF.text.length == 0 || self.authCodeTF.text.length == 0||self.passwordSecondTF.text.length==0){
        [MBProgressHUD showError:@"请输入完整信息"];
        return;
    }
    
    //注册传得参数
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSString *text =[self md5:self.passwordTF.text];
    md[@"mobile"] =self.phoneTF.text;
    md[@"authCode"] = self.authCodeTF.text;
    md[@"password"] = text;
    NSLog(@"找回md5密码=%@",text);
    NSLog(@"手机号：%@",self.phoneTF.text);
    NSLog(@"验证码：%@",self.authCodeTF.text);
    
    //保存
    myDelegate.passText = text;
    NSString *url1 = @"v1/user/findpwd";
    //AES
     NSString *aesText = [NSData AES256EncryptWithPlainText:url1 passtext:myDelegate.passText];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求头
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:aesText];
      [manager.requestSerializer setValue:self.phoneTF.text forHTTPHeaderField:@"account"];
    NSString *url = Url;
    NSString *urlString = [NSString stringWithFormat:@"%@v1/user/findpwd",url];
    
    [manager PUT:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"忘记密码信息%@",responseObject);
        self.regisDict = responseObject;
        NSLog(@"注册状态 code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            [MBProgressHUD showSuccess:@"修改成功"];
//            //第二种
//            myDelegate.regist_accesstoken = responseObject[@"access_token"];
//            myDelegate.userInfo = [responseObject objectForKey:@"userInfo"];
        }
        

        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"忘记密码错误返回%@",[ self.regisDict objectForKey:@"info"]);
        [MBProgressHUD showError:[ self.regisDict objectForKey:@"info"]];
        NSLog(@"-----error code %ld",(long)[operation.response statusCode]);
        
    }];
    
}
#pragma mark - 验证手机号合法性
- (BOOL)isValidatePhone:(NSString *)phone {
    
    NSString *phoneRegex = @"^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
    
}
#pragma mark -TextField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    if (textField==self.passwordTF) {
        if (self.phoneTF.text.length==0) {
            [MBProgressHUD showError:@"手机号不能为空"];
        }
        if (self.authCodeTF.text.length==0) {
            [MBProgressHUD showError:@"验证码不能为空"];
            
        }
    }
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField==self.passwordTF) {
//        if (![self isValidatePassword:self.passwordTF.text]) {
//            self.passwordTF.layer.borderColor = [UIColor redColor].CGColor;
//        }else{
//            self.passwordTF.layer.borderColor = [UIColor greenColor].CGColor;
//        }
//
//    }
//}
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
    if (textField==self.passwordTF) {
        if (![self isValidatePassword:toBeString]) {
            self.passwordTF.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            self.passwordTF.layer.borderColor = [UIColor greenColor].CGColor;
        }
        
        
    }
    if (textField==self.passwordSecondTF) {
        if (![toBeString isEqualToString:self.passwordTF.text]||![self isValidatePassword:toBeString]) {
            self.passwordSecondTF.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            self.passwordSecondTF.layer.borderColor = [UIColor greenColor].CGColor;
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
-(UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
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
