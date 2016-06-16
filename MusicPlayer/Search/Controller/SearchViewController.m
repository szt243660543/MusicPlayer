//
//  SearchViewController.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SearchViewController.h"
#import "SingleData.h"
#import "SingleModel.h"
#import "SingleCell.h"
#import "SingleFrame.h"
#import "SingerSongsViewController.h"
#import "SearchBar.h"
#import "MusicListenController.h"
#import "MusicListenLocalController.h"

@interface SearchViewController ()
{
    NSOperationQueue *queue;
    NSMutableArray *arrays;
}

/**singleModel*/
@property(nonatomic, strong)SingleModel *singleModel;
/***searchBar*/
@property(nonatomic, strong)SearchBar *searchBar;
/**是否正在播本地音乐*/
@property(nonatomic, assign)BOOL isLocalMusic;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    
    // 设置导航栏内容
    [self setupNav];
    
    // 设置搜索框
    [self setupSearchBar];
    
    // 设置数据库数据
    [self setupSqliteSource];
    
    // 判断当前播放的歌曲是否是本地
    [NotificationCenter addObserver:self selector:@selector(isLocalMusic:) name:@"isLocalMusic" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.searchBar)
    {
        self.searchBar.hidden = NO;
    }
}

#pragma mark 导航栏内容
/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    // 设置导航栏上面的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_music"] style:UIBarButtonItemStylePlain target:self action:@selector(music)];
    
    // 设置标题
    self.navigationItem.title = @"搜索音乐";
    
    // 设置导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
    
    // 没有内容的cell隐藏分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = v;
}

- (void)music
{
    // 隐藏
    self.searchBar.hidden = YES;

    // 跳转页面
    if (self.isLocalMusic) {
        MusicListenController *musicListenVc = [MusicListenController shareMusicListenController];
        [self.navigationController pushViewController:musicListenVc animated:YES];
    }
    else
    {
        MusicListenLocalController *musicListenVc = [MusicListenLocalController shareMusicListenLocalController];
        [self.navigationController pushViewController:musicListenVc animated:YES];
    }
}

- (void)isLocalMusic:(NSNotification *)notification
{
    self.isLocalMusic = [notification.userInfo[@"isLocal"] boolValue];
}

// 设置搜索框
- (void)setupSearchBar
{
    queue = [[NSOperationQueue alloc] init];
    arrays = [[NSMutableArray alloc] init];
    
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.frame = CGRectMake(0, 63, self.tableView.width, 44);
    [self.parentViewController.view addSubview:searchBar];
    // 设置是否启动自动提醒更正功能
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // 实时监听值改变
    [searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // 设置代理
    searchBar.delegate = self;
    
    self.searchBar = searchBar;
}

#pragma mark - UITextFieldDelegate
//当开始点击textField会调用的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    SZTLog(@"当开始点击textField会调用的方法");
}

//当textField编辑结束时调用的方法
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    SZTLog(@"当textField编辑结束时调用的方法");
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    SZTLog(@"按下Done按钮的调用方法，我们让键盘消失");
    [textField resignFirstResponder];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        // 根据搜索信息获取歌曲模型数组
        musicInfos = [self getSingerModelArray:textField.text style:SearchStyleDefault musicNum:5];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if(musicInfos.count > 0)
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        });
    }];
    
    [queue addOperation:operation];
    
    return YES;
}

// 值发生改变
- (void)textFieldDidChange:(UITextField *)textField
{
//    NSLog(@"%@,%lu",textField.text,textField.text.length);

    // 获取歌曲信息
    [self getSingerData:textField.text];
}

// 获取歌曲信息
- (void)getSingerData:(NSString *)text
{
    // 根据搜索信息获取歌曲模型数组
    __block NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        // 根据搜索信息获取歌曲模型数组
        musicInfos = [self getSingerModelArray:text style:SearchStyleHot musicNum:5];
        
        if (operation == [arrays lastObject])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                if(musicInfos.count > 0)
                {
                    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            });
        }
    }];
    
    [queue addOperation:operation];
    [arrays addObject:operation];
}

#pragma mark 数据库数据
/**
 * 设置数据库数据
 */
- (void)setupSqliteSource
{
    musicInfos = [[NSMutableArray alloc] init];

    // 根据搜索信息获取歌曲模型数组
    musicInfos = [self getSingerModelArray:@"" style:SearchStyleRandom musicNum:50];
}

// 根据搜索信息获取歌曲模型数组
- (NSMutableArray *)getSingerModelArray:(NSString *)searchInfo style:(SearchStyle )style musicNum:(int)num
{
    NSMutableArray *musicsTemp = [NSMutableArray array];
    NSMutableArray *musics = [NSMutableArray array];

    SingleData *musicInfo = [[SingleData alloc] init];
    if (searchInfo == nil || [searchInfo isEqual: @""])
    {
        musics = [musicInfo itemWithHot:num];
    }
    else
    {
        musics = [musicInfo itemWith:searchInfo type:style musicNum:num];
    }
    
    for (int i = 0;i < musics.count;i++)
    {
        SingleModel *singleInfo = [SingleModel singleWithData:musics[i]];
        
        [musicsTemp addObject:singleInfo];
    }

    return musicsTemp;
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return musicInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleCell * cell = [SingleCell cellWithTableView:tableView];

    SingleFrame *singleFrame = [[SingleFrame alloc] init];
    singleFrame.singleModel = musicInfos[indexPath.row];
    
    cell.singleFrame = singleFrame;
    
    return cell;
}

#pragma mark - 代理
// cell的高度取决于内容的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleFrame *singleFrame = [[SingleFrame alloc] init];
    singleFrame.singleModel = musicInfos[indexPath.row];
    
    return singleFrame.cellHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.主动取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.searchBar resignFirstResponder];
    
    // 隐藏
    self.searchBar.hidden = YES;
    
    SingleModel *singleModel = musicInfos[indexPath.row];
    self.singleModel = singleModel;
    
    // 跳转页面
    SingerSongsViewController *singerSongsVc = [[SingerSongsViewController alloc] init];
    [self.navigationController pushViewController:singerSongsVc animated:YES];
    singerSongsVc.singleModel = singleModel;
}

@end
