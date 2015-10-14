//
//  MusicPlayTools.h
//  music123
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol MusicPlayDelegate <NSObject>

- (void)getCurTime:(NSString *)curTime Total:(NSString *)totalTime Progress:(CGFloat)progress;

- (void)endOfPlayAction;

@end

@interface MusicPlayTools : NSObject

@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)Music *model;
@property (nonatomic,weak)id<MusicPlayDelegate>delegate;

+ (instancetype)sharePlayMusic;

- (void)musicPrePlay;

- (void)musicPlay;

- (void)musicPause;

-(void)seekToTimeWithValue:(CGFloat)value;

-(NSMutableArray *)getMusicLyricArray;

-(NSInteger)getIndexWithCurTime;

@end
