//
//  SongLocalCell.m
//  MusicPlayer
//
//  Created by szt on 16/5/18.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SongLocalCell.h"
#import "SongLocalFrame.h"

@interface SongLocalCell()
/** 每个cell尺寸*/
@property(nonatomic, weak)UIView *cellView;
/**歌手*/
@property(nonatomic, weak)UILabel *artistName;
/**歌名*/
@property(nonatomic, weak)UILabel *songName;
/** 头像图片*/
@property(nonatomic, weak)UIImageView *headInmageView;

@end

@implementation SongLocalCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString * string = @"cell";
    SongLocalCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell)
    {
        cell = [[SongLocalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
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
        UILabel *songName = [[UILabel alloc] init];
        songName.font = SongNameFont;
        [cellView addSubview:songName];
        self.songName = songName;
        songName.numberOfLines = 0;
        
        /**歌手*/
        UILabel *artistName = [[UILabel alloc] init];
        artistName.font = ArtistNameFont;
        artistName.textColor = [UIColor grayColor];
        [cellView addSubview:artistName];
        self.artistName = artistName;
        
        /**头像图片*/
        UIImageView *headInmageView = [[UIImageView alloc] init];
        [cellView addSubview:headInmageView];
        self.headInmageView = headInmageView;
    }
    
    return self;
}

- (void)setSongLocalFrame:(SongLocalFrame *)songLocalFrame
{
    _songLocalFrame = songLocalFrame;
    
    SongLocal *songLocal = songLocalFrame.songLocal;
    
    /**每个cell尺寸*/
    self.cellView.frame = songLocalFrame.cellViewFrame;
    
    /**歌名*/
    self.songName.frame = songLocalFrame.cellSongNameFrame;
    self.songName.text = songLocal.songName;
    
    /**歌手*/
    self.artistName.frame = songLocalFrame.cellArtistNameFrame;
    self.artistName.text = songLocal.artistName;
    
    /**头像图片*/
    self.headInmageView.frame = songLocalFrame.cellHeadInmageFrame;
    SZTLog(@"------%@",songLocal.songPicRadio);
    [self.headInmageView sd_setImageWithURL:[NSURL URLWithString:songLocal.songPicRadio] placeholderImage:[UIImage imageNamed:@"headerImage"]];
//    self.headInmageView.image = [UIImage imageNamed:songLocal.songPicRadio];
    
    // 设置圆形头像
    self.headInmageView.layer.cornerRadius = self.headInmageView.width / 2;
    self.headInmageView.clipsToBounds = YES;
}


@end
