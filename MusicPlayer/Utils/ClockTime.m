//
//  ClockTime.m
//  MusicPlayer
//
//  Created by szt on 16/5/12.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "ClockTime.h"

@implementation ClockTime
/**将int值转成钟表时间*/
+ (NSString*)TimeformatFromSeconds:(int)seconds
{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h == 0) {
        return  [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}
@end
