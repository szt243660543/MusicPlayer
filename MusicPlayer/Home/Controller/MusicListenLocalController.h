//
//  MusicListenLocalController.h
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicsPlayer.h"

@class SongLocal;

@interface MusicListenLocalController : UIViewController<MusicsPlayerDelegate>
+(MusicListenLocalController *)shareMusicListenLocalController;
/**本地音乐*/
@property(nonatomic, strong)SongLocal *songLocal;
/**当前点击的位置*/
@property(nonatomic, assign)NSInteger index;
/**歌曲数组*/
@property(nonatomic, copy)NSMutableArray *songList;

@end
