//
//  GameView.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "GameView.h"
#import "GameManager.h"
#import "ZBCButton.h"
#import "CircularProgress.h"

#define FONT_NAME @"FZJZJW--GB1-0"

@implementation GameView
{
    GameManager *gm;
    CGSize viewSize;
    UILabel *msgLabel;
    CircularProgress *cdView;
}

- (void)showMessage:(NSString *)msg Duration:(NSTimeInterval)duration CallBack:(void (^)())callBack
{
    if (_isShowMsg && callBack == nil) {
        return;
    }
    self.isShowMsg = YES;
    
    msgLabel.text = msg;
    msgLabel.alpha = 1.0;
    
    if (callBack) {
        [ZBCButton buttonWithFrame:msgLabel.bounds ImageName:@"" SuperView:msgLabel Titlle:nil Clicked:callBack];
    }
    
    if (duration==0) {
        return;
    }
    [UIView animateWithDuration:2.0 animations:^{
        msgLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isShowMsg = NO;
        }
    }];
}

- (void)setCd:(float)cd
{
    _cd = cd;
    cdView.percentage = cd;
    cdView.userInteractionEnabled = (cd > 0.99);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewSize = frame.size;
        gm = [GameManager defaultManger];
        gm.gameView = self;
        [self createSpeedBar];
        [self createLabel];
        [self createButton];
        for (UIView *v in self.subviews) {
            v.alpha = 0.9;
        }
        [gm addObserver:self forKeyPath:@"player.score" options:NSKeyValueObservingOptionNew context:NULL];
        [gm addObserver:self forKeyPath:@"distance" options:NSKeyValueObservingOptionNew context:NULL];
        self.cd = 1.0;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"distance"]) {
        NSString *s = [NSString stringWithFormat:@"距离:%d",((NSNumber*)change[@"new"]).intValue/10];
        self.distanceLabel.text = s;
    }else if([keyPath isEqualToString:@"player.score"]){
        NSString *s = [NSString stringWithFormat:@"分数:%d",((NSNumber*)change[@"new"]).intValue];
        self.scoreLabel.text = s;
    }
}

- (void)createLabel
{
    msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, viewSize.height/3, viewSize.width, 80)];
    msgLabel.textColor = [UIColor orangeColor];
    msgLabel.numberOfLines = 0;
    msgLabel.userInteractionEnabled = YES;
    msgLabel.font = [UIFont fontWithName:FONT_NAME size:32];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:msgLabel];
    
    UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 140, 40)];
    score.textColor = [UIColor orangeColor];
    score.font = [UIFont fontWithName:FONT_NAME size:24];
    score.text = @"分数:0";
    self.scoreLabel = score;
    [self addSubview:score];
    
    UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(viewSize.width-160, 20, 140, 40)];
    distance.textColor = [UIColor orangeColor];
    distance.font = [UIFont fontWithName:FONT_NAME size:24];
    distance.text = @"距离:0";
    self.distanceLabel = distance;
    [self addSubview:distance];
}

- (void)createSpeedBar
{
    SpeedBar *bar = [[SpeedBar alloc]initWithFrame:CGRectMake(viewSize.width*9/10, viewSize.height*1/10, 15, viewSize.height*6/10)];
    [self addSubview:bar];
    self.speedBar = bar;
}

- (void)createButton
{
    float h = viewSize.height;
    float w = viewSize.width;
    
    __block ZBCButton *resume = nil;
    resume = [ZBCButton buttonWithFrame:CGRectMake(w/2-60, h/2, 120, 40) ImageName:nil SuperView:self Titlle:@"点击继续" Clicked:^{
        [gm resumeGame];
        resume.hidden = YES;
    }];
    resume.hidden = YES;
    resume.titleLabel.font = [UIFont fontWithName:FONT_NAME size:24];
    
    [ZBCButton buttonWithFrame:CGRectMake(w-40, 10, 30, 30) ImageName:@"option_button" SuperView:self Titlle:nil Clicked:^{
        
        if ([gm pauseGame]) {
            resume.titleLabel.textColor = [UIColor orangeColor];
            resume.hidden = NO;
        };
        
    }];
    
    cdView = [[CircularProgress alloc]initWithFrame:CGRectMake(h*0.05, h*0.8, h*0.2, h*0.2)];
    cdView.layer.masksToBounds = YES;
    cdView.layer.cornerRadius = h*0.1;
    [self addSubview:cdView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, h*0.2, h*0.2)];
    btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.2 alpha:0.5];
    [btn setImage:[UIImage imageNamed:@"btn_skill"] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = h*0.1;
    btn.tag = 1;
    [btn addTarget:gm action:@selector(handleTouchDownEvent:) forControlEvents:UIControlEventTouchDown];
    [cdView addSubview:btn];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(w-h*0.4, h*0.8, h*0.2, h*0.2)];
    btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.7 blue:0.6 alpha:1];
    [btn setImage:[UIImage imageNamed:@"btn_jump"] forState:UIControlStateNormal];
    btn.tag = 2;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = h*0.1;
    [btn addTarget:gm action:@selector(handleTouchDownEvent:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(w-h*0.2, h*0.75, h*0.15, h*0.15)];
    btn.backgroundColor = [UIColor colorWithRed:0.9 green:0.5 blue:0.1 alpha:1];
    [btn setImage:[UIImage imageNamed:@"btn_speed"] forState:UIControlStateNormal];
    btn.tag = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = h*0.075;
    [btn addTarget:gm action:@selector(handleTouchDownEvent:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:gm action:@selector(handleTouchUpEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

@end
