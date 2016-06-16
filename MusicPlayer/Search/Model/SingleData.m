//
//  SingleData.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingleData.h"

@implementation SingleData

//表名
+(NSString *)getTableName
{
    return @"FMSongerInfor";
}

//表版本
+(int)getTableVersion
{
    return 1;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 创建数据库
        LKDBHelper *dbHelper = [LKDBHelper getUsingLKDBHelper];
        [dbHelper createTableWithModelClass:[SingleData class]];
    }
    return self;
}

// 根据歌手名字搜索
- (NSMutableArray *)itemWith:(NSString *)name
{
    NSMutableArray * array = [SingleData searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",name] orderBy:nil offset:0 count:0];
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (SingleData * sub in array)
    {
        if ([sub.name length] != 0)
        {
            if ([sub.company length] !=0)
            {
                [temp addObject:sub];
            }
            else
            {
                [temp1 addObject:sub];
            }
        }
    }
    
    [temp addObjectsFromArray:temp1];
    
    return temp;
}

// 根据歌手名字搜索
- (NSMutableArray *)itemWithHot:(int)num
{
    NSMutableArray * array = [SingleData searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",@"张"] orderBy:nil offset:0 count:0];
    NSMutableArray * array1 = [SingleData searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",@"陈"] orderBy:nil offset:0 count:0];
    NSMutableArray * array2 = [SingleData searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",@"王"] orderBy:nil offset:0 count:0];
    
    [array addObjectsFromArray:array1];
    [array addObjectsFromArray:array2];
    
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (SingleData * sub in array)
    {
        if ([sub.name length] != 0)
        {
            if ([sub.company length] !=0)
            {
                [temp addObject:sub];
            }
            else
            {
                [temp1 addObject:sub];
            }
        }
    }
    
    [temp addObjectsFromArray:temp1];
    
    for(int i = 0; i< temp.count; i++)
    {
        int m = (arc4random() % (temp.count - i)) + i;
        [temp exchangeObjectAtIndex:i withObjectAtIndex:m];
    }
    
    NSMutableArray * temp3 = [NSMutableArray new];
    
    for (int i = 0; i < num; i++){
        [temp3 addObject:temp[i]];
    }
    
    return temp3;
}

// 根据歌手名字搜索、模式
- (NSMutableArray *)itemWith:(NSString *)name type:(SearchStyle )type musicNum:(int)num
{
    NSMutableArray * temp = [self itemWith:name];
    NSMutableArray * temp1 = [NSMutableArray array];
    
    if (temp.count == 0) {
        return temp;
    }
    
    // 默认
    if (type == SearchStyleDefault)
    {
        SZTLog(@" 默认");
        return temp;
    }
    
    // 随机
    if (type == SearchStyleRandom)
    {
        SZTLog(@" 随机");
        for (int i = 0; i < num; i++)
        {
            int index = RandomNumber(0, (int)temp.count-1);
            [temp1 addObject:temp[index]];
        }
    }
    
    // 热门
    if (type == SearchStyleHot)
    {
        SZTLog(@" 热门");
        for (int i = 0; i < num; i++)
        {
            int index = RandomNumber(0, (int)temp.count-1);
            [temp1 addObject:temp[index]];
        }
    }
    
    if ((int)temp.count < num) {
        return temp;
    }

    return temp1;
}

@end
