//
//  CollectListViewController.m
//  MusicPlayer
//
//  Created by szt on 16/5/20.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "CollectListViewController.h"
#import "SongLocal.h"
#import "SongLocalCell.h"
#import "SongLocalFrame.h"

@interface CollectListViewController()
/**收藏列表*/
@property(nonatomic, strong)NSMutableArray *collectList;
@end

@implementation CollectListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"收藏";
    
    // 没有内容的cell隐藏分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = v;
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
    NSArray *collectList = [SongLocal objectArrayWithKeyValuesArray:[FileTools readPlistFromLocal:CollectMusicList]];
    self.collectList = (NSMutableArray *)collectList;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SongLocalCell *cell = [SongLocalCell cellWithTableView:tableView];
    
    SongLocalFrame *songLocalFrame = [[SongLocalFrame alloc] init];
    songLocalFrame.songLocal = self.collectList[indexPath.row];
    
    cell.songLocalFrame = songLocalFrame;
    
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SongLocalFrame *songLocalFrame = [[SongLocalFrame alloc] init];
    songLocalFrame.songLocal = self.collectList[indexPath.row];
    
    return songLocalFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
