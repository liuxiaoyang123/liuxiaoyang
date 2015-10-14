//
//  MusicPlayerViewController.m
//  music123
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayerViewController.h"

static MusicPlayerViewController *mu = nil;
@interface MusicPlayerViewController ()<MusicPlayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)MusicPlay *musicPlay;
@property (nonatomic,strong)NSArray *lyricArr;
@end

@implementation MusicPlayerViewController

+ (instancetype)shareMusic
{
    if (mu == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            mu = [[MusicPlayerViewController alloc]init];
        });
    }
    return mu;
}
-(void)loadView
{
    self.musicPlay = [[MusicPlay alloc]init];
    self.view = _musicPlay;
}

- (void)getCurTime:(NSString *)curTime Total:(NSString *)totalTime Progress:(CGFloat)progress
{
    self.musicPlay.currentTimeLable.text = curTime;
    self.musicPlay.totleTime.text = totalTime;
    self.musicPlay.progressSilder.value = progress;
    
    self.musicPlay.imgView.transform = CGAffineTransformRotate(self.musicPlay.imgView.transform, M_PI/300);
    
    NSInteger index = [[MusicPlayTools sharePlayMusic]getIndexWithCurTime];
    if (index == -1) {
        return;
    }
    NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.musicPlay.table selectRowAtIndexPath:tmpPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

- (void)endOfPlayAction
{
    [self nextBtnAction:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [MusicPlayTools sharePlayMusic].delegate = self;
    self.musicPlay.table.delegate = self;
    self.musicPlay.table.dataSource = self;
    self.lyricArr = [NSArray array];
    
    self.musicPlay.imgView.layer.cornerRadius = 150;
    self.musicPlay.imgView.layer.masksToBounds = YES;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self p_Btn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    
    
    [[MusicPlayTools sharePlayMusic].player addObserver:self forKeyPath:@"rate" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    // Do any additional setup after loading the view.
}

- (void)rightAction
{
    NSArray *arr = [NSArray arrayWithObjects:UMShareToDouban,UMShareToTencent,UMShareToRenren,UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToTwitter,UMShareToSms,UMShareToEmail,UMShareToFacebook,nil];
    NSString *string = [NSString stringWithString:[MusicPlayTools sharePlayMusic].model.mp3Url];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56178490e0f55a48710004e3" shareText:string shareImage: [UIImage imageNamed:@"未标题-1.jpg"]shareToSnsNames:arr delegate:nil];
    //横屏
    // [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"rate"]) {
        if ([[change valueForKey:@"new"]integerValue] == 0) {
            [self.musicPlay.pauseBtn setTitle:@"播放" forState:UIControlStateNormal];
        }else
        {
            [self.musicPlay.pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }
}
- (void)p_Btn
{
    [self.musicPlay.lastBtn setTitle:@"上一首" forState:UIControlStateNormal];
    [self.musicPlay.lastBtn addTarget:self action:@selector(lastBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.musicPlay.lastBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    
    [self.musicPlay.pauseBtn addTarget:self action:@selector(pauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.musicPlay.pauseBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    
    [self.musicPlay.nextBtn setTitle:@"下一首" forState:UIControlStateNormal];
    [self.musicPlay.nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.musicPlay.nextBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    [self.musicPlay.progressSilder addTarget:self action:@selector(progressSilderAction:) forControlEvents:UIControlEventValueChanged];
}
- (void)lastBtnAction:(UIButton *)sender
{
    if (self.index > 0) {
        self.index --;
    }else
    {
        self.index = [GetDataTools shareMusicData].dataArr.count - 1;
    }
    [self p_play];
}
- (void)pauseBtnAction:(UIButton *)sender
{
    if ([MusicPlayTools sharePlayMusic].player.rate == 0) {
        [[MusicPlayTools sharePlayMusic]musicPlay];
    }else
    {
        [[MusicPlayTools sharePlayMusic]musicPause];
    }
}
- (void)nextBtnAction:(UIButton *)sender
{
    if (self.index == [GetDataTools shareMusicData].dataArr.count - 1) {
        self.index = 0;
    }else
    {
        self.index ++;
    }
    [self p_play];
}
- (void)progressSilderAction:(UISlider *)sender
{
    [[MusicPlayTools sharePlayMusic]seekToTimeWithValue:sender.value];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self p_play];
}

- (void)p_play
{
    if ([[MusicPlayTools sharePlayMusic].model isEqual:[[GetDataTools shareMusicData]getModelWithIndex:self.index]]) {
        return;
    }

    [MusicPlayTools sharePlayMusic].model = [[GetDataTools shareMusicData] getModelWithIndex:self.index];
    
    [[MusicPlayTools sharePlayMusic]musicPrePlay];
    
    [self.musicPlay.imgView sd_setImageWithURL:[NSURL URLWithString:[MusicPlayTools sharePlayMusic].model.picUrl]];
    
    self.navigationItem.title = [MusicPlayTools sharePlayMusic].model.name;
    self.navigationItem.leftBarButtonItem.title = [MusicPlayTools sharePlayMusic].model.singer;
    
    self.lyricArr = [[MusicPlayTools sharePlayMusic]getMusicLyricArray];
    [self.musicPlay.table reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lyricArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = [self.lyricArr[indexPath.row] valueForKey:@"lyricStr"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (cell.selected) {
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }else
    {
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
