//
//  MusicsPlayer.h
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singer.h"
#import "SongData.h"
#import "SongLocal.h"
#import <AVFoundation/AVFoundation.h>

@class MusicsPlayer;

@protocol MusicsPlayerDelegate <NSObject>
@optional
/**播放模式*/
- (void)MusicsPlayerView:(MusicsPlayer *)view musicStop:(NSInteger)playModel;
/**上一首*/
- (void)MusicsPlayerView:(MusicsPlayer *)view preSwitchMusic:(UIButton *)pre index:(NSInteger)index;
/**下一首*/
- (void)MusicsPlayerView:(MusicsPlayer *)view nextSwitchMusic:(UIButton *)next index:(NSInteger)index;
/**随机播放*/
- (void)MusicsPlayerView:(MusicsPlayer *)view randomIndex:(NSInteger)index;
/**单曲循环*/
- (void)MusicsPlayerView:(MusicsPlayer *)view lockIndex:(NSInteger)index;
/**播放列表*/
- (void)MusicsPlayerView:(MusicsPlayer *)view playListMusic:(UIButton *)btn;
/**下载*/
-(void)MusicsPlayerView:(MusicsPlayer *)view downLoadMusic:(UIButton *)btn;
@end

@interface MusicsPlayer : UIView
{
    // 进度条
    UISlider * _progress;
    // 定时器
    NSTimer * _progressUpdateTimer;
    // 当前播放时间
    UILabel * _currentPlaybackTime;
    // 歌曲总时间
    UILabel * _totalPlaybackTime;
    
    // 播放
    UIButton * _playButton;
    // 上一首
    UIButton * _preButton;
    // 下一首
    UIButton * _nextButton;
    // 播放模式
    UIButton * _playbackButton;
    // List
    UIButton * _playListButton;
    // 收藏
    UIButton * _collectButton;
    // 下载按钮
    UIButton * _downLoadButton;
    
    // 歌词数组
    NSArray *_lyrics;
    // 时间数组
    NSArray *_time;
    /**存放lrcLabels*/
    NSMutableArray *_lrcLabels;
    
    // 是否正在播放
    BOOL isPlaying;
    // 是否暂停播放
    BOOL isPasue;
    // 切换state
    int isPlayState;
    // 旋转角度
    int angle;
}

/**流播放器*/
@property(nonatomic, strong)AudioPlayer *audioPlayer;
/**本地播放器*/
@property(nonatomic, strong)AVAudioPlayer *avAudioPlayer;
/**songLocal模型*/
@property(nonatomic, strong)SongLocal *songLocal;
/**singer模型*/
@property(nonatomic, strong)Singer *singer;
/**当前点击的位置*/
@property(nonatomic, assign)NSInteger index;
/**歌曲数组*/
@property(nonatomic, copy)NSMutableArray *songList;
//下载按钮
@property (nonatomic, strong)UIButton * downLoadButton;
//代理
@property(nonatomic, assign)id <MusicsPlayerDelegate>delegate;
/**是否联网*/
@property(nonatomic, assign)BOOL isNet;

/**播放音乐*/
- (void)startMusic;
/**开始时间*/
- (void)startTimer;
/**切换歌词*/
- (void)setupLrc;
/**加载图片*/
-(void)setupPic;
/**加载url*/
-(void)setupUrl;
@end
