//
//  SingerSongFrame.m
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingerSongFrame.h"
#include "Singer.h"

// cell的边框宽度
#define CellBorderW 10

@implementation SingerSongFrame

- (void)setSinger:(Singer *)singer
{
    _singer = singer;
    
    // cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 歌名*/
    CGFloat cellTitleLabelX = CellBorderW;
    CGFloat cellTitleLabelY = CellBorderW;
    CGSize cellTitleSize = [singer.title szt_sizeWithFont:SingerTitleFont maxW:cellW - CellBorderW*3];
    self.cellTitleFrame = CGRectMake(cellTitleLabelX, cellTitleLabelY, cellTitleSize.width, cellTitleSize.height);
    
    /** 歌手*/
    CGFloat cellNameX = cellTitleLabelX;
    CGFloat cellNameY = CGRectGetMaxY(self.cellTitleFrame) + CellBorderW;
    CGSize cellNameSize = [singer.author szt_sizeWithFont:SingerNameFont maxW:cellW - CellBorderW*3];
    self.cellNameFrame = CGRectMake(cellNameX, cellNameY, cellNameSize.width, cellNameSize.height);
    
    /** 每个cell尺寸*/
    CGFloat cellViewX = 0;
    CGFloat cellViewY = 0;
    CGFloat cellViewW = cellW;
    CGFloat cellViewH = CGRectGetMaxY(self.cellNameFrame) + CellBorderW;
    self.cellViewFrame = CGRectMake(cellViewX, cellViewY, cellViewW, cellViewH);
    
    /**cell高度*/
    self.cellHeight = CGRectGetMaxY(self.cellViewFrame);
}

@end
