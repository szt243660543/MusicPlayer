//
//  SongLocalCell.h
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SongLocalFrame;
@interface SongLocalCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**cell的frame*/
@property(nonatomic, strong)SongLocalFrame *songLocalFrame;
@end
