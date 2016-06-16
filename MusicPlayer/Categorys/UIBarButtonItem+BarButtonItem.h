//
//  UIBarButtonItem+BarButtonItem.h
//  myweibo
//
//  Created by szt on 16/4/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItem)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action imageNormal:(NSString *)imagenormal imageHighlighted:(NSString *)imagehighlighted;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action titleColorNormal:(UIColor *)colorNormal titleColorClick:(UIColor *)colorClick title:(NSString *)title;
@end
