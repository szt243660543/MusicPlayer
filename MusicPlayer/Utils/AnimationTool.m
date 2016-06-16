//
//  AnimationTool.m
//  MusicPlayer
//
//  Created by szt on 16/5/14.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "AnimationTool.h"

@implementation AnimationTool
// 暂停动画
+ (void)pauseAnimationLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

// 继续动画
+ (void)resumeAnimationLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
