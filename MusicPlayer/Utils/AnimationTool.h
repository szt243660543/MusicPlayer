//
//  AnimationTool.h
//  MusicPlayer
//
//  Created by szt on 16/5/14.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationTool : NSObject
/**暂停动画*/
+ (void)pauseAnimationLayer:(CALayer*)layer;
/**继续动画*/
+ (void)resumeAnimationLayer:(CALayer*)layer;
@end
