//
//  SingerSongsViewController.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface SingerSongsViewController : UITableViewController

/**歌手的模型数组*/
@property(nonatomic, strong)SingleModel *singleModel;

@end

