//
//  SingleViewCell.h
//  MusicPlayer
//
//  Created by szt on 16/5/10.
//  Copyright © 2016年 szt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleFrame;
@interface SingleCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**每个cell的frame*/
@property(nonatomic, strong)SingleFrame *singleFrame;
@end
