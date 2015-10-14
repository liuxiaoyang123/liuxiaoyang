//
//  MusicPlayTools.m
//  music123
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayTools.h"
static MusicPlayTools *music = nil;
@interface MusicPlayTools ()
@property (nonatomic,strong)NSTimer *timer;
@end
@implementation MusicPlayTools

+ (instancetype)sharePlayMusic
{
    if (music == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            music = [[MusicPlayTools alloc]init];
        });
    }
    return music;
}

- (instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc]init];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endOfPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)endOfPlay:(NSNotification *)sender
{
    [self musicPause];
    [self.delegate endOfPlayAction];
}

- (void)musicPrePlay
{
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        
    }
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.model.mp3Url]];
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        switch ([[change valueForKey:@"new"]integerValue]) {
            case AVPlayerItemStatusFailed:
                NSLog(@"准备失败");
                break;
            case AVPlayerItemStatusReadyToPlay:
                [self musicPlay];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"不知道什么错误");
                break;
            default:
                break;
        }
    }
}

- (void)musicPlay
{
    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    
    [self.player play];
}

- (void)timeAction:(NSTimer *)sender
{
    [self.delegate getCurTime:[self valueToString:[self getCutTime]] Total:[self valueToString:[self getTotalTime]] Progress:[self getProgress]];
}

- (void)musicPause
{
    [self.timer invalidate];
    self.timer = nil;
    [self.player pause];
}

- (NSInteger)getCutTime
{
    if (self.player.currentItem) {
        return self.player.currentTime.value / self.player.currentTime.timescale;
    }
    return 0;
}

- (NSInteger)getTotalTime
{
    CMTime time = [self.player.currentItem duration];
    if (time.timescale == 0) {
        return 1;
    }
    else
    {
        return time.value / time.timescale;
    }
}

- (CGFloat)getProgress
{
    return (CGFloat)[self getCutTime]/(CGFloat)[self getTotalTime];
}

- (NSString *)valueToString:(NSInteger)value
{
    return [NSString stringWithFormat:@"%.2ld:%.2ld",value/60,value%60];
}

-(void)seekToTimeWithValue:(CGFloat)value
{
    [self musicPause];
    
    [self.player seekToTime:CMTimeMake(value * [self getTotalTime], 1) completionHandler:^(BOOL finished) {
        if (finished == YES) {
            [self musicPlay];
        }
    }];
}

-(NSMutableArray *)getMusicLyricArray
{
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *lyric = [NSArray array];
    for (NSString *str in self.model.timeLyric) {
        if (str.length == 0) {
            continue;
        }
        if ([str hasPrefix:@"["]) {
            lyric = [str componentsSeparatedByString:@"]"];
            Music *m = [[Music alloc]init];
            m.lyricTime = [lyric objectAtIndex:0];
            m.lyricStr = [lyric objectAtIndex:1];
            [arr addObject:m];
        }
    }
    return arr;
    
}

-(NSInteger)getIndexWithCurTime
{
    NSInteger index = 0;
    NSString *curTime = [self valueToString:[self getCutTime]];
    for (NSString *str in self.model.timeLyric) {
        if (str.length == 0) {
            continue;
        }
        if ([curTime isEqualToString:[str substringWithRange:NSMakeRange(1, 5)]]) {
            return index;
        }
        index ++;
    }
    return -1;
}
@end
