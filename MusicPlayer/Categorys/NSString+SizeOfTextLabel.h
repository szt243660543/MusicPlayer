//
//  UILabel+SizeOfTextLabel.h
//  myweibo
//
//  Created by szt on 16/4/20.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SizeOfTextLabel)
- (CGSize)szt_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)szt_sizeWithFont:(UIFont *)font;
@end
