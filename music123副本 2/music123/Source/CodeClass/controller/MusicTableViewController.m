//
//  MusicTableViewController.m
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicTableViewController.h"

@interface MusicTableViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)UIActivityIndicatorView *ac;
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,assign)BOOL isSearching;

@property (nonatomic,strong)NSMutableArray *song;
@property (nonatomic,strong)NSMutableArray *searchSongs;

@end

@implementation MusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[MusicPlayerTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self p_search];
    
    self.dataArr = [NSArray array];
    
    [[GetDataTools shareMusicData]getModelWithURL:kURL PassValue:^(NSArray *array) {
        self.dataArr = array;
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
    [self p_Activity];
   // [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]]];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"] highlightedImage:[UIImage imageNamed:@"1.jpg"]];
    [self.tableView setBackgroundView:image];
}

#pragma mark 添加搜索栏
- (void)p_search
{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.searchBar.searchResultsButtonSelected = YES;
    self.searchBar.placeholder = @"Please input key word...";
    self.searchBar.keyboardType = UIKeyboardTypeAlphabet; // 键盘类型
    self.searchBar.autocapitalizationType = UITextAutocorrectionTypeYes; // 自动纠错类型
    // self.searchBar.showsCancelButton = YES;  // 显示取消按钮
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;  // 让其头部显示
}

#pragma mark 搜索框代理 
#pragma mark  取消搜索
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearching = NO;
    self.searchBar.text = @"";
    [self.tableView reloadData];
}
/*
#pragma mark  输入搜索关键字
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([self.searchBar.text isEqual:@""]) {
        self.isSearching = NO;
        [self.tableView reloadData];
        return;
    }
    [self searchDataWithKewWord:_searchBar.text];
}

#pragma mark  点击虚拟键盘上的搜索时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchDataWithKewWord:_searchBar.text];
    [self.searchBar resignFirstResponder]; // 放弃第一响应对象 ，关闭虚拟键盘
}
 */
/*
#pragma mark  搜索形成新数据
- (void)searchDataWithKewWord:(NSString *)keyWord
{
    
    self.isSearching = YES;
    self.searchSongs = [NSMutableArray array];
    [self.song enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Music *m = obj;
        [m.timeLyric enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableArray *arr  = [[MusicPlayerViewController sharePlayMusic]getMusicLyricArray];
            Music *m = obj;
            if ([m.timeLyric.firstName.uppercaseString containsString:keyWord.uppercaseString]||[contact.lastName.uppercaseString containsString:keyWord.uppercaseString]||[contact.phoneNumber containsString:keyWord]) {
                [_searchContacts addObject:contact];
            }
        }];
    }];
    
    //刷新表格
    [self.tableView reloadData];
}
 */
- (void)p_Activity
{
    self.ac = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.ac.center = CGPointMake(100, 100);
    [self.view addSubview:_ac];
    self.ac.color = [UIColor purpleColor];
    // [self.ac startAnimating];
    // self.ac.hidden = NO;
    
    // [self.ac stopAnimating];
    
    [self.ac setHidesWhenStopped:YES];
    self.ac.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerViewController *music = [MusicPlayerViewController shareMusic];
    music.index = indexPath.row;
    [self.navigationController pushViewController:music animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
