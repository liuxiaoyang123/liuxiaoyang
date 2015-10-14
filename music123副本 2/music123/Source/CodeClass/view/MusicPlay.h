//
//  MusicPlay.h
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlay : UIView
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)UILabel *currentTimeLable;
@property(nonatomic,strong)UISlider *progressSilder;
@property(nonatomic,strong)UILabel *totleTime;
@property(nonatomic,strong)UIButton *lastBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UIButton *pauseBtn;


@property(nonatomic,strong)UIButton *modeBtn;
@end
