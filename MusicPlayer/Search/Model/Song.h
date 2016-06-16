//
//  song.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
/*
songId = 14944589,
songPicRadio = http://musicdata.baidu.com/data2/pic/89230692/89230692.jpg,
time = 229,
linkCode = 22000,
songPicSmall = http://musicdata.baidu.com/data2/pic/89230704/89230704.jpg,
artistId = 1035,
albumName = One Chance 新歌+精选,
copyType = 1,
songName = 逆战,
artistName = 张杰,
songPicBig = http://musicdata.baidu.com/data2/pic/89230698/89230698.jpg,
version = 现场,
albumId = 27845582,
songLink = http://file.qianqian.com//data2/music/134380309/134380309.mp3?xcode=8516fa79ac09d0926f333bb99c6701d9&src="http%3A%2F%2Fpan.baidu.com%2Fshare%2Flink%3Fshareid%3D1015735913%26uk%3D3998432082",
showLink = http://pan.baidu.com/share/link?shareid=1015735913&uk=3998432082,
size = 3671690,
lrcLink = http://musicdata.baidu.com/data2/lrc/27846096/27846096.lrc,
queryId = 14944589,
format = mp3,
relateStatus = 0,
resourceType = 2,
rate = 128
 */

/**在线播放*/
@property(nonatomic, copy)NSString *showLink;
/**下载地址*/
@property(nonatomic, copy)NSString *songLink;
/**歌曲长度*/
@property(nonatomic, assign)int time;
/**专辑图片*/
@property(nonatomic, copy)NSString *songPicRadio;
/**专辑头像图片*/
@property(nonatomic, copy)NSString *songPicBig;
/**歌曲名字*/
@property(nonatomic, copy)NSString *songName;
/**歌手名字*/
@property(nonatomic, copy)NSString *artistName;
@end

