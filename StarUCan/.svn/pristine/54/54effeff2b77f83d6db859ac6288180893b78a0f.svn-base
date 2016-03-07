//
//  TestViewController.m
//  vgool
//
//  Created by vgool on 15/12/17.
//  Copyright © 2015年 chenyanming. All rights reserved.
//

#import "TestViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface TestViewController ()
{
    UIImageView *imagePho;
}

@end

@implementation TestViewController
#define MineColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// Mine(我的) 背景色
#define MineBg MineColor(240, 240, 240)
#define NaM MineColor(250, 90, 0)
#define BWMWidth [[UIScreen mainScreen]bounds].size.width
#define BWMHeight [[UIScreen mainScreen] bounds].size.height
#define BWMDongTaiZhi(dongTaiZhi) (dongTaiZhi/320.0f)*[[UIScreen mainScreen]bounds].size.width
- (void)viewWillAppear:(BOOL)animated {
    
    //调用父类的方法
    [super viewWillAppear:animated];
    [self _initCreat];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];;
    UIView *naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BWMWidth, 55)];
    naView.backgroundColor = NaM;
    [self.view addSubview:naView];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 19, 44, 34);
    [backBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [naView addSubview:backBtn];
    [self _initCreat];
}

-(void)_initCreat
{
    UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(54/2, 54/2+55, 98/2, 98/2)];
    imageLogo.image = [UIImage imageNamed:@"logopic"];
    [self.view addSubview:imageLogo];
    
    UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageLogo.frame)+20, 54/2+55, BWMWidth-100, 98/2)];
   // labelText.backgroundColor = [UIColor yellowColor];
    labelText.text = @"VGOOL IOS测试群";
    labelText.textColor = [UIColor grayColor];
    labelText.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:labelText];
    
    
    imagePho = [[UIImageView alloc]initWithFrame:CGRectMake((BWMWidth-171)/2, CGRectGetMaxY(labelText.frame)+39, 171, 171)];
    imagePho.userInteractionEnabled = YES;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];

    NSString *urlString =@"http://image.vgool.cn/platform-file/contact/qr.png?a=";
//    urlString = [NSString stringWithFormat:@"%@",timeString];
     urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@",timeString]];
    [imagePho sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [self.view addSubview:imagePho];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveAction:)];
   [imagePho addGestureRecognizer:longPress];
    
    UILabel *labelSave = [[UILabel alloc]initWithFrame:CGRectMake((BWMWidth-171)/2-10, CGRectGetMaxY(imagePho.frame)+29, 171+10+20, 30)];
    labelSave.text = @"长按保存二维码加入我们的官方测试群组";
    labelSave.textColor = [UIColor grayColor];
    labelSave.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:labelSave];


                          
}
-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//保存图片
- (void)saveAction:(UILongPressGestureRecognizer *)longPress
{
    
    //UIGestureRecognizerStateBegan手势的状态，一开始按的时候
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        UIImage *image = imagePho.image;
        if (image != nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存到相册？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            // alert.tag = sender.tag;
            [alertView show];
            
            
            
        }
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
      UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window
                                                  animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        UIImageWriteToSavedPhotosAlbum( imagePho.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)(hud));
        
    }
}




//保存图片成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    
    MBProgressHUD *hud = (__bridge MBProgressHUD *)(contextInfo);
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟1.5秒隐藏
    [hud hide:YES afterDelay:1.5];
    
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
