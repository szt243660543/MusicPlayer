//
//  SongLocalFrame.m
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SongLocalFrame.h"

// cell的边框宽度
#define CellBorderW 10

@implementation SongLocalFrame

- (void)setSongLocal:(SongLocal *)songLocal
{
    _songLocal = songLocal;
    
    // cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 图片内容*/
    CGFloat cellPhotoX = CellBorderW;
    CGFloat cellPhotoY = CellBorderW;
    CGFloat cellPhotoW = 60;
    CGFloat cellPhotoH = 60;
    self.cellHeadInmageFrame = CGRectMake(cellPhotoX, cellPhotoY, cellPhotoW, cellPhotoH);
    
    /** 歌名*/
    CGFloat cellSongNameX = CGRectGetMaxY(self.cellHeadInmageFrame) + CellBorderW;
    CGFloat cellSongNameY = CellBorderW;
    CGSize cellSongNameSize = [songLocal.songName szt_sizeWithFont:SongNameFont maxW:cellW - CellBorderW*3];
    self.cellSongNameFrame = CGRectMake(cellSongNameX, cellSongNameY, cellSongNameSize.width, cellSongNameSize.height);
    
    /** 歌手*/
    CGFloat cellArtistNameX = cellSongNameX;
    CGFloat cellArtistNameY = CGRectGetMaxY(self.cellSongNameFrame) + CellBorderW;
    CGSize cellArtistNameSize = [songLocal.artistName szt_sizeWithFont:ArtistNameFont maxW:cellW - CellBorderW*3];
    self.cellArtistNameFrame = CGRectMake(cellArtistNameX, cellArtistNameY, cellArtistNameSize.width, cellArtistNameSize.height);
    
    /** 每个cell尺寸*/
    CGFloat cellViewX = 0;
    CGFloat cellViewY = 0;
    CGFloat cellViewW = cellW;
    CGFloat cellViewH = CGRectGetMaxY(self.cellArtistNameFrame)>CGRectGetMaxY(self.cellHeadInmageFrame)?CGRectGetMaxY(self.cellArtistNameFrame):CGRectGetMaxY(self.cellHeadInmageFrame) + CellBorderW;
    self.cellViewFrame = CGRectMake(cellViewX, cellViewY, cellViewW, cellViewH);
    
    /**cell高度*/
    self.cellHeight = CGRectGetMaxY(self.cellViewFrame);
}

@end
