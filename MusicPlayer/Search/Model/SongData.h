//
//  SongData.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface SongData : NSObject
/**xcode*/
@property(nonatomic, copy)NSString *xcode;
/**songList*/
@property(nonatomic, strong)NSArray *songList;
@end
