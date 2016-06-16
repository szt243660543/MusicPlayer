//
//  SongLocal.h
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongLocal : NSObject

/**歌手*/
@property(nonatomic, copy)NSString *artistName;
/**歌名*/
@property(nonatomic, copy)NSString *songName;
/**播饭地址*/
@property(nonatomic, copy)NSString *song_url;
/**时长*/
@property(nonatomic, copy)NSNumber *time;
/**专辑头像图片*/
@property(nonatomic, copy)NSString *songPicRadio;
/**专辑图片*/
@property(nonatomic, copy)NSString *songPicBig;
/**歌曲前缀*/
@property(nonatomic, copy)NSString *song_pre;
@end
