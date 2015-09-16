//
//  GameManager.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scene.h"
#import "Hero.h"
#import "GameView.h"
#import "ZBCButton.h"

typedef enum {
    Runing = 1,
    Pause = 2,
    Over = 3
} GameState;

@interface GameManager : NSObject <SceneDelegate>

@property (assign,nonatomic) GameState gameState;

@property (weak,nonatomic) GameView *gameView;

@property (assign,nonatomic) int score;

@property (assign,nonatomic) float distance;

@property (strong,nonatomic) Hero *player;

@property (weak,nonatomic) Scene *currentScene;

@property (weak,nonatomic) UIViewController *vc;

+ (instancetype)defaultManger;

+ (instancetype)newGame;

- (void)startGame;

- (BOOL)pauseGame;

- (void)resumeGame;

- (void)handleTouchDownEvent:(UIButton*)sender;

- (void)handleTouchUpEvent:(UIButton*)sender;

@end
