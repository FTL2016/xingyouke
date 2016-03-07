//
//  RegisterSecondViewController.m
//  Starucan
//
//  Created by vgool on 16/1/4.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import "AddInformationViewController.h"
#import "GXHttpTool.h"
#import "MBProgressHUD+NJ.h"
#import "QiniuSDK.h"
#import "AppDelegate.h"
#import "WXNavigationController.h"
@interface RegisterSecondViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AddInformationViewController *addInforVC;
    NSString *sex;
    AppDelegate *myDelegate;

}
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *logoImv;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,strong)NSString *tokenKey;
@property (nonatomic,strong)NSString *qiniuText;
@property (nonatomic,strong)NSString *domain;
@property (nonatomic,strong)NSString *urlString;
@property (nonatomic,strong)UIButton *manButton;
@property (nonatomic,strong)UIButton *womanButton;
@property (nonatomic,strong)UIImageView *headV;


@end

@implementation RegisterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = YES;
     self.title = @"补全信息";
    self.dict = [[NSDictionary alloc]init];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame =CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight);
    scrollview.backgroundColor = YTHColor(235, 235, 241);
    if (threeInch) {
        scrollview.contentSize =CGSizeMake(YTHScreenWidth,YTHScreenHeight+100);
    }else{
    scrollview.contentSize =CGSizeMake(YTHScreenWidth,YTHScreenHeight);
    }
    self.scrollView = scrollview;
    self.view = scrollview;

    
    

   
   
   
    
   
    
    [self _initCreat];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://test.platform.vgool.cn/starucan/v1/base/qntoken" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dict = responseObject;
        if ([operation.response statusCode]/100==2) {
            self.tokenKey = [self.dict objectForKey:@"qntoken"];
            self.domain = [NSString stringWithFormat:@"http://%@",[self.dict objectForKey:@"domain"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:[ self.dict objectForKey:@"info"]];
        NSLog(@"-----error code %ld",(long)[operation.response statusCode]);
        
    }];
    
   
   
    // Do any additional setup after loading the view.
}
-(void)_initCreat
{
    self.view.backgroundColor = YTHColor(243, 243, 243);
    //上传头像
    UIImageView *logoImv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,YTHScreenWidth,YTHAdaptation(220))];
    logoImv.image =[UIImage imageNamed:@"headground"];
    logoImv.userInteractionEnabled = YES;
     self.logoImv = logoImv;
    
    [self.view addSubview:logoImv];
    //返回
    UIButton *leftUibutton = [[UIButton alloc]initWithFrame:CGRectMake(0,YTHAdaptation(19), YTHAdaptation(44), YTHAdaptation(34))];
    [leftUibutton addTarget:self action:@selector(buttonBack:) forControlEvents:UIControlEventTouchUpInside];
    [leftUibutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:leftUibutton];
   //标题
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, YTHAdaptation(21), YTHScreenWidth, YTHAdaptation(30))];
    labelTitle.text = @"补全信息";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTitle];
    
    UIImageView *headV = [[UIImageView alloc]initWithFrame:CGRectMake(YTHScreenWidth/2-YTHAdaptation(47.5), YTHAdaptation(198),YTHAdaptation(95),YTHAdaptation(95))];
    headV.image = [UIImage imageNamed:@"male_shade"];
    [headV.layer setMasksToBounds:YES];
        [headV.layer setCornerRadius:YTHAdaptation(95/2)];
        headV.layer.borderColor = [UIColor orangeColor].CGColor;
        headV.layer.borderWidth = 1;
    headV.userInteractionEnabled = YES;
    self.headV = headV;
    [self.view addSubview:headV];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateFace:)];
    [headV addGestureRecognizer:tapGesture];
    
   
    UITextField *nameTF = [[UITextField alloc]initWithFrame:CGRectMake(YTHAdaptation(102), CGRectGetMaxY(headV.frame)+YTHAdaptation(40), YTHScreenWidth-YTHAdaptation(102),YTHAdaptation(30))];
    nameTF.text = [myDelegate.userInfo objectForKey:@"name"];
    nameTF.text  = @"zxl1111";
    nameTF.font = [UIFont systemFontOfSize:14];
       self.nameTF = nameTF;
    [self.view addSubview:nameTF];
    //男或女
    _manButton = [[UIButton alloc]initWithFrame:CGRectMake(YTHAdaptation(82), CGRectGetMaxY(nameTF.frame)+YTHAdaptation(70),YTHAdaptation(68),YTHAdaptation(68))];
    NSString *sextitle = [myDelegate.userInfo objectForKey:@"sex"];
//    logoImv.image =[UIImage imageNamed:@"120-1"];
   // manImv.backgroundColor = [UIColor yellowColor];
    [_manButton.layer setMasksToBounds:YES];
    [_manButton.layer setCornerRadius:YTHAdaptation(34)];
    _manButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    _manButton.layer.borderWidth = 0.5;
    _manButton.tag = 1;
    [_manButton addTarget:self action:@selector(manButton:) forControlEvents:UIControlEventTouchUpInside];
    //manImv.userInteractionEnabled = YES;
    [self.view addSubview:_manButton];
    _womanButton = [[UIButton alloc]initWithFrame:CGRectMake(YTHScreenWidth-YTHAdaptation(150),  CGRectGetMaxY(nameTF.frame)+YTHAdaptation(70),YTHAdaptation(68),YTHAdaptation(68))];
   
    [_womanButton.layer setMasksToBounds:YES];
    [_womanButton.layer setCornerRadius:YTHAdaptation(34)];
    _womanButton.layer.borderColor = [UIColor grayColor].CGColor;
    _womanButton.layer.borderWidth = 0.5;
    [_womanButton addTarget:self action:@selector(womanButton:) forControlEvents:UIControlEventTouchUpInside];
    //womanImv.userInteractionEnabled=YES;
    [self.view addSubview:_womanButton];
    sextitle = @"1";
    if ([sextitle isEqualToString:@"1"]) {
         [_manButton setImage:[UIImage imageNamed:@"sexmale_on"] forState:UIControlStateNormal];
        [_womanButton setImage:[UIImage imageNamed:@"sexmale_off"] forState:UIControlStateNormal];
        
        
    }else if ([sextitle isEqualToString:@"2"])
    {
        [_womanButton setImage:[UIImage imageNamed:@"sexfemale_on"] forState:UIControlStateNormal];
        [_manButton setImage:[UIImage imageNamed:@"sexmale_off"] forState:UIControlStateNormal];
        
    }
    
//下一步按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(YTHAdaptation(16), CGRectGetMaxY(_womanButton.frame)+YTHAdaptation(86), YTHScreenWidth-YTHAdaptation(32), YTHAdaptation(40));
   
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:4.5];
 
   // nextButton.backgroundColor = [UIColor orangeColor];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"btn_tile"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
    
    
}
- (void)manButton:(UIButton *)btn
{

    [_manButton setImage:[UIImage imageNamed:@"sexmale_on"] forState:UIControlStateNormal];
     [_womanButton setImage:[UIImage imageNamed:@"sexmale_off"] forState:UIControlStateNormal];
    if (IsNilOrNull(self.urlString)) {
        
        self.headV.image =  [UIImage imageNamed:@"male_shade"];
        
    }
    sex = @"1";

}
- (void)womanButton:(UIButton *)btn
{
    [_womanButton setImage:[UIImage imageNamed:@"sexfemale_on"] forState:UIControlStateNormal];
    [_manButton setImage:[UIImage imageNamed:@"sexmale_off"] forState:UIControlStateNormal];
           if (IsNilOrNull(self.urlString)) {
               self.headV.image = [UIImage imageNamed:@"female_shade"];
        }
   sex = @"2";
    
}
-(void)buttonBack:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
-(void)nextButtonAction
{
   
   addInforVC = [[AddInformationViewController alloc]init];
    addInforVC.sex = sex;
//    if (!IsNilOrNull(self.urlString)) {
//        self.urlString = @"http://pic23.nipic.com/20120911/5219173_233509072371_2.jpg";
//    }
    addInforVC.nameText = self.nameTF.text;
    addInforVC.stringUrl = self.urlString;
    WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:addInforVC];
    [self presentViewController:nav animated:NO completion:nil];
}
#pragma mark- 上传头像
- (void)updateFace:(UITapGestureRecognizer *)gesture {
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照上传",@"本地上传", nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"本地上传", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:{}
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}
-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    UIImage *i;
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    i=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self saveImage:[info objectForKey:UIImagePickerControllerEditedImage] withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    //	UIImage *image = [[UIImage alloc] initWithCGImage:[self scaleImage:[UIImage imageWithContentsOfFile:fullPath] ToSize:CGSizeMake(71, 71)].CGImage];
    UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
    
    self.headV.tag = 100;
    [self uploadFace:image];
}
- (void)uploadFace:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    
    
    //    NSString *unicodeStr = [NSString stringWithCString:[self.tokenKey UTF8String] encoding:NSUnicodeStringEncoding];
    //     NSData *data1 = [image dataUsingEncoding : NSUTF8StringEncoding];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    [MBProgressHUD showMessage:@"上传中"];
    [upManager putData:data key:nil token:self.tokenKey
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  _qiniuText = [resp objectForKey:@"key"];
                  self.urlString = [NSString stringWithFormat:@"%@/%@",self.domain,self.qiniuText];
                  [MBProgressHUD hideHUD];
                  [MBProgressHUD showSuccess:@"上传成功"];
                  [self.headV setImage:image];
              } option:nil];
    
    self.urlString = [NSString stringWithFormat:@"%@/%@",self.domain,self.qiniuText];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
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
