//
//  FileTools.h
//  MusicPlayer
//
//  Created by szt on 16/5/13.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongLocal.h"

@interface FileTools : NSObject

/** 下载文件到本地路径*/
+ (NSString*)DownloadFile:(NSString*)fileUrl fileName:(NSString*)_fileName;
/** 异步下载文件到本地路径*/
+ (NSString*)DownloadSongFile:(NSString*)fileUrl fileName:(NSString*)_fileName model:(SongLocal *)song;
/** 转换歌词 */
+ (NSDictionary *)ConvertLyricsToTextAndTime:(NSString *)path;
/** 读取本地plist */
+ (NSMutableArray *)readPlistFromLocal:(NSString *)filePath;
@end
