//
//  SpeedBar.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "SpeedBar.h"

@implementation SpeedBar
{
    UIView *speedView;
    float height;
    float lastpersecond;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *back = [[UIView alloc]initWithFrame:self.bounds];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 10;
        back.backgroundColor = [UIColor greenColor];
        [self addSubview:back];
        back.alpha = 0.5;
        
        speedView = [[UIView alloc]initWithFrame:self.bounds];
        speedView.layer.masksToBounds = YES;
        speedView.layer.cornerRadius = 10;
        speedView.backgroundColor = [UIColor orangeColor];
        [self addSubview:speedView];

        height = self.frame.size.height;
    }
    return self;
}

- (void)setSpeed:(float)speed
{
    if (speed < 0) {
        speed = 0;
    }
    
    speedView.frame = CGRectMake(0, height*(1-speed), speedView.frame.size.width, height*speed);
}

@end