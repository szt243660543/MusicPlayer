//
//  MusicsPlayer.m
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "MusicsPlayer.h"

@interface MusicsPlayer()
/**设置专辑头像*/
@property(nonatomic, weak)UIImageView *headInmageView;
/**设置专辑图片*/
@property(nonatomic, weak)UIImageView *backInmageView;
/**存放歌词的view*/
@property(nonatomic, weak)UIView *lrcView;
/**获取url*/
@property(nonatomic, copy)NSString *url;
@end

@implementation MusicsPlayer

- (AudioPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        self.audioPlayer = [[AudioPlayer alloc] init];
    }
    
    return _audioPlayer;
}

-(AVAudioPlayer *)avAudioPlayer
{
    if (!_avAudioPlayer) {
        self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@".mp3"] error:nil];
    }
    
    return _avAudioPlayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // 接收通知
        [NotificationCenter addObserver:self selector:@selector(stopMusic) name:@"stopLocalMusic" object:nil];
        [NotificationCenter addObserver:self selector:@selector(stopMusic) name:@"stopNetMusic" object:nil];
        [NotificationCenter addObserver:self selector:@selector(downloadSuccess:) name:@"downloadSuccess" object:nil];
        
        // 设置视图
        [self setupView];
    }
    
    return self;
}

// 设置视图
- (void)setupView
{
    // 当前时间
    _currentPlaybackTime = [self createLabelRect:CGRectMake(5, 24, 50, 25)];
    
    // 进度条
    _progress = [[UISlider alloc] initWithFrame:CGRectMake(_currentPlaybackTime.size.width+_currentPlaybackTime.x, 24+3, self.width-110, 20)];
    _progress.continuous = YES;
    _progress.minimumTrackTintColor = [UIColor colorWithRed:244.0f/255.0f green:147.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
    _progress.maximumTrackTintColor = [UIColor lightGrayColor];
    [_progress setThumbImage:[UIImage imageNamed:@"player-progress-point-h"] forState:UIControlStateNormal];
    [_progress addTarget:self action:@selector(seek) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_progress];
    
    // 歌曲总时间
    _totalPlaybackTime = [self createLabelRect:CGRectMake(_progress.size.width + _progress.x, 24, 50, 25)];
    
    /**头像图片*/
    UIImageView *headInmageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 64/2, self.height -74, 64, 64)];
    headInmageView.image = [UIImage imageNamed:@"headerImage"];
    [self addSubview:headInmageView];
    self.headInmageView = headInmageView;
    // 设置圆形头像
    self.headInmageView.layer.cornerRadius = self.headInmageView.width / 2;
    self.headInmageView.clipsToBounds = YES;
    // 开始旋转
    [self reCycleAnimation:self.headInmageView];
    
    /**背景图片*/
    UIImageView *backInmageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 96, self.width-20, self.height - 64*3)];
    backInmageView.image = [UIImage imageNamed:@"headerImage"];
    // 超出部分不显示
    backInmageView.clipsToBounds = YES;
    // 开启点击
    backInmageView.userInteractionEnabled = YES;
    [self addSubview:backInmageView];
    self.backInmageView = backInmageView;
    
    // 存放歌词的view
    UIView *lrcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backInmageView.width, backInmageView.height)];
    [backInmageView addSubview:lrcView];
    self.lrcView = lrcView;
    
    // 播放按钮
    _playButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(self.width/2 - 64/2, self.height - 74, 64, 64) image:@"pasue" imageH:@"pasueHight"];
    [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    // 上一首按钮
    _preButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(_playButton.x-60, _playButton.y+8, 48, 48) image:@"preSong" imageH:@"preSong"];
    [_preButton addTarget:self action:@selector(pre) forControlEvents:UIControlEventTouchUpInside];
    
    // 下一首按钮
    _nextButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(_playButton.x+70, _playButton.y+8, 48, 48) image:@"nextSong" imageH:@"nextSong"];
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    // 播放模式按钮
    _playbackButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(5, _preButton.y, 48, 48) image:@"order" imageH:@"order"];
    [_playbackButton addTarget:self action:@selector(playBack) forControlEvents:UIControlEventTouchUpInside];
    isPlayState = 0;
    
    // List
    _playListButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(self.width-48-5, _preButton.y, 48, 48) image:@"playList" imageH:@"playList"];
    [_playListButton addTarget:self action:@selector(playList) forControlEvents:UIControlEventTouchUpInside];
    
    // 收藏按钮
    _collectButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(_currentPlaybackTime.x, _currentPlaybackTime.y+_currentPlaybackTime.size.height, 48, 48) image:@"collect" imageH:@"collected"];
    [_collectButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    // 下载按钮
    UIButton *downLoadButton = [self createButtonStyle:UIButtonTypeCustom Rect:CGRectMake(_totalPlaybackTime.x, _totalPlaybackTime.y+_totalPlaybackTime.size.height, 48, 48) image:@"downLoad" imageH:@"downLoad"];
    [downLoadButton addTarget:self action:@selector(downLoad) forControlEvents:UIControlEventTouchUpInside];
    downLoadButton.enabled = YES;
    
    self.downLoadButton = downLoadButton;
}

// 创建Label
- (UILabel *)createLabelRect:(CGRect)rect
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    
    label.font =[UIFont boldSystemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = @"00:00";
    
    [self addSubview:label];
    return label;
}

// 创建按钮
- (UIButton *)createButtonStyle:(UIButtonType)style Rect:(CGRect)rect image:(NSString *)image imageH:(NSString *)imageH
{
    UIButton *btn = [UIButton buttonWithType:style];
    btn.frame = rect;
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageH] forState:UIControlStateSelected];
    
    [self addSubview:btn];
    return btn;
}

// 加载图片
- (void)setupPic
{
    // 加载图片
    [self.headInmageView sd_setImageWithURL:[NSURL URLWithString:self.songLocal.songPicBig] placeholderImage:[UIImage imageNamed:@"headerImage"]];
    [self.backInmageView sd_setImageWithURL:[NSURL URLWithString:self.songLocal.songPicRadio] placeholderImage:[UIImage imageNamed:@"headerImage"]];
}

// 设置歌词界面
- (void)setupLrc
{
    // 开启异步线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSString *fileName = [NSString stringWithFormat:@"%@.lrc",self.songLocal.song_pre];
        NSString *filePath = [FileTools DownloadFile:self.singer.lrclink fileName:fileName];
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // @"Time" -- key   @"Lyrics" -- key
            NSDictionary * fileLrc = [FileTools ConvertLyricsToTextAndTime:filePath];
            
            _time = [fileLrc objectForKey:@"Time"];
            _lyrics = [fileLrc objectForKey:@"Lyrics"];
            
            _lrcLabels = [NSMutableArray array];
            
            // 添加歌词label
            [self addLrcLabelsToView];
        });
    }];
    
    [queue addOperation:operation1];
}

// 添加歌词label
- (void)addLrcLabelsToView
{
    for (int i = 0; i<_lyrics.count; i++)
    {
        UILabel *lrc = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lrcView.height *0.5 + 30*i, self.lrcView.width, 30)];
        lrc.text = _lyrics[i];
        lrc.font =[UIFont boldSystemFontOfSize:15.0f];
        lrc.textAlignment = NSTextAlignmentCenter;
        lrc.textColor = RandomColor;
        
        [_lrcLabels addObject:lrc];
        [self.lrcView addSubview:lrc];
    }
}

#pragma mark -- 点击Event
// 进度条拖动
- (void)seek
{
    if (self.isNet) {
        if (!self.audioPlayer) return;
        // 不能拉到最后,有bug
        [self.audioPlayer seekToTime:_progress.value -2];
    }
    else
    {
        if (!self.avAudioPlayer) return;
        // 不能拉到最后,有bug
        [self seekToTime:_progress.value - 1];
    }
}

// 滑动的值
- (void)seekToTime:(float)value
{
    self.avAudioPlayer.currentTime = value;
}

// 播放
- (void)play
{
    if (self.isNet)
    {
        // 暂停
        if (self.audioPlayer.state == AudioPlayerStatePaused)
        {
            // 继续播放
            [self.audioPlayer resume];
            [self startTimer];
            
            // 继续动画
            [AnimationTool resumeAnimationLayer:self.headInmageView.layer];
            
            [_playButton setImage:[UIImage imageNamed:@"pasue"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"pasueHight"] forState:UIControlStateHighlighted];
        }
        else
        {
            // 暂停
            [self.audioPlayer pause];
            // 停止NSTimer
            [_progressUpdateTimer invalidate];
            
            // 暂停动画
            [AnimationTool pauseAnimationLayer:self.headInmageView.layer];
            
            [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"playHight"] forState:UIControlStateHighlighted];
        }
    }
    else
    {
        if (self.avAudioPlayer.isPlaying)
        {
            // 暂停
            [self.avAudioPlayer pause];

            // 停止NSTimer
            [_progressUpdateTimer invalidate];
            
            // 暂停动画
            [AnimationTool pauseAnimationLayer:self.headInmageView.layer];
            
            [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"playHight"] forState:UIControlStateHighlighted];
        }
        else
        {
            // 继续播放
            [self.avAudioPlayer play];
            [self startTimer];
            
            // 继续动画
            [AnimationTool resumeAnimationLayer:self.headInmageView.layer];
            
            [_playButton setImage:[UIImage imageNamed:@"pasue"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"pasueHight"] forState:UIControlStateHighlighted];
        }
    }
}

// 上一首
-(void)pre
{
    // 更新状态
    [self updateControls];
    
    [self stopEveryEvent];
    
    self.index -=1;
    if (self.index < 0)
    {
        self.index = self.songList.count-1;
    }
    
    // 重置歌词
    [self resetlrcLabels];
    
    [self.delegate MusicsPlayerView:self preSwitchMusic:_preButton index:self.index];
}

// 下一首
- (void)next
{
    // 更新状态
    [self updateControls];
    
    [self stopEveryEvent];
    
    self.index +=1;
    
    if (self.index >= self.songList.count)
    {
        self.index = 0;
    }
    
    // 重置歌词
    [self resetlrcLabels];
    
    [self.delegate MusicsPlayerView:self nextSwitchMusic:_nextButton index:self.index];
}

// 随即播放
- (void)random
{
    [self stopEveryEvent];
    
    // 取出随机数
    self.index = RandomNumber(0, (int)self.songList.count - 1);
    
    // 重置歌词
    [self resetlrcLabels];
    
    [self.delegate MusicsPlayerView:self randomIndex:self.index];
}

// 单曲循环
- (void)lock
{
    [self stopEveryEvent];
    
    // 重置歌词
    [self resetlrcLabels];
    
    [self.delegate MusicsPlayerView:self lockIndex:self.index];
}

// 播放列表
- (void)playList
{
    SZTLog(@"打开收藏列表");
    [self.delegate MusicsPlayerView:self playListMusic:_playListButton];
}

// 播饭模式
- (void)playBack
{
    isPlayState += 1;
    NSString * name = nil;
    NSString * title = nil;
    switch (isPlayState) {
        case 0:
            name = @"order";
            title = @"顺序播放";
            break;
        case 1:
            name = @"random";
            title = @"随机播放";
            break;
        case 2:
            name = @"lock";
            title = @"单曲播放";
            isPlayState = -1;
            break;
        default:
            break;
    }
    
    [_playbackButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [MBProgressHUD showSuccess:title];
}

// 收藏
- (void)collect
{
    if (_collectButton.selected)
    {
        [_collectButton setSelected:NO];
        [MBProgressHUD showSuccess:@"取消收藏"];
        
        // 更新本地收藏
        [self updateCollectList];
    }
    else
    {
        [_collectButton setSelected:YES];
        [MBProgressHUD showSuccess:@"收藏成功"];
        
        // 添加新收藏
        [self addSongToCollectList];
    }
}

// 更新本地收藏
- (void)updateCollectList
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:CollectMusicList])
    {
        NSMutableArray *temparr = [FileTools readPlistFromLocal:CollectMusicList];
        NSDictionary *songInfo;
        
        for (int i = 0; i < temparr.count; i++)
        {
            songInfo = temparr[i];
            if ([[songInfo valueForKey:@"song_pre"] isEqualToString:self.songLocal.song_pre])
            {
                [temparr removeObjectAtIndex:i];
            }
        }
        
        // 写入数据
        [temparr writeToFile:CollectMusicList atomically:YES];
    }
}

// 添加新收藏
- (void)addSongToCollectList
{
    NSMutableArray *collectSongs = [NSMutableArray array];
    NSDictionary * songInfo = [self.songLocal keyValues];
    [collectSongs addObject:songInfo];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:CollectMusicList])
    {
        NSMutableArray *temparr = [FileTools readPlistFromLocal:CollectMusicList];
        [temparr addObjectsFromArray:collectSongs];
        // 写入数据
        [temparr writeToFile:CollectMusicList atomically:YES];
    }
    else
    {
        // 写入数据
        [collectSongs writeToFile:CollectMusicList atomically:YES];
    }
}

// 下载
- (void)downLoad
{
    self.downLoadButton.enabled = NO;
    
    NSString *fileName = [NSString stringWithFormat:@"%@",self.songLocal.song_pre];
    NSString *url =  [FileTools DownloadSongFile:self.url fileName:fileName model:self.songLocal];
    
    SZTLog(@"url---%@",url);
}

// 下载成功,才能把地址存起来，失败的地址不存储
- (void)downloadSuccess:(NSNotification *)notification
{
    NSMutableArray *downloadSongs = [NSMutableArray array];
    [downloadSongs addObject:notification.userInfo];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:LocalMusicList])
    {
        NSMutableArray *temparr = [FileTools readPlistFromLocal:LocalMusicList];
        NSDictionary *dic = [temparr lastObject];
        NSDictionary *new = [downloadSongs lastObject];
        
        if (![[new valueForKey:@"song_pre"] isEqualToString:[dic valueForKey:@"song_pre"]]){
            [temparr addObjectsFromArray:downloadSongs];
        }
        
        // 写入数据
        [temparr writeToFile:LocalMusicList atomically:YES];
    }
    else
    {
        // 写入数据
        [downloadSongs writeToFile:LocalMusicList atomically:YES];
    }
}

// 停止所有事件
- (void)stopEveryEvent
{
    self.downLoadButton.enabled = YES;
    
    if ([self isExistInPlist]) {
        [_collectButton setSelected:YES];
    }else{
        [_collectButton setSelected:NO];
    }
    
    [self resetlrcLabels];
    
    if (self.isNet) {
        [self.audioPlayer stop];
    }else{
        [self.avAudioPlayer stop];
    }
    
    [_progressUpdateTimer invalidate];
}

// 收藏中存在歌曲
- (BOOL)isExistInPlist
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:CollectMusicList])
    {
        // 通过字典数组来创建一个模型数组
        NSArray *songList = [SongLocal objectArrayWithKeyValuesArray:[FileTools readPlistFromLocal:CollectMusicList]];
        
        for (SongLocal *songLocal in songList) {
            if ([songLocal.song_pre isEqualToString:self.songLocal.song_pre]) {
                return YES;
            }
        }
    }
    
    return NO;
}

// 播放歌曲
- (void)startMusic
{
    if ([self isExistInPlist]) {
        [_collectButton setSelected:YES];
    }else{
        [_collectButton setSelected:NO];
    }
    
    // 通知
    NSNotification *notice = [NSNotification notificationWithName:@"isLocalMusic" object:nil userInfo:@{@"isLocal":[NSNumber numberWithBool:self.isNet]}];
    [NotificationCenter postNotification:notice];
    
    // 更新歌曲总时间
    _totalPlaybackTime.text = [ClockTime TimeformatFromSeconds:[self.songLocal.time intValue]];
    
    // 开始播放歌曲
    NSString *url = self.url;
    
    if (url)
    {
        if (self.isNet)
        {
            [self.audioPlayer play:[NSURL URLWithString:url]];
        }else
        {
            self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
            [self.avAudioPlayer prepareToPlay];
            [self.avAudioPlayer play];
        }
    }
}

- (void)setupUrl
{
    self.url = self.songLocal.song_url;
}

// 开始时间
-(void)startTimer
{
    _progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                            target:self
                                                          selector:@selector(updatePlaybackProgress)
                                                          userInfo:nil
                                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_progressUpdateTimer forMode:NSRunLoopCommonModes];
}

-(void)updatePlaybackProgress
{
    float totalValue; // 总时间
    float currentTime; // 当前时间
    
    if (self.isNet)
    {
        if (!self.audioPlayer || self.audioPlayer.duration == 0){
            _progress.value = 0;
            return;
        }
        
        totalValue = self.audioPlayer.duration;
        currentTime = self.audioPlayer.progress;
    }
    else
    {
        if (!self.avAudioPlayer || self.avAudioPlayer.duration == 0){
            _progress.value = 0;
            return;
        }
        
        totalValue = self.avAudioPlayer.duration;
        currentTime = self.avAudioPlayer.currentTime;
    }
    
    _progress.minimumValue = 0;
    _progress.maximumValue = totalValue - 1;
    _progress.value = currentTime;
    _currentPlaybackTime.text = [ClockTime TimeformatFromSeconds:(int)currentTime];
    
    if ((int)currentTime == (int)totalValue)
    {
        // 自动播放下一首音乐
        [self autoPlayNextMusic];
    }
    
    // 歌词
    for (int i = 0; i<_time.count; i++)
    {
        if ((int)currentTime == [_time[i] intValue]) {
            
            UILabel *lrcLabel = _lrcLabels[i];
            lrcLabel.font = [UIFont boldSystemFontOfSize:23.0f];
            
            // 把i之前的label复原
            for (int j = 0; j < i ; j++) {
                UILabel *lrcLabel = _lrcLabels[j];
                lrcLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            }
            
            self.lrcView.y = -i *30;
        }
    }
}

// 自动播放下一首音乐
- (void)autoPlayNextMusic
{
    if (isPlayState == -1) {
        [self lock];
    }
    
    switch (isPlayState) {
        case 0: // 顺序播放
            [self next];
            break;
        case 1: // 随机播放
            [self random];
            break;
        case 2: // 单曲播放
            [self lock];
            break;
        default:
            break;
    }
}

- (void)stopMusic
{
    self.downLoadButton.enabled = YES;
    [self resetlrcLabels];
    [self.avAudioPlayer stop];
    [self.audioPlayer stop];
    [_progressUpdateTimer invalidate];
}

- (void)resetlrcLabels
{
    [self.lrcView removeFromSuperview];
    
    // 存放歌词的view
    UIView *lrcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backInmageView.width, self.backInmageView.height)];
    [self.backInmageView addSubview:lrcView];
    self.lrcView = lrcView;
    
    [_lrcLabels removeAllObjects];
}

// 更新状态
- (void)updateControls
{
    if (self.isNet)
    {
        // 暂停
        if (self.audioPlayer.state == AudioPlayerStatePaused)
        {
            [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"playHight"] forState:UIControlStateHighlighted];
        }
        else
        {
            [_playButton setImage:[UIImage imageNamed:@"pasue"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"pasueHight"] forState:UIControlStateHighlighted];
        }
    }
    else
    {
        if (self.avAudioPlayer.isPlaying)
        {
            
        }
        else
        {
            [AnimationTool resumeAnimationLayer:self.headInmageView.layer];
            
            [_playButton setImage:[UIImage imageNamed:@"pasue"] forState:UIControlStateNormal];
            [_playButton setImage:[UIImage imageNamed:@"pasueHight"] forState:UIControlStateHighlighted];
        }
    }
}

// 无限循环转圈
- (void)reCycleAnimation:(UIImageView *)object
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        object.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 1;
        [self reCycleAnimation:object];
    }];
}

@end
