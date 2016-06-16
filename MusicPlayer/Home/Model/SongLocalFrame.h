//
//  SongLocalFrame.h
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongLocal.h"

// 歌手字体
#define ArtistNameFont [UIFont systemFontOfSize:13]
// 歌名字体
#define SongNameFont [UIFont systemFontOfSize:16]

@interface SongLocalFrame : NSObject

@property(nonatomic, strong)SongLocal *songLocal;

/** 每个cell尺寸*/
@property(nonatomic, assign)CGRect cellViewFrame;
/** 歌手*/
@property(nonatomic, assign)CGRect cellArtistNameFrame;
/** 歌名*/
@property(nonatomic, assign)CGRect cellSongNameFrame;
/** 头像图片*/
@property(nonatomic, assign)CGRect cellHeadInmageFrame;

/**cell高度*/
@property(nonatomic, assign)CGFloat cellHeight;
@end
