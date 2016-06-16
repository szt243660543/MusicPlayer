//
//  SingerSongCell.h
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SingerSongFrame;
@interface SingerSongCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong)SingerSongFrame *singerSongFrame;
@end
