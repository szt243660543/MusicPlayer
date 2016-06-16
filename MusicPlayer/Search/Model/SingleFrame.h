//
//  SingleFrame.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleModel.h"

// 歌手名字字体
#define SingleNameFont [UIFont systemFontOfSize:20]
// 标题信息字体
#define SingleTitleFont [UIFont systemFontOfSize:15]

@interface SingleFrame : NSObject
@property(nonatomic, strong)SingleModel *singleModel;

/** 每个cell尺寸*/
@property(nonatomic, assign)CGRect cellViewFrame;
/** 头像图片*/
@property(nonatomic, assign)CGRect cellHeadInmageFrame;
/** 歌手名字*/
@property(nonatomic, assign)CGRect cellNameFrame;
/** 标题信息*/
@property(nonatomic, assign)CGRect cellTitleLabelFrame;

/**cell高度*/
@property(nonatomic, assign)CGFloat cellHeight;

@end
