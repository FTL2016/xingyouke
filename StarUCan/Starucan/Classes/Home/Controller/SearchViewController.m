//
//  SearchViewController.m
//  Starucan
//
//  Created by vgool on 15/12/31.
//  Copyright © 2015年 vgool. All rights reserved.
//

#import "SearchViewController.h"
#import "UINavigationItem+CustomItem.h"
#import "SearchClassViewController.h"
@interface SearchViewController ()<UISearchBarDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *view;
    UITableView *_tableViewSearchResult; //显示搜索记录的tableView
    NSMutableArray *filterData;
    NSMutableArray *pinyinData;
    NSMutableArray *data;


}
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *hotWords;
@property (weak, nonatomic) UITableView *resultTableView;
@property (nonatomic,strong)NSMutableArray *saveGoodsNameArray; //存取搜索的关键字

@end

@implementation SearchViewController
-(NSMutableArray *)saveGoodsNameArray
{
    if (!_saveGoodsNameArray) {
        _saveGoodsNameArray = [NSMutableArray array];
    }
    return _saveGoodsNameArray;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        self.scrollView.frame = CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight);
        [self.view addSubview:_scrollView];
    }
     return _scrollView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        // 搜索框
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth-80, 40)];
        searchBar.placeholder = @"搜索昵称/学校/关键字";
        searchBar.delegate = self;
        searchBar.tintColor = YTHColor(100, 100, 100);
        [searchBar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        searchBar.backgroundImage = [UIImage imageNamed:@"ui_searchbar_back"];
        _searchBar = searchBar;
    }
    return _searchBar;
}
- (NSArray *)hotWords
{
    if (!_hotWords) {
        _hotWords = [[NSArray alloc] initWithObjects:@"新三国",@"三国志",@"完美世界 ",@"ios开发指南",@"西门吹雪",@"微微一笑很倾城",@"快看看",@"大数据",@"一杆禽兽狙",@"国破山河在",@"暴走大事件",@"非诚勿扰",@"最美的时光", nil];
    }
    return _hotWords;
}
- (UITableView *)resultTableView
{
    if (!_resultTableView) {
        UITableView *resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YTHScreenWidth, YTHScreenHeight-64) style:UITableViewStylePlain];
        _resultTableView = resultTableView;
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_resultTableView];
    }
    return _resultTableView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

  
   
    [_tableViewSearchResult reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveGoodsNameArray removeAllObjects];
    //    //存取搜索结果
    
    // 取出文件
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataArr = [defaults objectForKey:@"searchHistory"];
    [self.saveGoodsNameArray addObjectsFromArray:dataArr];
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YTHScreenWidth, 190)];
    view.backgroundColor = YTHBaseVCBackgroudColor;
    [self.scrollView addSubview:view];
    UILabel *historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame), 100, 30)];
    historyLabel.text = @"历史搜索";
    historyLabel.textColor = [UIColor grayColor];
    historyLabel.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:historyLabel];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏
    [self creatNavgationItem];
    //热词
    [self creatHotWord];
    //初始化搜索结果的视图
    [self initSearchReaultTableView];
    
    
}
- (void)initSearchReaultTableView
{
    //tableView的height应该是动态改变的
    _tableViewSearchResult = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, YTHScreenWidth,YTHScreenHeight) style:UITableViewStylePlain];
    _tableViewSearchResult.delegate = self;
    _tableViewSearchResult.dataSource = self;
   
    // _tableViewSearchResult.sectionHeaderHeight=150;
    [self.view addSubview:_tableViewSearchResult];
}
-(void)creatNavgationItem
{
    // 取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, 0, 40, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [cancelBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    // 搜索框
    [self.navigationItem setItemWithCustomView:self.searchBar itemType:left];
    [NSThread detachNewThreadSelector:@selector(hanzi2pinyin) toTarget:self withObject:nil];
    data = [NSMutableArray arrayWithObjects:@"新三国",@"三国志",@"完美世界 ",@"ios开发指南",@"西门吹雪",@"微微一笑很倾城",@"快看看",@"大数据",@"一杆禽兽狙",@"国破山河在",@"暴走大事件",@"非诚勿扰",@"最美的时光", nil];
    filterData = [NSMutableArray array];

    
}
- (void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
/**
 *  热词界面
 */
- (void)creatHotWord
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    label.text = @"大家都在搜";
    //label.backgroundColor = [UIColor yellowColor];
    label.textColor= [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 40;//用来控制button距离父视图的高
    for (int i = 0; i < self.hotWords.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag =  i;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius =4.5; //设置圆角——四个圆角半径
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor whiteColor].CGColor;//按钮边框颜色
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
       
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [self.hotWords[i] boundingRectWithSize:CGSizeMake(YTHScreenWidth-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:self.hotWords[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 30);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(10 + w + length + 15 > YTHScreenWidth){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [view addSubview:button];
        // view.backgroundColor = [UIColor yellowColor];
        button.tag =  i;
        [button addTarget:self action:@selector(clickHotBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark -UITableView的代理方法-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableViewSearchResult) {
        return _saveGoodsNameArray.count+1;
    }else
    {
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith [cd] %@",self.searchBar.text];
        
        [filterData removeAllObjects];
        NSArray *temp;
        if (![self.searchBar.text isEqualToString:@""]) {
            unichar c = [self.searchBar.text characterAtIndex:0];
            // 判断是否为汉字
            if (c >=0x4E00 && c <=0x9FFF) {
                filterData = [NSMutableArray arrayWithArray:[data filteredArrayUsingPredicate:predicate]];
            } else {
                // 先搜索拼音
                temp = [[NSArray alloc] initWithArray:[pinyinData filteredArrayUsingPredicate:predicate]];
                // 找对应汉字的位置赋值
                for (NSString *str in temp) {
                    NSUInteger dex = [pinyinData indexOfObject:str];
                    [filterData addObject:data[dex]];
                }
            }
            return filterData.count;
        
        } else {
        
            return 0;
        
        }
    
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableViewSearchResult) {
        static NSString *reusableIndentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIndentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIndentifier];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row < _saveGoodsNameArray.count) {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.text = [_saveGoodsNameArray objectAtIndex:indexPath.row];
            cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
            
        }else if (indexPath.row == _saveGoodsNameArray.count){
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"清除历史记录";
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            cell.contentView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1.0];
        }
        
        return cell;
        
    }else{
        static NSString *cellId = @"mycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = filterData[indexPath.row];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableViewSearchResult) {
        if (indexPath.row == _saveGoodsNameArray.count) {
            //选中“清除历史记录”响应的方法
            [_saveGoodsNameArray removeAllObjects];
            [_tableViewSearchResult reloadData];
            [[NSUserDefaults standardUserDefaults] setObject:self.saveGoodsNameArray forKey:@"searchHistory"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else if(indexPath.row < _saveGoodsNameArray.count){
            
            //选中搜索出来的结果跳转到详情页
            SearchClassViewController *searchResultVC = [[SearchClassViewController alloc] init];
            
            [self.navigationController pushViewController:searchResultVC animated:YES];
            [self savaDataView:self.saveGoodsNameArray[indexPath.row]];
            
        }
        
    }else{
        
        SearchClassViewController *searchResultVC = [[SearchClassViewController alloc] init];
        
        [self.navigationController pushViewController:searchResultVC animated:YES];
        [self savaDataView:filterData[indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
#pragma mark-searchBarDelegte

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0) {
        // 创建搜索结果显示的tableView
        [self.resultTableView reloadData];
    } else {
        [self.resultTableView removeFromSuperview];
    }
}
/*键盘搜索按钮*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self savaDataView:searchBar.text];
    
    //    [_tableViewSearchResult reloadData];
    SearchClassViewController *searchClassVC = [[SearchClassViewController alloc] init];
    [self.navigationController pushViewController:searchClassVC animated:YES];
    [searchBar endEditing:YES];
}


-(void)savaDataView:(NSString *)text
{
    for (int i=0; i<self.saveGoodsNameArray.count; i++) {
        if ([self.saveGoodsNameArray[i] isEqualToString:text]) {
            [self.saveGoodsNameArray removeObjectAtIndex:i];
        }
    }
    [self.saveGoodsNameArray insertObject:text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:_saveGoodsNameArray forKey:@"searchHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];  //将搜索结果存入磁盘
    
}

- (void)clickHotBtn:(UIButton *)button
{
    
    [self savaDataView:button.title];
    [_tableViewSearchResult reloadData];
    
    SearchClassViewController *searchClassVC = [[SearchClassViewController alloc] init];
    [self.navigationController pushViewController:searchClassVC animated:YES];
    //[self saveData:button.title];
    YTHLog(@"点击了%@", button.title);
}
- (void)hanzi2pinyin
{
    // 将数组中的汉字转为拼音
    pinyinData = [NSMutableArray array];
    for (NSString *str in data) {
        [pinyinData addObject:[[self phonetic:str] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    
}
#pragma mark-中文转拼音
- (NSString *)phonetic:(NSString*)sourceString
{
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source;
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
