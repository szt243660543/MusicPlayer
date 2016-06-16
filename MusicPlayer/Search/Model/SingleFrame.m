//
//  SingleFrame.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingleFrame.h"
#import "SingleModel.h"

// cell的边框宽度
#define ProfileCellBorderW 10

@implementation SingleFrame

- (void)setSingleModel:(SingleModel *)singleModel
{
    _singleModel = singleModel;
    
    // cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;

    /** 图片内容*/
    CGFloat cellPhotoX = ProfileCellBorderW;
    CGFloat cellPhotoY = ProfileCellBorderW;
    CGFloat cellPhotoW = 60;
    CGFloat cellPhotoH = 60;
    self.cellHeadInmageFrame = CGRectMake(cellPhotoX, cellPhotoY, cellPhotoW, cellPhotoH);
    
    /** 歌手名字*/
    CGFloat cellNameX = CGRectGetMaxX(self.cellHeadInmageFrame) + ProfileCellBorderW;
    CGFloat cellNameY = ProfileCellBorderW;
    CGSize cellNameSize = [singleModel.name szt_sizeWithFont:SingleNameFont];
    self.cellNameFrame = CGRectMake(cellNameX, cellNameY, cellNameSize.width, cellNameSize.height);

    /** 标题信息*/
    CGFloat cellTitleLabelX = cellNameX;
    CGFloat cellTitleLabelY = CGRectGetMaxY(self.cellNameFrame) + ProfileCellBorderW;
    CGSize cellTitleLabelSize = [singleModel.titleLabel szt_sizeWithFont:SingleTitleFont maxW:cellW - ProfileCellBorderW*2 - cellPhotoW];
    self.cellTitleLabelFrame = CGRectMake(cellTitleLabelX, cellTitleLabelY, cellTitleLabelSize.width, cellTitleLabelSize.height);
    
    /** 每个cell尺寸*/
    CGFloat cellViewX = 0;
    CGFloat cellViewY = 0;
    CGFloat cellViewW = cellW;
    CGFloat cellViewH = CGRectGetMaxY(self.cellTitleLabelFrame)>CGRectGetMaxY(self.cellHeadInmageFrame)?CGRectGetMaxY(self.cellTitleLabelFrame):CGRectGetMaxY(self.cellHeadInmageFrame) + ProfileCellBorderW;
    self.cellViewFrame = CGRectMake(cellViewX, cellViewY, cellViewW, cellViewH);
    
    /**cell高度*/
    self.cellHeight = CGRectGetMaxY(self.cellViewFrame);
}

@end
