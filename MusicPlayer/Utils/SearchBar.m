//
//  SerachBar.m
//  myweibo
//
//  Created by szt on 16/4/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar()

@end

@implementation SearchBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.font = [UIFont systemFontOfSize:15];
        // 提示
        self.placeholder = @"请输入歌手/歌名";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 设置左边放大镜图标
        UIImage * image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // 通过initWithImage创建初始化的UIImageView，UIImageView尺寸默认等于image的尺寸
        // UIImageView * searchIcon = [[UIImageView alloc] initWithImage:image];
        // 通过init创建初始化的绝大部分控件，控件都没有尺寸
        UIImageView * searchIcon = [[UIImageView alloc] init];
        searchIcon.image = image;
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        // 在UITextField左边加一个图片
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
