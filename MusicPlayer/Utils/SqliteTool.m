//
//  SqliteTool.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SqliteTool.h"

@implementation SqliteTool

SingletonM(SqliteTool)

-(void)copySqlitePath
{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    
    NSString *dbPath =[doucumentsDirectiory stringByAppendingPathComponent:@"FreeMusic.db"];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:dbPath])
    {
        NSLog(@"you %@",dbPath);
    }
    else //若沙盒中没有
    {
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"FreeMusic" ofType:@"db"];
        [fileManager copyItemAtPath:bundle toPath:dbPath error:&error];
        
        NSLog(@"写入没有%d",[fileManager copyItemAtPath:bundle toPath:dbPath error:&error]);
    }
}

@end
