//
//  Sprite.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Action;
@class Scene;

#define kPoint ([UIScreen mainScreen].bounds.size.width / 568)

typedef enum {
    None = 0,
    Up = 1,
    Down = 2,
    Left = 3,
    Right = 4
} Direction;

@interface Sprite : NSObject

@property (weak,nonatomic) Scene *scene;

@property (assign,nonatomic) int tag;

@property (assign,nonatomic) CGPoint speed;

@property (assign,nonatomic) CGFloat elastic;//默认弹性0

@property (assign,nonatomic) BOOL ignoreCollision;//默认无视碰撞

@property (assign,nonatomic) BOOL ignoreGravity; //默认无视重力

@property (assign,nonatomic) BOOL shouldDestory;//如果设为YES，destroy方法将被调用一次

@property (assign,nonatomic,getter = frame,setter = setFrame:) CGRect frame;

@property (assign,nonatomic,setter = setCenter:,getter = center) CGPoint center;

@property (strong,nonatomic) UIImageView *imgView;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithOrigin:(CGPoint)origin;

- (void)collidedWith:(Sprite*)sprite AtDirection:(Direction)direction;//一次碰撞可能会被连着调用好几次

- (void)destroy; //不要直接调用此方法,不然很可能内存泄漏,或者崩掉,上面有shouldDestroy属性

- (void)runAction:(Action*)action;//不要覆盖此方法,以及下面的

- (void)cancelAction;

@end