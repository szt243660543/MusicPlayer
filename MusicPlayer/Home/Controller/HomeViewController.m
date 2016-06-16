//
//  HomeViewController.m
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "HomeViewController.h"
#import "SongLocal.h"
#import "SongLocalCell.h"
#import "SongLocalFrame.h"
#import "MusicListenLocalController.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController()
/**歌曲列表*/
@property(nonatomic, strong)NSMutableArray *songList;
@end

@implementation HomeViewController

-(NSMutableArray *)songList
{
    if (!_songList)
    {
        self.songList = [[NSMutableArray alloc] init];
    }
    
    return _songList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 没有内容的cell隐藏分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = v;
    
    // 设置导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 加载数据
    [self setupData];
}

-(void)setupData
{
    // 通过字典数组来创建一个模型数组
    NSArray *songList = [SongLocal objectArrayWithKeyValuesArray:[FileTools readPlistFromLocal:LocalMusicList]];
    self.songList = (NSMutableArray *)songList;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SongLocalCell *cell = [SongLocalCell cellWithTableView:tableView];
    
    SongLocalFrame *songLocalFrame = [[SongLocalFrame alloc] init];
    songLocalFrame.songLocal = self.songList[indexPath.row];
    
    cell.songLocalFrame = songLocalFrame;
    
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SongLocalFrame *songLocalFrame = [[SongLocalFrame alloc] init];
    songLocalFrame.songLocal = self.songList[indexPath.row];
    
    return songLocalFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicListenLocalController *musicListenLocalVc = [MusicListenLocalController shareMusicListenLocalController];
    [self.navigationController pushViewController:musicListenLocalVc animated:YES];
    
    SongLocal *songLocal = self.songList[indexPath.row];
    musicListenLocalVc.songLocal = songLocal;
    musicListenLocalVc.index = indexPath.row;
    musicListenLocalVc.songList = self.songList;
    
    // 通知
    NSNotification *notice = [NSNotification notificationWithName:@"stopLocalMusic" object:nil];
    [NotificationCenter postNotification:notice];
}

@end
