//
//  MusicListenLocalController.m
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "MusicListenLocalController.h"
#import "SongLocal.h"
#import "MusicsPlayer.h"
#import "CollectListViewController.h"

@interface MusicListenLocalController()
/**创建播放器*/
@property(nonatomic, strong)MusicsPlayer *musicsPlayer;
@end

@implementation MusicListenLocalController

+(MusicListenLocalController *)shareMusicListenLocalController
{
    static MusicListenLocalController * musicListenLocalController;
    
    if (musicListenLocalController == nil) {
        
        musicListenLocalController = [[MusicListenLocalController alloc] init];
    }
    
    return musicListenLocalController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置视图
    [self setupView];
}

// 设置视图
- (void)setupView
{
    // 创建播放器view
    MusicsPlayer * musicsPlayer = [[MusicsPlayer alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height, self.view.width, self.view.height - self.navigationController.navigationBar.height)];
    [self.view addSubview:musicsPlayer];
    self.musicsPlayer = musicsPlayer;
    self.musicsPlayer.isNet = NO;
    self.musicsPlayer.delegate = self;
    
    // 通知
    [NotificationCenter addObserver:self selector:@selector(musicPlay) name:@"stopLocalMusic" object:nil];
    
    // 设置播放
    [self setupMusicPlay:self.index];
}

- (void)musicPlay
{
    SongLocal *songLocal =  self.songList[self.index];
    self.songLocal = songLocal;
    [self setupMusicPlay:self.index];
}

- (void)setupMusicPlay:(NSInteger)index
{
    // 赋值
    self.musicsPlayer.songList = self.songList;
    self.musicsPlayer.index = index;
    self.songLocal.song_url = [self getUrl];
    self.musicsPlayer.songLocal = self.songLocal;
    
    // 歌名
    self.title = self.songLocal.songName;
    
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
}

-(NSString *)getUrl
{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *url =[doucumentsDirectiory stringByAppendingPathComponent:self.songLocal.song_url];

    return url;
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
    SongLocal *songLocal = self.songList[index];
    self.songLocal = songLocal;
    [self setupMusicPlay:index];
}

- (void)MusicsPlayerView:(MusicsPlayer *)view playListMusic:(UIButton *)btn
{
    CollectListViewController * collectListVc = [[CollectListViewController alloc] init];
    [self.navigationController pushViewController:collectListVc animated:YES];
}

@end
