//
//  ClockTime.h
//  MusicPlayer
//
//  Created by szt on 16/5/12.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockTime : NSObject
/**将int值转成钟表时间*/
+ (NSString*)TimeformatFromSeconds:(int)seconds;
@end
