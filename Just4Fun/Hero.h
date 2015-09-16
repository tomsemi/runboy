//
//  Hero.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Sprite.h"

typedef enum : NSUInteger {
    Cry,
    Run,
    Jump,
    Strong
} HeroState;

@interface Hero : Sprite

@property (nonatomic,assign) int score;

@property (assign,nonatomic) float maxSpeed;

@property (assign,nonatomic) HeroState state;

@property (assign,nonatomic) BOOL needUpSpeed;

- (void)jump;

@end
