//
//  MusicPlayerTableViewCell.h
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"

@interface MusicPlayerTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UILabel *songTitle;

@property(nonatomic,strong)UILabel *singer;

@property (nonatomic,strong)Music *model;



@end
