//
//  ShowViewController.m
//  星优客
//
//  Created by vgool on 15/12/30.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "ShowViewController.h"
#import "CustomBarItem.h"
#import "UINavigationItem+CustomItem.h"
#import "ShowPhotoViewController.h"
#import "ShowTitleViewController.h"
#import "LoginFirstViewController.h"
#import "AppDelegate.h"
#import "LoginFirstViewController.h"
#import "DoImagePickerController.h"
#import "AssetHelper.h"
#import "TopicViewController.h"
@interface ShowViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,DoImagePickerControllerDelegate>
{
    AppDelegate *myDelegate;
    UIButton *showPhotoButton;
    UIButton *showTopicButton;
    BOOL flag;
}
@property (strong, nonatomic) NSMutableArray *photoNameList;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    flag=YES;
    self.navigationItem.title = @"秀逼格";
    self.view.backgroundColor = YTHBaseVCBackgroudColor;
    [self _loadNavigationViews];
     showPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(YTHAdaptation(82), YTHAdaptation(257)+YTHAdaptation(70),YTHAdaptation(68),YTHAdaptation(68))];
    [showPhotoButton setImage:[UIImage imageNamed:@"release_show"] forState:UIControlStateNormal];
    
    [showPhotoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:showPhotoButton];
    
      showTopicButton = [[UIButton alloc]initWithFrame:CGRectMake(YTHScreenWidth-YTHAdaptation(150), YTHAdaptation(257)+YTHAdaptation(70),YTHAdaptation(68),YTHAdaptation(68))];
    [showTopicButton addTarget:self action:@selector(buttonTitle:) forControlEvents:UIControlEventTouchUpInside];

    [showTopicButton setImage:[UIImage imageNamed:@"release_topic"] forState:UIControlStateNormal];
    
    [self.view addSubview:showTopicButton];
    
    
   
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
  [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)buttonAction:(UIButton *)btn
{
    
    
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil   delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [sheet addButtonWithTitle:@"本地上传"];
            [sheet addButtonWithTitle:@"拍照上传"];
            [sheet addButtonWithTitle:@"取消"];
            sheet.cancelButtonIndex = sheet.numberOfButtons-1;
        }else {
            [sheet addButtonWithTitle:@"本地上传"];
            [sheet addButtonWithTitle:@"取消"];
            sheet.cancelButtonIndex = sheet.numberOfButtons-1;
        }
        [sheet showInView:self.view];
    
    
    
//    ShowPhotoViewController *showVC = [[ShowPhotoViewController alloc]init];
//    [self.navigationController pushViewController:showVC animated:YES];
    
    
    
//    if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])) {
//        ShowPhotoViewController *showVC = [[ShowPhotoViewController alloc]init];
//        [self.navigationController pushViewController:showVC animated:YES];
//        return;
//        
//    }else{
//        LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
    
}
-(void)buttonTitle:(UIButton *)btn
{
    if (!IsNilOrNull([myDelegate.userInfo objectForKey:@"uuid"])) {
        TopicViewController *topicVC = [[TopicViewController alloc]init];
        [self.navigationController pushViewController:topicVC animated:YES];
        return;
        
    }else{
        LoginFirstViewController *loginVC = [[LoginFirstViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

#pragma mark-UIActionSheet
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 2:{}
                return;
            case 1:
            {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init] ;
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = NO;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:^{}];
                //					[imagePickerController release];
            }
                break;
            case 0:
                [self showImagePicker];
                break;
        }
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.photoNameList insertObject:image atIndex:0];
    //    [self.photoNameList addObject:image];
    //self.photoImg.image = image;
    //[self reloadPhotos];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)selectedImages
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        for (int i = 0; i < MIN(10, selectedImages.count); i++)
        {
            
            [self.photoNameList insertObject:selectedImages[i] atIndex:self.photoNameList.count-1];
            //            [self.photoNameList addObject:selectedImages[i]];
        }
    }
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        for (int i = 0; i < MIN(10, selectedImages.count); i++)
        {
            [self.photoNameList insertObject:[ASSETHELPER getImageFromAsset:selectedImages[i] type:ASSET_PHOTO_SCREEN_SIZE] atIndex:self.photoNameList.count-1];
            //            [self.photoNameList addObject:[ASSETHELPER getImageFromAsset:selectedImages[i] type:ASSET_PHOTO_SCREEN_SIZE]];
        }
        
        [ASSETHELPER clearData];
    }
    if (self.photoNameList.count > 0) {
        //        [self reloadPhotos];
        // [_kPhotoCollectionView reloadData];
    }
}

- (void)showImagePicker {
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.flag = flag;
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
    cont.nMaxCount = 9 - (self.photoNameList.count-1);//最大张数
    cont.nColumnCount = 4;//选择器行数
    [self presentViewController:cont animated:YES completion:nil];
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
