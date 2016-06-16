//
//  FileTools.m
//  MusicPlayer
//
//  Created by szt on 16/5/13.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "FileTools.h"

@implementation FileTools

+(NSString*)DownloadFile:(NSString*)fileUrl fileName:(NSString*)_fileName
{
    NSString *fileName = [DocumentsPath stringByAppendingPathComponent:_fileName];
    
    SZTLog(@"fileName-----%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileName])
    {
        SZTLog(@"本地存在,直接读取");
        return fileName;
    }else
    {
        SZTLog(@"本地不存在,网上下载");
        
        NSURL *url = [NSURL URLWithString:fileUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        //将NSData类型对象data写入文件，文件名为fileName
        [data writeToFile:fileName atomically:YES];
    }
    
    return fileName;
}

+(NSString*)DownloadSongFile:(NSString*)fileUrl fileName:(NSString*)_fileName model:(SongLocal *)song
{
    NSString *songurl = [NSString stringWithFormat:@"%@.mp3",_fileName];
    NSString *fileName = [DocumentsPath stringByAppendingPathComponent:songurl];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileName])
    {
        [MBProgressHUD showSuccess:@"已经下载到本地了"];
        return fileName;
    }
    else
    {
        [MBProgressHUD showSuccess:@"添加下载"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:fileUrl]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:fileName append:NO]];
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 通知下载成功
            NSNotification *notice = [NSNotification notificationWithName:@"downloadSuccess" object:nil userInfo:@{@"song_url":songurl,@"artistName":song.artistName,@"songName":song.songName,@"time":song.time,@"songPicRadio":song.songPicBig,@"songPicBig":song.songPicRadio,@"song_pre":_fileName}];
            [NotificationCenter postNotification:notice];

            [MBProgressHUD showSuccess:@"下载成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            [MBProgressHUD showError:@"下载失败"];
            // 删除文件
            [FileTools deleteFile:fileName];
        }];
        
        [operation start];
    }
    
    return fileName;
}

// 删除文件
+ (void)deleteFile:(NSString *)fileName
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    //文件名
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:fileName];
    if (!blHave) {
        SZTLog(@"no  have");
        return ;
    }else {
        SZTLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:fileName error:nil];
        if (blDele) {
            SZTLog(@"dele success");
        }else {
            SZTLog(@"dele fail");
        }
    }
}

+ (NSDictionary *)ConvertLyricsToTextAndTime:(NSString *)filePath
{
    NSMutableDictionary *dic;
    
    // 文件存在
    if ([filePath length])
    {
        NSString *lyc = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSMutableArray * _musictime = [[NSMutableArray alloc]init];
        NSMutableArray * _lyrics = [[NSMutableArray alloc]init];
        NSMutableArray * _t = [[NSMutableArray alloc]init];
        
        NSArray *arr = [lyc componentsSeparatedByString:@"\n"];
        
        for (NSString *item in arr) {
            if ([item length] && [item rangeOfString:@"["].location != NSNotFound && [item rangeOfString:@"]"].location) {
                NSRange startrange = [item rangeOfString:@"["];
                NSRange stoprange = [item rangeOfString:@"]"];
                
                NSString *content = [item substringWithRange:NSMakeRange(startrange.location+1, stoprange.location - startrange.location-1)];
                
                if ([content length] == 8) {
                    // 分
                    NSString *minute = [content substringWithRange:NSMakeRange(0, 2)];
                    // 秒
                    NSString *second = [content substringWithRange:NSMakeRange(3, 2)];
                    // 毫秒
                    NSString *mm = [content substringWithRange:NSMakeRange(6, 2)];
                    
                    NSString *time = [NSString stringWithFormat:@"%@:%@.%@",minute, second, mm];
                    
                    NSNumber *total = [NSNumber numberWithInteger:[minute integerValue] * 60 + [second integerValue]];
                    [_t addObject:total];
                    
                    NSString *lyric = [item substringFromIndex:10];
                    [_musictime addObject:time];
                    [_lyrics addObject:lyric];
                }
            }
        }
        
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_t, @"Time",_lyrics,@"Lyrics",nil];
    }
    
    return dic;
}

+ (NSMutableArray *)readPlistFromLocal:(NSString *)filePath
{
    NSMutableArray *array;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        SZTLog(@"本地存在");
        array = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    else
    {
        SZTLog(@"不存在");
    }
    
    return array;
}

@end
