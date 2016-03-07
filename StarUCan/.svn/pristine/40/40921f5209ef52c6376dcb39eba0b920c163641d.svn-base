//
//  AddLabelViewController.m
//  Starucan
//
//  Created by vgool on 16/1/16.
//  Copyright © 2016年 vgool. All rights reserved.
//

#import "AddLabelViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LabelModel.h"
#import "AppDelegate.h"
#import "NSData+AES256.h"
@interface AddLabelViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar * mySearchBar;
    UIView * grayView;
    int start;
    int count;
    AppDelegate *myDelegate;
    UILabel *label;
    
}
@property(nonatomic,strong)UITableView *tableView;
@property (weak, nonatomic) UITableView *resultTableView;//结果
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AddLabelViewController
//-(NSMutableArray *)saveGoodsNameArray
//{
//    if (!_dataArr) {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}
- (UITableView *)resultTableView
{
    if (!_resultTableView) {
        UITableView *resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, YTHScreenWidth, YTHScreenHeight-64) style:UITableViewStylePlain];
        _resultTableView = resultTableView;
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_resultTableView];
    }
    return _resultTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!myDelegate) {
        myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    start = 1;
    count = 6;
    //创建搜索栏
    [self _initSearchBar];
    //创建tableview
    [self _initTableView];
    
    
}
#pragma mark -请求标签数据
-(void)requestData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"start"] = [NSString stringWithFormat:@"%d",start];
    md[@"count"] =[NSString stringWithFormat:@"%d",count];
    md[@"name"] = mySearchBar.text;
    NSString *url1 = Url;
    NSString *url =[NSString stringWithFormat:@"%@v1/label",url1];
    
    [manager GET:url parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"标签信息%@",responseObject);
        NSLog(@"标签返回error code %ld",(long)[operation.response statusCode]);
        if ([operation.response statusCode]/100==2)
        {
            NSArray *arry = [responseObject objectForKey:@"labels"];
            //            if (!_kIdMutabDict) {
            //                _kIdMutabDict = [[NSMutableDictionary alloc]init];
            //            }
            [myDelegate.labelIDict removeAllObjects];
            for (NSDictionary *dic in arry)
            {
                
                [myDelegate.labelIDict setObject:[dic objectForKey:@"uuid"] forKey:[dic objectForKey:@"name"]];
                [self.dataArr addObject: [dic objectForKey:@"name"]];
                
            }
            NSLog(@"个数个数%lu",(unsigned long)self.dataArr.count);
        }
        
        [self.resultTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"标签错误error code %ld",(long)[operation.response statusCode]);
    }];
    
}



#pragma mark - 创建搜索栏
-(void)_initSearchBar
{
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(16, 7, YTHScreenWidth-32, 30)];
    mySearchBar.delegate = self;
    mySearchBar.placeholder = @"输入标签";
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    mySearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:mySearchBar.bounds.size];
    [mySearchBar.layer setMasksToBounds:YES];
    [mySearchBar.layer setCornerRadius:4.5];
    mySearchBar.layer.borderColor = YTHColor(255, 69, 82).CGColor;
    mySearchBar.layer.borderWidth = 0.8;
    [self.view addSubview:mySearchBar];
}
#pragma mark - uitable
-(void)_initTableView
{
    UITableView *tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 92, YTHScreenWidth, YTHScreenHeight)style:UITableViewStylePlain];
    tableView.dataSource =self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

#pragma mark-uitable代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableView) {
        return 1;
    }else{
        if (self.dataArr.count!=0) {
            NSLog(@"标签个数%lu",(unsigned long)self.dataArr.count);
            return self.dataArr.count+1;
        }
        return 1;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    if (tableView==self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        return cell;
    }else{
        static NSString *cellId = @"mycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        if (indexPath.row==0) {
            label.text = @"";
            cell.textLabel.text = @"添加标签";
            label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 44)];
            label.text = mySearchBar.text;
            label.textColor = [UIColor blackColor];
            [cell addSubview:label];
        }else{
            if (self.dataArr.count!=0) {
                NSString *text  =self.dataArr[indexPath.row-1];
                cell.textLabel.text=text;
            }else {
                cell.textLabel.text = @"添加标签";
            }
        }
        NSLog(@"-----%@",self.dataArr);
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_resultTableView) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row==0) {
            
            NSMutableDictionary *md = [NSMutableDictionary dictionary];
            md[@"name"]=mySearchBar.text;
            NSString *urlShow = @"v1/label";
            NSString *text = [NSData AES256EncryptWithPlainText:urlShow passtext:myDelegate.accessToken];
            NSLog(@"登录密码=%@",myDelegate.accessToken);
            NSLog(@"taken=%@",text);
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            //请求头
            [manager.requestSerializer setAuthorizationHeaderFieldWithToken:text];
            [manager.requestSerializer setValue:myDelegate.account forHTTPHeaderField:@"account"];
            NSString *uS = Url;
            NSString *urlStr = [NSString stringWithFormat:@"%@v1/label",uS];
            NSLog(@"拼接之后%@",urlStr);
            [manager POST:urlStr parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"新增标签信息%@",responseObject);
                NSLog(@"新增标签返回error code %ld",(long)[operation.response statusCode]);
                if ([operation.response statusCode]/100==2)
                {
                    NSDictionary *dic = [responseObject objectForKey:@"label"];
                    //  [myDelegate.labelIDict removeAllObjects];
                    NSLog(@"**%@",myDelegate.labelIDict);
                    [myDelegate.labelIDict setObject:[dic objectForKey:@"uuid"] forKey:[dic objectForKey:@"name"]];
                    if ([self.delegate respondsToSelector:@selector(AddLabelView:didClickTag:didClickTitle:)]) {
                        [self.delegate AddLabelView:self didClickTag:[dic objectForKey:@"uuid"] didClickTitle:mySearchBar.text];
                    }
                }
                
                label.text = @"";
                [self.resultTableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"新增标签错误返回error code %ld",(long)[operation.response statusCode]);
                
            }];
            
        }else
        {
            if ([self.delegate respondsToSelector:@selector(AddLabelView:didClickTag:didClickTitle:)]) {
                NSString *key = self.dataArr[indexPath.row-1];
                [self.delegate AddLabelView:self didClickTag:[myDelegate.labelIDict objectForKey:key] didClickTitle:cell.textLabel.text];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark-SearchBar代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"任务编辑文本");
    grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    grayView.alpha = 0.5;
    grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:grayView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cacell)];
    [grayView addGestureRecognizer:tap];
    return YES;
}
-(void)cacell
{
    grayView.hidden = YES;
    mySearchBar.showsCancelButton = NO;
    [mySearchBar endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    NSLog(@"开始编辑");
    mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    subViews = [(mySearchBar.subviews[0]) subviews];
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    mySearchBar.text = @"";
    grayView.hidden = YES;
    mySearchBar.showsCancelButton = NO;
    [searchBar endEditing:YES];
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"要求");
    if (mySearchBar.text.length > 0) {
        // 创建搜索结果显示的tableView
        [self.resultTableView reloadData];
        [self.tableView removeFromSuperview];
    } else {
        [self.resultTableView removeFromSuperview];
    }
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    NSLog(@"当编辑完成之后调用此函数");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //    NSLog(@"当textView的文本改变或者清除的时候调用此方法：%@",searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestData];
    NSLog(@"点击按钮");
    [mySearchBar resignFirstResponder];//这句话时让search失去焦点的意思
    //    [mySearchBar endEditing:YES];
    grayView.hidden = YES;
    mySearchBar.showsCancelButton = NO;
    
    NSLog(@"搜索词%@",searchBar.text);
    
    
    
}
//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
