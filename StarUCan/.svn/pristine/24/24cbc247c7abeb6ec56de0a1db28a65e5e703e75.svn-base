//
//  MyTopicViewController.m
//  Starucan
//
//  Created by vgool on 16/1/28.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "MyTopicViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "NSData+AES256.h"
#import "MyShowTableViewCell.h"
#import "MyTopicLayoutFtame.h"
#import "ShowCommentModel.h"
#import "MyTopTableViewCell.h"
@interface MyTopicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *myDelegate;
    UIImageView *arrowImg;

}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MyTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    self.data = [[NSMutableArray alloc]init];
    self.title=@"我的话题";
    [self _initTableView];
    [self requestAtten];
}



#pragma mark-uitableView
-(void)_initTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight-64)style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableview = tableView;
    
    [self.view addSubview:tableView];
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 64)];
    NSArray *btnName = [NSArray arrayWithObjects:@"我发起的", @"我关注的", @"我参与的", nil];
    // 四个按钮
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(i*YTHScreenWidth/3, 0, YTHScreenWidth/3, 64);
        [btn setTitle:btnName[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewBg addSubview:btn];
    }
    self.tableview.tableHeaderView = viewBg;
    arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, viewBg.frame.size.width/3-10, 3)];
    arrowImg.backgroundColor = [UIColor redColor];
    arrowImg.tag=123;
    [viewBg addSubview:arrowImg];

}

- (void)selectedClick:(UIButton*)btn
{
    switch (btn.tag) {
        case 0:
            NSLog(@"我发起的");
        {
            
        }
            
            
            break;
        case 1:
        {
            NSLog(@"我关注的");
            [self.data removeAllObjects];
            [self requestMyatten];
            
        }
            break;
        case 2:
            NSLog(@"我参与的");
            [self.data removeAllObjects];
            [self requestAdd];
            
            break;
        default:
            break;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    arrowImg.center= btn.center;
    CGPoint center  =arrowImg.center;
    center.y = YTHAdaptation(63);
    arrowImg.center = center;
    [UIView commitAnimations];
}
#pragma mark - 我参与请求
-(void)requestAdd
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/topic/user_participated/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"我参与 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            NSLog(@"我参与%@",responseObject);
            NSArray *showArray = [responseObject objectForKey:@"topics"];
            for (NSDictionary *dic in showArray) {
                ShowCommentModel *showModel = [[ShowCommentModel alloc]initContentWithDic:dic];
                MyTopicLayoutFtame *myFrame = [[MyTopicLayoutFtame alloc]init];
                myFrame.model = showModel;
                [self.data addObject:myFrame];
            }
            
        }
        
        
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我参与error code %ld",(long)[operation.response statusCode]);
        
    }];
    

    
}
#pragma mark - 我关注请求
-(void)requestMyatten
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/topic/user_attented/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"我关注 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            NSLog(@"我关注%@",responseObject);
            NSArray *showArray = [responseObject objectForKey:@"topics"];
            for (NSDictionary *dic in showArray) {
                ShowCommentModel *showModel = [[ShowCommentModel alloc]initContentWithDic:dic];
                MyTopicLayoutFtame *myFrame = [[MyTopicLayoutFtame alloc]init];
                myFrame.model = showModel;
                [self.data addObject:myFrame];
            }
            
        }
        
        
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我关注error code %ld",(long)[operation.response statusCode]);
        
    }];

}
#pragma mark - 发话题请求
-(void)requestAtten
{
       AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       NSString *uS = Url;
    NSString *urlStr = [NSString stringWithFormat:@"%@v1/topic/user_created/%@",uS,[myDelegate.userInfo objectForKey:@"uuid"]];
    NSLog(@"拼接之后%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"我的话题 %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2) {
            NSLog(@"我的话题%@",responseObject);
            NSArray *showArray = [responseObject objectForKey:@"topics"];
            for (NSDictionary *dic in showArray) {
                ShowCommentModel *showModel = [[ShowCommentModel alloc]initContentWithDic:dic];
                MyTopicLayoutFtame *myFrame = [[MyTopicLayoutFtame alloc]init];
                myFrame.model = showModel;
                [self.data addObject:myFrame];
            }
            
        }
        
        
        [self.tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"我的话题error code %ld",(long)[operation.response statusCode]);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
    NSLog(@"行个数****888%lu",(unsigned long)self.data.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    
    static NSString *identify = @"kIdentifier";
    MyTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MyTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.myLayoutFrame = self.data[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath");
    MyTopicLayoutFtame *myTopF = self.data[indexPath.row];
    return myTopF.cellHeight;
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
