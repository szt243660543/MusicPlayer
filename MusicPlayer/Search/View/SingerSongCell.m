//
//  SingerSongCell.m
//  MusicPlayer
//
//  Created by szt on 16/5/11.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingerSongCell.h"
#import "SingerSongFrame.h"

@interface SingerSongCell()
/** 每个cell尺寸*/
@property(nonatomic, weak)UIView *cellView;
/**歌手*/
@property(nonatomic, weak)UILabel *name;
/**歌名*/
@property(nonatomic, weak)UILabel *title;
@end

@implementation SingerSongCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString * string = @"cell";
    SingerSongCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell)
    {
        cell = [[SingerSongCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // 选中样式
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 创建图片
        /**每个cell尺寸*/
        UIView *cellView = [[UIView alloc] init];
        [self.contentView addSubview:cellView];
        self.cellView = cellView;
        cellView.backgroundColor = [UIColor whiteColor];
        
        /**歌名*/
        UILabel *title = [[UILabel alloc] init];
        title.font = SingerTitleFont;
        [cellView addSubview:title];
        self.title = title;
        title.numberOfLines = 0;
        
        /**歌手*/
        UILabel *name = [[UILabel alloc] init];
        name.font = SingerNameFont;
        name.textColor = [UIColor grayColor];
        [cellView addSubview:name];
        self.name = name;
    }
    
    return self;
}

- (void)setSingerSongFrame:(SingerSongFrame *)singerSongFrame
{
    _singerSongFrame = singerSongFrame;
    
    Singer *singer = singerSongFrame.singer;
    
    /**每个cell尺寸*/
    self.cellView.frame = singerSongFrame.cellViewFrame;
    
    /**歌名*/
    self.title.frame = singerSongFrame.cellTitleFrame;
    self.title.text = singer.title;
    
    /**歌手*/
    self.name.frame = singerSongFrame.cellNameFrame;
    self.name.text = singer.author;
}

@end




