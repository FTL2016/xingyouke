//
//  AttentionViewController.m
//  Starucan
//
//  Created by vgool on 16/1/11.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "AttentionViewController.h"
#import "AttentionCollectionViewCell.h"
#import "ZxlDataServiece.h"
#import "attenModel.h"
@interface AttentionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * myCollection;
@property(nonatomic,strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *arrBools;
@property (nonatomic, weak) UIButton *finishButton;



@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initFinishButton];
    [self initCreatCollect];
    self.arrBools = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
    self.data = [[NSMutableArray alloc]init];
    NSDictionary *jasonDic = [ZxlDataServiece requestData:@"movie163_detail"];
    NSArray *cinemaList = [jasonDic objectForKey:@"seckill"];
   
    for (NSDictionary *dic in cinemaList)
    {
        attenModel *attontionModel = [[attenModel alloc]initContentWithDic:dic];
        [self.data addObject:attontionModel];
        [self.myCollection reloadData];
        
    }
    [self.myCollection reloadData];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedBtnReceivedNotif) name:@"SelectedButtonClicked" object:nil];
}
-(void)initFinishButton
{
    UIButton  *finishButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 420, YTHScreenWidth-30, 40)];
    finishButton.layer.borderColor = YTHColor(200, 200, 200).CGColor;
    [finishButton.layer setMasksToBounds:YES];
    [finishButton.layer setCornerRadius:4.5];
    finishButton.layer.borderWidth = 1;
    finishButton.backgroundColor = [UIColor orangeColor];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    
    [finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.finishButton = finishButton;
    
    [self.view addSubview:finishButton];

}
-(void)initCreatCollect
{
    UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc]init];
   
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;//竖滚动
    _myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, YTHScreenWidth, 350) collectionViewLayout:flowlayout];
    _myCollection.delegate = self;
    _myCollection.dataSource = self;
    _myCollection.backgroundColor = YTHColor(255, 255, 255);
    
    _myCollection.scrollEnabled = YES;
    [self.view addSubview:_myCollection];
    [_myCollection registerClass:[AttentionCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttentionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.attentionModel = self.data[indexPath.row];

    //cell.backgroundColor = [UIColor orangeColor];
//    cell.layer.borderColor = YTHColor(200, 200, 200).CGColor;
//   
//    [cell.layer setCornerRadius:4.5];
//    cell.layer.borderWidth = 1;
    UIButton *btn = self.arrBools[indexPath.row];
    
    if (self.data.count > 0) {
        [self.arrBools replaceObjectAtIndex:indexPath.row withObject:cell.selectButton];
    }

    return cell;
    
    //cell.labelName = self.guessData[indexPath.row];
    
    
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
- (void)selectedBtnReceivedNotif
{
    for (int i = 0; i < self.data.count; i++) {
                attenModel *model = (attenModel *)self.data[i];
        NSString *str2 = model.seckill_name;
               NSLog(@"%@",str2
              );
    }
}
-(void)finishButtonAction:(UIButton *)btn
{
    
      NSMutableArray *shopCarts = [NSMutableArray array];
    for (int i = 0; i < self.data.count ; i++) {
        attenModel *model = (attenModel *)self.data[i];
        UIButton *selectbtn = self.arrBools[i];
        if (selectbtn.selected) {
            NSString *str2 = model.seckill_name;
            NSLog(@"%@",str2
                  );
            [shopCarts addObject:model];
        }
       
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
