//
//  Consts.h
//  myweibo
//
//  Created by szt on 16/4/9.
//  Copyright © 2016年 szt. All rights reserved.
//
#include <Availability.h>

// __OBJC__这个宏,在所有的.m和.mm文件中默认就定义了这个宏
#ifdef __OBJC__
// 如果这个全局的头文件或者宏只需要在.m或者.mm文件中使用,
// 请把该头文件或宏写到#ifdef __OBJC__ 中
     #import <UIKit/UIKit.h>
     #import <Foundation/Foundation.h>

// RGB颜色
#define ColorRBG(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];

// 随机色
#define RandomColor ColorRBG(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255));

// 生成随机数
#define RandomNumber(from, to) (int)(from + (arc4random() % (to - from + 1)));

// 获取版本号
#define DeviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 通知
#define NotificationCenter [NSNotificationCenter defaultCenter]

// 获取DocumentsPath
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

// 通知
// 表情选中的通知
#define HWEmotionDidSelectNotification @"HWEmotionDidSelectNotification"
#define HWSelectEmotionKey @"HWSelectEmotionKey"
// 删除文字的通知
#define HWEmotionDidDeleteNotification @"HWEmotionDidDeleteNotification"

// 自定义打印
#ifdef DEBUG // 处于开发节点
#define SZTLog(...) NSLog(__VA_ARGS__)
#else  // 处于发布节点
#define SZTLog(...)
#endif

// 本地音乐列表
#define LocalMusicList [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"musicList.plist"]]
// 收藏列表
#define CollectMusicList [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"collectList.plist"]]

#endif
