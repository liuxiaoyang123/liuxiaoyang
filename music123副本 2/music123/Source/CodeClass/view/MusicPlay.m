//
//  MusicPlay.m
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlay.h"

@implementation MusicPlay

-(instancetype)init
{
    if (self == [super init])
    {
        [self p_setUp];
    }
    return self;
}
-(void)p_setUp
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    // self.scroll.backgroundColor = [UIColor yellowColor];
    self.scroll.contentSize = CGSizeMake(2*kScreenWidth, CGRectGetHeight(self.scroll.frame));
    self.scroll.pagingEnabled = YES;
    self.scroll.alwaysBounceHorizontal = YES;
    self.scroll.alwaysBounceVertical = NO;
    //让 scroll  不能超过屏幕滑动
    self.scroll.bounces = NO;
    [self addSubview:_scroll];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    //   self.imgView.backgroundColor = [UIColor greenColor];
    self.imgView.layer.cornerRadius = 150;
    self.imgView.center = self.scroll.center;
    [self.scroll addSubview:_imgView];
    
    self.table =[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.scroll.frame), CGRectGetMinY(self.scroll.frame), CGRectGetWidth(self.scroll.frame), CGRectGetHeight(self.scroll.frame))];
    // self.table.backgroundColor = [UIColor cyanColor];
    [self.scroll addSubview:_table];
    
    
    self.currentTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.scroll.frame) + 10, CGRectGetMaxX(self.scroll.frame) + 20, 50, 25)];
    self.currentTimeLable.backgroundColor = [UIColor orangeColor];
    [self addSubview:_currentTimeLable];
    
    
    self.progressSilder = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentTimeLable.frame)+10, CGRectGetMinY(self.currentTimeLable.frame),180, CGRectGetHeight(self.currentTimeLable.frame) )];
    self.progressSilder.backgroundColor = [UIColor grayColor];
    [self addSubview:_progressSilder];
    
    
    
    self.totleTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.progressSilder.frame) + 10, CGRectGetMinY(self.currentTimeLable.frame), CGRectGetWidth(self.currentTimeLable.frame), CGRectGetHeight(self.currentTimeLable.frame))];
    self.totleTime.backgroundColor = [UIColor orangeColor];
    [self addSubview:_totleTime];
    
    
    self.modeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.modeBtn.frame = CGRectMake(CGRectGetMinX(self.currentTimeLable.frame), CGRectGetMaxY(self.currentTimeLable.frame) + 10, 50, 20);
    self.modeBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:_modeBtn];
    
    
    self.lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.currentTimeLable.frame), CGRectGetMaxY(self.currentTimeLable.frame)+60, (CGRectGetWidth(self.scroll.frame) - 40) / 3, 50)];
    //self.lastBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_lastBtn];
    
    self.pauseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lastBtn.frame) + 10, CGRectGetMinY(self.lastBtn.frame), CGRectGetWidth(self.lastBtn.frame), CGRectGetHeight(self.lastBtn.frame))];
    //self.pauseBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_pauseBtn];
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pauseBtn.frame) + 10, CGRectGetMinY(self.pauseBtn.frame), CGRectGetWidth(self.pauseBtn.frame), CGRectGetHeight(self.pauseBtn.frame))];
    //self.nextBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_nextBtn];
    
    
    
}

@end
