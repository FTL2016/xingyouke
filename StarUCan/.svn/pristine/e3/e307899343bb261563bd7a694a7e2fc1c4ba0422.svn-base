//
//  WordViewController.m
//  Starucan
//
//  Created by vgool on 16/1/16.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()<UITextViewDelegate>
{
    UITextView *_textView;
    UIView *_editorBar;//编辑工具栏
    UILabel *labelText;
    UILabel *label;
    
    
}

@end

@implementation WordViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"秀逼格";
    //监听键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [self _initCreat];
    //创建导航栏上的视图
    [self _loadNavigationViews];
}
-(void)_initCreat
{
    //创建输入框视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 200)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
    labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 7,YTHScreenWidth-23, 20)];
    labelText.text = @" 秀的时候别忘了点我吹点牛逼";
    
    labelText.font = [UIFont systemFontOfSize:14];
    labelText.numberOfLines = 0;
    labelText.textColor =[UIColor grayColor];
    labelText.enabled = NO;//lable必须设置为不可用
    labelText.backgroundColor = [UIColor clearColor];
    [_textView addSubview:labelText];
    //弹出键盘
    [_textView becomeFirstResponder];
    
    
    
    [self.view addSubview:_textView];
    
    //创建编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, 210, YTHScreenWidth, 25)];
    _editorBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_editorBar];
    label = [[UILabel alloc]initWithFrame:CGRectMake(YTHScreenWidth-90, 0, 80, 25)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"";
    label.textColor = [UIColor blackColor];
    [_editorBar addSubview:label];
    
    
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
    
    NSString *text = _textView.text;
    
    NSString *error = nil;
    if (text.length == 0) {
        error = @"字数为空";
    }else if (text.length > 200)
    {
        error = @"字数大于200";
    }
    if (error != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    
    
    if ([self.delegate respondsToSelector:@selector(wordsomeView:didClickTitle:)]) {
        [self.delegate wordsomeView:self didClickTitle:_textView.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -UIKeyboardWillShowNotification
- (void)keyboardWillShowAction:(NSNotification *)notification
{
    //取得键盘的frame，UIKeyboardFrameEndUserInfoKey是键盘尺寸变化之后的尺寸
    NSDictionary *userInfo = notification.userInfo;
    //    NSLog(@"%@",userInfo);
    NSValue *boundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [boundsValue CGRectValue];
    
    //取到键盘的高
    CGFloat height = CGRectGetHeight(frame);
    _textView.height = YTHScreenHeight  - height - _editorBar.height;
    _editorBar.top = _textView.bottom-64;
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    // self.examineText =  textView.text;
    if (textView.text.length == 0) {
        labelText.text = @" 秀的时候别忘了点我吹点牛逼";
    }
    else{
        labelText.text = @"";
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *temp = [textView.text
                      
                      stringByReplacingCharactersInRange:range
                      
                      withString:text];
    NSInteger remainTextNum = 200;
    //计算剩下多少文字可以输入
    
    if(range.location>=200)
        
    {
        
        remainTextNum = 0;
        
        //        [self showSimpleAlert:@"请输入小于100个字！"];
        //
        //        self.emailFT.userInteractionEnabled = NO;
        
        return YES;
        
    }else
        
    {
        
        NSString * nsTextContent = temp;
        
        NSInteger existTextNum = [nsTextContent length];
        
        remainTextNum =200-existTextNum;
        
        label.text = [NSString stringWithFormat:@"%ld/200",(long)remainTextNum];
        
        
        
        
        return YES;
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
