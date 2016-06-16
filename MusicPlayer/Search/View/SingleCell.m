//
//  SingleViewCell.m
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import "SingleCell.h"
#import "SingleModel.h"
#import "SingleFrame.h"

@interface SingleCell()
/** 每个cell尺寸*/
@property(nonatomic, weak)UIView *cellView;
/** 头像图片*/
@property(nonatomic, weak)UIImageView *headInmageView;
/** 歌手名字*/
@property(nonatomic, weak)UILabel *name;
/** 标题信息*/
@property(nonatomic, weak)UILabel *titleLabel;
@end

@implementation SingleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString * string = @"cell";
    SingleCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell)
    {
        cell = [[SingleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
    return cell;
}

/**
 * cell的初始化方法, 一个cell只会调用一次
 * 一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 *
 */
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
        
        /**歌手名字*/
        UILabel *name = [[UILabel alloc] init];
        name.font = SingleNameFont;
        [cellView addSubview:name];
        self.name = name;
        
        /**标题信息*/
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = SingleTitleFont;
        titleLabel.textColor = [UIColor grayColor];
        [cellView addSubview:titleLabel];
        
        // 允许换行
        titleLabel.numberOfLines = 0;
        self.titleLabel = titleLabel;
        
        /**头像图片*/
        UIImageView *headInmageView = [[UIImageView alloc] init];
        [cellView addSubview:headInmageView];
        self.headInmageView = headInmageView;
    }
    
    return self;
}

- (void)setSingleFrame:(SingleFrame *)singleFrame
{
    _singleFrame = singleFrame;

    SingleModel *singleModel = singleFrame.singleModel;
    
    /**每个cell尺寸*/
    self.cellView.frame = singleFrame.cellViewFrame;
    
    /**歌手名字*/
    self.name.frame = singleFrame.cellNameFrame;
    self.name.text = singleModel.name;
    
    /**标题信息*/
    self.titleLabel.frame = singleFrame.cellTitleLabelFrame;
    self.titleLabel.text = singleModel.titleLabel;
    

    if (singleModel.titleLabel)
    {
        self.titleLabel.hidden = NO;
    }
    else
    {
        self.titleLabel.hidden = YES;
    }
    
    /**头像图片*/
    self.headInmageView.frame = singleFrame.cellHeadInmageFrame;
    [self.headInmageView sd_setImageWithURL:[NSURL URLWithString:singleModel.head_pic] placeholderImage:[UIImage imageNamed:@"headerImage"]];
    
    // 设置圆形头像
    self.headInmageView.layer.cornerRadius = self.headInmageView.width / 2;
    self.headInmageView.clipsToBounds = YES;
}

@end
//