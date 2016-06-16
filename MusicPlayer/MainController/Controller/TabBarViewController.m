//
//  TabBarViewController.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "TabBarViewController.h"
#import "SearchViewController.h"
#import "SqliteTool.h"
#import "NavigationController.h"
#import "HomeViewController.h"
#import "VedioSearchViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据处理
    SqliteTool * sql = [SqliteTool sharedSqliteTool];
    [sql copySqlitePath];
    
    // home
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    [self addChildVC:homeVc title:@"我的音乐" image:@"mymusci" selectImage:@"mymusci"];
    
    // 搜索控制器
    SearchViewController *searchVc = [[SearchViewController alloc] init];
    [self addChildVC:searchVc title:@"搜索" image:@"tabbarSearch" selectImage:@"tabbarSearch"];

    // 视频控制器
    VedioSearchViewController *videoVc = [[VedioSearchViewController alloc] init];
    [self addChildVC:videoVc title:@"视频" image:@"tabbarMovie" selectImage:@"tabbarMovie"];
    
    // 默认选中控制器
    self.selectedViewController = self.viewControllers[1];
}

- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectImage:(NSString *)selectImage
{
    // 设置标题
    childVc.title = title;
    
    // 设置图片
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 声明图片按照原始样子显示，不自动渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字样式(设置颜色)
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ColorRBG(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

@end
