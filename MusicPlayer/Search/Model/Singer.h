//
//  Singer.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singer : NSObject
/**
korean_bb_song = 0,
author = 张杰,
pic_big = http://musicdata.baidu.com/data2/pic/89230698/89230698.jpg,
charge = 0,
country = 内地,
piao_id = 0,
resource_type_ext = 0,
havehigh = 2,
lrclink = http://musicdata.baidu.com/data2/lrc/27846096/27846096.lrc,
pic_small = http://musicdata.baidu.com/data2/pic/89230704/89230704.jpg,
hot = 103676,
has_mv = 1,
song_source = web,
all_artist_ting_uid = 1035,
publishtime = 2012-09-29,
file_duration = 0,
toneid = 600902000009517412,
artist_id = 14,
area = 0,
album_id = 27845582,
learn = 1,
mv_provider = 1100000000,
album_title = One Chance 新歌+精选,
del_status = 0,
album_no = 12,
has_mv_mobile = 1,
song_id = 14944589,
bitrate_fee = {"0":"0|0","1":"0|0"},
resource_type = 2,
is_first_publish = 0,
all_rate = 24,64,128,192,256,320,flac,
ting_uid = 1035,
all_artist_id = 14,
title = 逆战,
language = 国语,
versions = 现场,
copy_type = 1,
listen_total = 12746,
relate_status = 0
 */

/**歌手*/
@property(nonatomic, copy)NSString *author;
/**歌名*/
@property(nonatomic, copy)NSString *title;
/**语言*/
@property(nonatomic, copy)NSString *language;
/**ting_uid*/
@property(nonatomic, assign)long long ting_uid;
/**歌曲来源*/
@property(nonatomic, copy)NSString *song_source;
/**song_id*/
@property(nonatomic, assign)long long song_id;
/**歌词*/
@property(nonatomic, copy)NSString *lrclink;
@end
