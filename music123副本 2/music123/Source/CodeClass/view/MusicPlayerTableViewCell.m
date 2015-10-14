//
//  MusicPlayerTableViewCell.m
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayerTableViewCell.h"

@implementation MusicPlayerTableViewCell
-(UIImageView *)imgView
{
    if (_imgView == nil)
    {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame)+5, CGRectGetMinY(self.contentView.frame)+5, 100, CGRectGetHeight(self.contentView.frame) - 10)];
        //  _imgView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}
-(UILabel *)songTitle
{
    if (_songTitle == nil)
    {
        _songTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 10, CGRectGetMinY(self.imageView.frame)+5, CGRectGetWidth(self.contentView.frame)- CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imgView.frame)/2 - 5)];
        //  _songTitle.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_songTitle];
    }
    return _songTitle;
}
-(UILabel *)singer
{
    if (_singer == nil)
    {
        _singer = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.songTitle.frame), CGRectGetMaxY(self.songTitle.frame) + 5, CGRectGetWidth(self.songTitle.frame),CGRectGetHeight(self.songTitle.frame))];
        //   _singer.backgroundColor = [UIColor grayColor]; 
        [self.contentView addSubview:_singer];
    }
    return _singer;
}

- (void)setModel:(Music *)model
{
    self.singer.text = model.name;
    self.songTitle.text = model.singer;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
