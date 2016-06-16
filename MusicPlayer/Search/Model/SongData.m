//
//  SongData.m
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SongData.h"
#import "Song.h"

@implementation SongData
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"songList":[Song class]};
}

@end
