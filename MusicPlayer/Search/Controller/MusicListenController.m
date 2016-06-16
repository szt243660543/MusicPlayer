//
//  MusicListenController.m
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "MusicListenController.h"
#import "Song.h"
#import "SongData.h"
#import "MusicsPlayer.h"
#import "SongLocal.h"
#import "CollectListViewController.h"

@interface MusicListenController()
/**创建播放器*/
@property(nonatomic, strong)MusicsPlayer *musicsPlayer;
@end

@implementation MusicListenController

+(MusicListenController *)shareMusicListenController
{
    static MusicListenController * musicListenController;
    
    if (musicListenController == nil) {
        
        musicListenController = [[MusicListenController alloc] init];
    }
    
    return musicListenController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    // 设置视图
    [self setupView];
    
    // 通知
    [NotificationCenter addObserver:self selector:@selector(Networking) name:@"stopNetMusic" object:nil];
    
    // 网络请求
    [self AFNetworking:self.singer.song_id];
}

// 设置视图
- (void)setupView
{
    // 创建播放器view
    MusicsPlayer * musicsPlayer = [[MusicsPlayer alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height, self.view.width, self.view.height - self.navigationController.navigationBar.height)];
    [self.view addSubview:musicsPlayer];
    musicsPlayer.isNet = YES;
    self.musicsPlayer = musicsPlayer;
    musicsPlayer.delegate = self;
    
    // 赋值
    musicsPlayer.songList = self.songList;
    musicsPlayer.index = self.index;
    
    // 歌名
    self.title = self.singer.title;
}

#pragma mark -- 网络请求
// 网络请求
- (void)AFNetworking:(long long)songid
{
    AFHTTPRequestOperationManager  *mgr = [AFHTTPRequestOperationManager manager];
    
    // 设置相应内容类型
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    
    NSString *urlPath = @"http://ting.baidu.com/data/music/links";
    NSString *song_id = [NSString stringWithFormat:@"%lld",songid];
    
    // 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"songIds"] = song_id;
    
    // 发送请求
    [mgr GET:urlPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // SZTLog(@"%@",responseObject);
        // 通过字典来创建一个模型
        SongData *songData = [SongData objectWithKeyValues:responseObject[@"data"]];
        Song *song = songData.songList[0];
        
        SongLocal *songLocal = [[SongLocal alloc] init];
        songLocal.artistName = song.artistName;
        songLocal.songName = song.songName;
        songLocal.songPicBig = song.songPicBig;
        songLocal.songPicRadio = song.songPicRadio;
        songLocal.song_url = [self getUrl:song.songLink Data:songData.xcode];
        songLocal.song_pre = [NSString stringWithFormat:@"%lld%lld", self.singer.ting_uid, self.singer.song_id];
        songLocal.time = [NSNumber numberWithInt:song.time];
        
        // 赋值
        self.musicsPlayer.songLocal = songLocal;
        self.musicsPlayer.singer = self.singer;

        // 加载url
        [self.musicsPlayer setupUrl];
        // 加载图片
        [self.musicsPlayer setupPic];
        // 播放歌曲
        [self.musicsPlayer startMusic];
        // 开始时间
        [self.musicsPlayer startTimer];
        // 切换歌词
        [self.musicsPlayer setupLrc];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SZTLog(@"%@",error);
    }];
}

- (void)Networking
{
    self.title = self.singer.title;
    
    // 网络请求
    [self AFNetworking:self.singer.song_id];
}

- (NSString *)getUrl:(NSString *)songlink Data:(NSString *)data
{
    //匹配得到的下标
    NSRange range = [songlink rangeOfString:@".mp3"];
    
    if (range.length !=0) {
        NSString *subPath = [songlink substringToIndex:range.location + 5];
        NSString *url = [NSString stringWithFormat:@"%@xcode=%@",subPath, data];

        return url;
    }
    
    return nil;
}

#pragma mark -- MusicsPlayerDelegate
- (void)MusicsPlayerView:(MusicsPlayer *)view preSwitchMusic:(UIButton *)pre index:(NSInteger)index
{
    [self setPlayMusicInfo:index];
    
}

- (void)MusicsPlayerView:(MusicsPlayer *)view nextSwitchMusic:(UIButton *)next index:(NSInteger)index
{
    [self setPlayMusicInfo:index];
}

- (void)MusicsPlayerView:(MusicsPlayer *)view randomIndex:(NSInteger)index
{
    [self setPlayMusicInfo:index];
}

- (void)MusicsPlayerView:(MusicsPlayer *)view lockIndex:(NSInteger)index
{
    [self setPlayMusicInfo:index];
}

- (void)setPlayMusicInfo:(NSUInteger)index
{
    Singer *singer = self.songList[index];
    
    self.singer = singer;
    
    self.title = singer.title;
    
    [self AFNetworking:singer.song_id];
}

- (void)MusicsPlayerView:(MusicsPlayer *)view playListMusic:(UIButton *)btn
{
    CollectListViewController * collectListVc = [[CollectListViewController alloc] init];
    [self.navigationController pushViewController:collectListVc animated:YES];
}

@end
