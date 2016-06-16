//
//  UIBarButtonItem+BarButtonItem.m
//  myweibo
//
//  Created by szt on 16/4/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "UIBarButtonItem+BarButtonItem.h"
#import "UIView+Extension.m"

@implementation UIBarButtonItem (BarButtonItem)


/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */

// 设置按钮UIBarButtonItem (项目中多处用到)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action imageNormal:(NSString *)imagenormal imageHighlighted:(NSString *)imagehighlighted
{
    /*设置导航栏上面的内容*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:imagenormal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imagehighlighted] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param titleColorNormal  标题普通状态的颜色
 *  @param colorClick  标题点击的颜色
 *  @param title 标题
 *
 *  @return 创建完的item
 */

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action titleColorNormal:(UIColor *)colorNormal titleColorClick:(UIColor *)colorClick title:(NSString *)title{
    /*设置导航栏上面的内容*/
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 字体
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:colorNormal forState:UIControlStateNormal];
    [btn setTitleColor:colorClick forState:UIControlStateHighlighted];
    // 设置尺寸
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
