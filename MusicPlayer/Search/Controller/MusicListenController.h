//
//  MusicListenController.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingerSongsViewController.h"
#import "Singer.h"
#import "MusicsPlayer.h"

@interface MusicListenController : UIViewController<MusicsPlayerDelegate>

+(MusicListenController *)shareMusicListenController;
/**singer模型*/
@property(nonatomic, strong)Singer *singer;
/**当前点击的位置*/
@property(nonatomic, assign)NSInteger index;
/**歌曲数组*/
@property(nonatomic, copy)NSMutableArray *songList;
@end
