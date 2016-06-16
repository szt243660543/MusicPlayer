//
//  SingleModel.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingleModel.h"
#import "SingleData.h"

@implementation SingleModel

+(instancetype)singleWithData:(SingleData *)data;
{
    SingleModel *singleModel = [[self alloc] init];
    singleModel.name = data.name;
    singleModel.head_pic = data.avatar_big;
    singleModel.titleLabel = data.company;
    singleModel.url = data.url;
    singleModel.ting_uid = data.ting_uid;
    singleModel.songs_total = data.songs_total;
    
    return singleModel;
}
@end