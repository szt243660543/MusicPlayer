//
//  SingerSongsViewController.m
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingerSongsViewController.h"
#import "Singer.h"
#import "SingleModel.h"
#import "SingerSongCell.h"
#import "SingerSongFrame.h"
#import "MusicListenController.h"

// 音乐请求地址
#define MusicURLPath @"http://tingapi.ting.baidu.com/v1/restserver/ting"

@interface SingerSongsViewController ()
{
    // 每次加载的数量
    int songNums;
}
/**歌手的模型数组*/
//@property(nonatomic, strong)SingleModel *singleModel;
/**Singer*/
@property(nonatomic, strong)Singer *singer;
/**音乐清单*/
@property(nonatomic, strong)NSMutableArray *songList;
@end

@implementation SingerSongsViewController

- (NSMutableArray *)songList
{
    if (!_songList)
    {
        self.songList = [[NSMutableArray alloc] init];
    }
    
    return _songList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *tinguid = [NSString stringWithFormat:@"%lld",self.singleModel.ting_uid];
    
    // 设置导航
    [self setupNav];
    
    // 下拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 网络请求
        [self AFNetworking:tinguid];
        // 网络请求
        //[self MKNetworkKit:singleModel.ting_uid];
    }];
    
    [self.tableView.mj_footer beginRefreshing];
    
    // 没有内容的cell隐藏分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = v;

    // 取消效果线
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
}

// 设置导航
- (void)setupNav
{
    NSString *str = [NSString stringWithFormat:@"%@(一共有%d首歌曲)",self.singleModel.name,self.singleModel.songs_total];
    self.title = str;
}

// AFNetworking网络请求
- (void)AFNetworking:(NSString *)uid
{
    AFHTTPRequestOperationManager  *mgr = [AFHTTPRequestOperationManager manager];
    
    // 设置相应内容类型
    // mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"from"]     = @"android";
    params[@"version"]  = @"2.4.0";
    params[@"method"]   = @"baidu.ting.artist.getSongList";
    params[@"format"]   = @"json";
    params[@"order"]    = @"2";
    params[@"tinguid"]  = uid;
    params[@"offset"]   = @"0";
    params[@"limits"]   = [NSString stringWithFormat:@"%d", songNums+=20];  // 一次获取的数据数
    
    // 发送请求
    [mgr GET:MusicURLPath parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // SZTLog(@"%@",responseObject);
        // 停止刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 通过字典数组来创建一个模型数组
        NSArray *singers = [Singer objectArrayWithKeyValuesArray:responseObject[@"songlist"]];
        self.songList = (NSMutableArray *)singers;
        
        // 刷新数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SZTLog(@"%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingerSongCell *cell = [SingerSongCell cellWithTableView:tableView];
    
    SingerSongFrame *singerSongFrame = [[SingerSongFrame alloc] init];
    singerSongFrame.singer = self.songList[indexPath.row];
    
    cell.singerSongFrame = singerSongFrame;
    
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingerSongFrame *singerSongFrame = [[SingerSongFrame alloc] init];
    singerSongFrame.singer = self.songList[indexPath.row];
    
    return singerSongFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.主动取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Singer *singer = self.songList[indexPath.row];
    self.singer = singer;
    
    // 跳转页面
    MusicListenController *musicListenVc = [MusicListenController shareMusicListenController];
    [self.navigationController pushViewController:musicListenVc animated:YES];
    // 赋值
    musicListenVc.singer = singer;
    musicListenVc.index = indexPath.row;
    musicListenVc.songList = self.songList;
    
    // 通知
    NSNotification *notice = [NSNotification notificationWithName:@"stopNetMusic" object:nil];
    [NotificationCenter postNotification:notice];
}

@end
