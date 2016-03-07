//
//  ShowTitleViewController.m
//  Starucan
//
//  Created by vgool on 16/1/8.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "ShowTitleViewController.h"
#define MineColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define Label MineColor(240, 240, 240)
@interface ShowTitleViewController ()<UITextViewDelegate>
{
    UITextView *textView;
    UILabel *labelText;
}
@end

@implementation ShowTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发起话题";
    [self _initCreat];
    [self tapToDismissKB];
}
-(void)_initCreat
{
    
    UIView *naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 55)];
    naView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naView];

    UILabel *themeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, YTHScreenWidth, 30)];
    themeLabel.text = @"主题（5-15个字）";
    themeLabel.textColor = [UIColor blackColor];
    themeLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:themeLabel];
    
    //添加文本框
    textView=[[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(themeLabel.frame), YTHScreenWidth-20, 308/2)];
    textView.tag=102;
    textView.delegate=self;
    textView.textColor = [UIColor grayColor];
    [self.view addSubview:textView];
    
    [textView.layer setMasksToBounds:YES];
//    [textView.layer setCornerRadius:4];
//    textView.layer.borderColor = [UIColor grayColor].CGColor;
//    textView.layer.borderWidth = 0.1;
    
    labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,YTHScreenWidth-23, 20)];
    
    labelText.font = [UIFont systemFontOfSize:11];
    labelText.numberOfLines = 0;
    labelText.textColor =Label;
    labelText.enabled = NO;//lable必须设置为不可用
    labelText.backgroundColor = [UIColor clearColor];
    [textView addSubview:labelText];
      labelText.text = @"  多给小伙伴们谈谈这个话题";

    
}
#pragma mark - 设置点击空白处隐藏键盘
- (void)tapToDismissKB{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    // 设置成NO表示当前控件响应后会传播到其他控件上，默认为YES
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)dismissKeyboard
{
    [textView resignFirstResponder];
}
-(void)textViewDidChange:(UITextView *)textView
{
    // self.examineText =  textView.text;
    if (textView.text.length == 0) {
        
            labelText.text = @"  多给小伙伴们谈谈这个话题";
    }else
        labelText.text = @"";
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //注意\n是一个字符,不是两个字符,一定要注意
        [textView resignFirstResponder];
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
