//
//  GameManager.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "GameManager.h"
#import "SpriteFactory.h"

static GameManager *manager = Nil;

@implementation GameManager
{
    int m,n;
    NSTimer *timer;
    float sceneOffset;
    float lastOffset;
    NSArray *stateArr;
    SpriteFactory *factory;
}

//－－－－－－－－－主循环－－－－－－－－－//
- (void)update
{
    if (self.player.state == Cry) {
        [self gameOver];
        return;
    }

    if (_player.speed.x/_player.maxSpeed > 0.8 && !self.gameView.isShowMsg) {
         [self.gameView showMessage:@"好快啊" Duration:1 CallBack:nil];
    }
    
    [self.gameView.speedBar setSpeed:_player.speed.x/_player.maxSpeed];
    
    if (_gameView.cd < 1.0) {
        _gameView.cd = _gameView.cd + 0.001;
    }
    
    float ballOffset = _player.center.x - 160*kPoint;
    sceneOffset += 1.0 * kPoint;
    
    if (ballOffset  > sceneOffset) {
        [self.currentScene moveWithOffset:ballOffset];
        sceneOffset = ballOffset;
    }else{
        [self.currentScene moveWithOffset:sceneOffset];
    }
    
    self.distance = sceneOffset;
    
    if (sceneOffset > n*kPoint*70) {
        
//        if (arc4random()%2 == 0 &&  (n+15)%40 == 0 ) {
//            _currentScene.gravity = -1.0;
//            [_gameView showMessage:@"重力场改变" Duration:1 CallBack:nil];
//            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(recoverGravity) userInfo:nil repeats:NO];
//        }
        
        [factory createSprite:sceneOffset];
        n++;
    }
    
    if (sceneOffset > m*kPoint*40) {
        if (m%50 == 0 && arc4random()%2 == 0) {
            [factory createWall:sceneOffset WithOption:arc4random()%6+6];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_gameView showMessage:@"麻痹,地震了" Duration:1.5 CallBack:nil];
                [_currentScene shake];
            });
            
        } else {
            [factory createWall:sceneOffset-40 WithOption:0];
        }
        m++;
    }
}

- (void)recoverGravity
{
    _currentScene.gravity = 1.0;
}

#pragma mark 单例方法，和实例化方法
- (id)init
{
    self = [super init];
    if (self) {
        sceneOffset = 0;
        n = 1;
        m = 1;
    }
    return self;
}

+ (instancetype)defaultManger
{
    if (manager == Nil) {
        manager = [[GameManager alloc]init];
    }
    return manager;
}

+ (instancetype)newGame
{
    manager = [[GameManager alloc]init];
    return manager;
}

#pragma 开始，暂停，恢复，结束
- (void)startGame
{
    [self createPlayer];
    factory = [[SpriteFactory alloc] initWithScene:self.currentScene];
    for (int i = 0; i < 14; i++) {
        [factory createWall:(i*40 - 560)*kPoint WithOption:-1];
    }
    self.currentScene.gravity = 1;
    self.gameState = Pause;
    [self resumeGame];
}

- (void)resumeGame
{
    if (self.gameState == Pause) {
        [self.currentScene startAllSprite];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(update) userInfo:nil repeats:YES];
        self.gameState = Runing;
    }
}

- (BOOL)pauseGame
{
    if (self.gameState == Runing) {
        self.gameState = Pause;
        [timer invalidate];
        timer = nil;
        [self.currentScene pauseAllSprite];
        return YES;
    }
    return NO;
}

- (void)gameOver
{
    self.gameState = Over;
    [self.player cancelAction];
    [self.gameView showMessage:@"GameOver!\n点击返回" Duration:0 CallBack:^{
        [self.vc dismissViewControllerAnimated:YES completion:nil];
    }];
    [timer invalidate];
    timer = nil;
    [self.currentScene pauseAllSprite];
}

#pragma 创建Player
- (void)createPlayer
{
    Hero *hero = [[Hero alloc]initWithOrigin:CGPointMake(200*kPoint, 200*kPoint)];
    hero.speed = CGPointMake(1.5*kPoint, 0);
    hero.maxSpeed = 2.0*kPoint;
    [self.currentScene addSprite:hero];
    self.player = hero;
    self.currentScene.delegate = self;
}

#pragma SceneDelegate方法
- (void)willGetOutScene:(Sprite *)sprite
{
}

- (void)willGetIntoScreen:(Sprite *)sprite
{
    
}

- (void)willGetOutScreen:(Sprite *)sprite
{
    if (sprite == _player) {
        [self gameOver];
        return;
    }
    sprite.shouldDestory = YES;
    //test gogogo
}

#pragma ButtonEvent

- (void)handleTouchDownEvent:(UIButton *)sender
{
    if (self.gameState != Runing) {
        return;
    }
    switch (sender.tag) {
        case 1:
            if (_player.state == Cry) {
                return;
            }
            _gameView.cd = 0;
            self.player.state = Strong;
            break;
        case 2:
            [self.player jump];
            break;
        case 3:
            self.player.needUpSpeed = YES;
            break;
        default:
            break;
    }

}

- (void)handleTouchUpEvent:(UIButton *)sender
{
    if (sender.tag == 3) {
        self.player.needUpSpeed = NO;
    }
}

@end

