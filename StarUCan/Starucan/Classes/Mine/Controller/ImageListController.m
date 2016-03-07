//
//  ImageListController.m
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "ImageListController.h"
#import "ShowDetailModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSData+AES256.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "ImageCollectionViewCell.h"
@interface ImageListController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    AppDelegate *myDelegate;
}
@property (nonatomic, retain)NSMutableArray *data;
@property (nonatomic,strong)UICollectionView * myCollection;


@end

@implementation ImageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    self.data = [[NSMutableArray alloc]init];
    [self initCreatCollect];
    [self requestData];
    [_myCollection registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}
- (void)requestData
{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
    //    [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
    //
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/show/user_created/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"我的秀 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            NSLog(@"我的秀%@",responseObject);
            NSArray *showArray = [responseObject objectForKey:@"shows"];
            for (NSDictionary *dic in showArray) {
                ShowDetailModel *showModel = [[ShowDetailModel alloc]initContentWithDic:dic];
                [self.data addObject:showModel];
            }
            
        }
        
        
        [self.myCollection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我的秀error code %ld",(long)[operation.response statusCode]);
        
    }];

    
    
    
}
-(void)initCreatCollect
{
    UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;//竖滚动
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing = 10;
    _myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight) collectionViewLayout:flowlayout];
    _myCollection.delegate = self;
    _myCollection.dataSource = self;
    _myCollection.backgroundColor = YTHColor(255, 255, 255);
    
    _myCollection.scrollEnabled = YES;
    [self.view addSubview:_myCollection];
   
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.data[indexPath.row];
       return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (threeInch || fourInch) {
        return CGSizeMake(145, 200);
    }    else{
        return CGSizeMake((YTHScreenWidth-70)/3, 180);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 20, 20, 20);
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
