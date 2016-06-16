//
//  UILabel+SizeOfTextLabel.m
//  myweibo
//
//  Created by szt on 16/4/20.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "NSString+SizeOfTextLabel.h"

@implementation NSString (SizeOfTextLabel)

// 获取titleLable的文字size
- (CGSize)szt_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    // 约束最大宽度 // MAXFLOAT 没有最大宽度
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    // NSStringDrawingUsesLineFragmentOrigin -- 从头开始算
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (CGSize)szt_sizeWithFont:(UIFont *)font
{
    return [self szt_sizeWithFont:font maxW:MAXFLOAT];
}

@end
