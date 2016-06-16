//
//  SqliteTool.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SqliteTool : NSObject

SingletonH(SqliteTool)

/** 拷贝资源到沙盒*/
- (void)copySqlitePath;

@end
