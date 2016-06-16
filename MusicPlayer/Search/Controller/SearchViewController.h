//
//  SearchViewController.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleModel;

@interface SearchViewController : UITableViewController<UITextFieldDelegate>
{
    /**音乐信息*/
    NSMutableArray *musicInfos;
}
@end
