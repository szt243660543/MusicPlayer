//
//  SingleModel.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SingleData;

@interface SingleModel : NSObject

/**歌手名字*/
@property (nonatomic,copy) NSString * name;
/**歌手头像大图*/
@property (nonatomic,copy) NSString * head_pic;
/**介绍*/
@property (nonatomic,copy) NSString * titleLabel;
/**歌曲地址*/
@property (nonatomic,copy) NSString * url;
/**ting_uid*/
@property (nonatomic,assign) long long ting_uid;
/**一共歌曲*/
@property (nonatomic,assign) int songs_total;


+(instancetype)singleWithData:(SingleData *)data;
@end
