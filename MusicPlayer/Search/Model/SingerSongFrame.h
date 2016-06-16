//
//  SingerSongFrame.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singer.h"

@interface SingerSongFrame : NSObject

// 歌手字体
#define SingerNameFont [UIFont systemFontOfSize:13]
// 歌名字体
#define SingerTitleFont [UIFont systemFontOfSize:16]


@property(nonatomic, strong)Singer *singer;

/** 每个cell尺寸*/
@property(nonatomic, assign)CGRect cellViewFrame;
/** 歌手*/
@property(nonatomic, assign)CGRect cellNameFrame;
/** 歌名*/
@property(nonatomic, assign)CGRect cellTitleFrame;

/**cell高度*/
@property(nonatomic, assign)CGFloat cellHeight;
@end
