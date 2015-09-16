//
//  Hero.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Hero.h"
#import "Scene.h"
#import "Gold.h"

@implementation Hero
{
    NSMutableArray *imgArray;
    NSTimer *timer;
    int gravity;
    int n;
}

- (id)initWithOrigin:(CGPoint)origin
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 40*kPoint, 40*kPoint)];
    if (self) {
        self.elastic = 0;
        self.ignoreCollision = NO;
        self.ignoreGravity = NO;
        self.tag = 1;
        imgArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 4; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"hero%i",i]];
            if (img) {
                [imgArray addObject:img];
            }
        }
        self.state = Run;
        n = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observGravity:) name:kSceneGravityChanged object:nil];
    }
    return self;
}

- (void)observGravity:(NSNotification*)notify
{
    if ([notify.object floatValue] < 0) {
        gravity = -1;
        CGAffineTransform rotation = CGAffineTransformMakeRotation(3.14);
        self.imgView.transform = rotation;

    } else {
        gravity = 1;
        CGAffineTransform rotation = CGAffineTransformMakeRotation(0);
        self.imgView.transform = rotation;
    }
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    if ([sprite isKindOfClass:[Gold class]]) {
        return;
    }
    if ((direction == Down && gravity>0) || (direction == Up && gravity < 0)) {
        self.state = Run;
    }

    [super collidedWith:sprite AtDirection:direction];
}

- (void)update
{
//    if (!n--) {
//        self.state = Jump;
//    }
    if (self.needUpSpeed && self.speed.x < self.maxSpeed) {
        self.speed = CGPointMake(self.speed.x+0.1*kPoint, self.speed.y);
    }
    if (self.speed.x>1.0*kPoint) {
        self.speed = CGPointMake(self.speed.x-0.025*kPoint, self.speed.y);
    }
    if (self.speed.x<1.0*kPoint) {
        self.speed = CGPointMake(self.speed.x+0.15*kPoint, self.speed.y);
    }
}

- (void)setState:(HeroState)state
{
    if (state == _state) {
        return;
    }
    _state = state;
    switch (state) {
        case Run:
            n = 0;
            self.imgView.backgroundColor = [UIColor clearColor];

            self.imgView.animationDuration = 0.2;
            self.imgView.animationImages = @[imgArray[2],imgArray[3]];
            [self.imgView startAnimating];
            break;
            
        case Jump:
            self.imgView.backgroundColor = [UIColor clearColor];

            [self.imgView stopAnimating];
            self.imgView.image = imgArray[0];
            break;
            
        case Cry:
            self.imgView.backgroundColor = [UIColor clearColor];

            [self.imgView stopAnimating];
            self.imgView.image = imgArray[1];
            break;
        case Strong:
            [self.imgView stopAnimating];
            self.imgView.image = imgArray[0];
            break;
        default:
            break;
    }
    
    [self changeState];
}

- (void)changeState
{
    if (self.state == Strong) {
        self.center = CGPointMake(self.center.x+50, 150*kPoint);
        self.speed = CGPointMake(self.speed.x, 0);
       // self.imgView.backgroundColor = [UIColor greenColor];
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 20*kPoint;
        self.imgView.layer.borderWidth = 1*kPoint;
        self.imgView.layer.borderColor = [UIColor colorWithRed:0.1 green:0.8 blue:0.9 alpha:1].CGColor;
        self.needUpSpeed = YES;
        self.ignoreGravity = YES;
        self.ignoreCollision = YES;
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(becomeNormal) userInfo:nil repeats:NO];
    } else {
        self.imgView.backgroundColor = [UIColor clearColor];
        self.imgView.layer.masksToBounds = NO;
        self.imgView.layer.cornerRadius = 0;
        self.imgView.layer.borderWidth = 0;
        self.needUpSpeed = NO;
        self.ignoreGravity = NO;
        self.ignoreCollision = NO;
    }
}

- (void)becomeNormal
{
    self.state = Run;
}

- (void)jump
{
    if (_state == Run || n < 2) {
        self.state = Jump;
        n++;
        
        self.speed = CGPointMake(self.speed.x, -1.9*kPoint*gravity);
        return;
    }
}

- (void)destroy
{
    [timer invalidate];
    timer = nil;
    [super destroy];
}

@end