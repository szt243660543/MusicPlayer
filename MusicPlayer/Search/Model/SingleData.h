//
//  SingleData.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义枚举类型
typedef enum {
    SearchStyleDefault = 0,     // 默认
    SearchStyleRandom,          // 随机
    SearchStyleHot              // 热门
} SearchStyle;

@interface SingleData : NSObject

// 表里面所包含的字段
/**ting_uid*/
@property (nonatomic,assign) long long ting_uid;
/**歌手名字*/
@property (nonatomic,copy) NSString * name;
/**歌手名字首字母*/
@property (nonatomic,copy) NSString * firstchar;
/**gender*/
@property (nonatomic,assign) int gender;
/**area*/
@property (nonatomic) int area;
/**歌手国家*/
@property (nonatomic,copy) NSString * country;
/**歌手头像大图*/
@property (nonatomic,copy) NSString * avatar_big;
/**歌手头像中图*/
@property (nonatomic,copy) NSString * avatar_middle;
/**歌手头像小图*/
@property (nonatomic,copy) NSString * avatar_small;
/**歌手头像最小图*/
@property (nonatomic,copy) NSString * avatar_mini;
/**歌手星座*/
@property (nonatomic,copy) NSString * constellation;
/**歌手身高*/
@property (nonatomic,assign) float stature;
/**歌手体重*/
@property (nonatomic,assign) float weight;
/**歌手血型*/
@property (nonatomic,copy) NSString * bloodtype;
/**歌手公司*/
@property (nonatomic,copy) NSString * company;
/**介绍*/
@property (nonatomic,copy) NSString * intro;
/**albums_total*/
@property (nonatomic,assign) int albums_total;
/**一共歌曲*/
@property (nonatomic,assign) int songs_total;
/**歌手生日*/
@property (nonatomic,assign) NSDate * birth;
/**歌曲地址*/
@property (nonatomic,copy) NSString * url;
/**artist_id*/
@property (nonatomic,assign) int artist_id;
/**180大图*/
@property (nonatomic,copy) NSString * avatar_s180;
/**500大图*/
@property (nonatomic,copy) NSString * avatar_s500;
/**1000大图*/
@property (nonatomic,copy) NSString * avatar_s1000;
/**piao_id*/
@property (nonatomic,assign) int piao_id;

// 根据名字搜索
- (NSMutableArray *)itemWith:(NSString *)name;
- (NSMutableArray *)itemWith:(NSString *)name type:(SearchStyle )type musicNum:(int)num;
- (NSMutableArray *)itemWithHot:(int)num;
@end
