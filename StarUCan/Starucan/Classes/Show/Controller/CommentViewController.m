//
//  CommentViewController.m
//  Starucan
//
//  Created by vgool on 16/1/23.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "CommentViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
#import "MBProgressHUD+NJ.h"
@interface CommentViewController ()<UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *labelText;
    AppDelegate *myDelegate;

}
@property(nonatomic,strong)NSDictionary *jason;
@end

@implementation CommentViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发表评论";
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    [self _loadNavigationViews];
    //创建输入框视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 200)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
    
    labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 7,YTHScreenWidth-23, 20)];
    labelText.text = @" 写评论";
    
    labelText.font = [UIFont systemFontOfSize:14];
    labelText.numberOfLines = 0;
    labelText.textColor =[UIColor grayColor];
    labelText.enabled = NO;//lable必须设置为不可用
    labelText.backgroundColor = [UIColor clearColor];
    [_textView addSubview:labelText];
    //弹出键盘
    [_textView becomeFirstResponder];
    [self.view addSubview:_textView];

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
     NSString *uS = Url;
   // NSString *text = _textView.text;
   // NSString *url1 = @"v1/comment";
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/comment/%@/comment",uS,self.uuid];
    NSString *ueltext = [NSString stringWithFormat:@"v1/comment/%@/comment",self.uuid];
    NSString *text = [NSData AES256EncryptWithPlainText:ueltext passtext:myDelegate.accessToken];
    NSLog(@"登录密码=%@",myDelegate.accessToken);
    NSLog(@"加密后%@",text);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    NSLog(@"登录账号%@",myDelegate.account);
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //内容
    md[@"content"]=_textView.text;//
    md[@"authorUuid"]=self.userUuid;
    md[@"type"]=@"0";
    md[@"mainType"]=@"0";
    NSLog(@"用户id%@",self.userUuid);
    NSLog(@"内容%@",_textView.text);
   // NSString *urlStr = [NSString stringWithFormat:@"%@v1/comment/%@/comment",uS,self.uuid];
    [manager POST:urlStr parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.jason = responseObject;
        NSLog(@"发表评论 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2)
        {
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestTable" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发表评论错误 %ld",(long)[operation.response statusCode]);
        self.jason = operation.responseObject;
        NSLog(@"发表评论%@", self.jason);
        [MBProgressHUD showError:[self.jason objectForKey:@"info"]];
        
        
    }];
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    // self.examineText =  textView.text;
    if (textView.text.length == 0) {
        labelText.text = @" 写评论";
    }
    else{
        labelText.text = @"";
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
