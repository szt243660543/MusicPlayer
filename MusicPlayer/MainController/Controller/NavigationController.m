//
//  NavigationController.m
//  myweibo
//
//  Created by szt on 16/4/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

// 只进一次
+(void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 设置字体大小
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disanleTextAttrs = [NSMutableDictionary dictionary];
    // 设置字体大小
    disanleTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    disanleTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disanleTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 重写导航控制器的push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // push进来的控制器viewController，不是第一个子控制器(根控制器)
    if (self.viewControllers.count > 0) {
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        /*设置导航栏上面的内容*/
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) imageNormal:@"nav_backbtn" imageHighlighted:@"nav_backbtn"];
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
