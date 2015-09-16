//
//  Scene.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSceneGravityChanged @"SceneGravityChanged"

@class Sprite;

@protocol SceneDelegate ;

@interface Scene : NSObject

@property (assign,nonatomic) CGSize screenSize;

@property (assign,nonatomic) id<SceneDelegate> delegate;

@property (strong,nonatomic,readonly) NSMutableArray *sprites;//不要直接操作这个属性，下面有addSprite和remove

@property (assign,nonatomic,setter = setGravity:) CGFloat gravity;//重力，1.0看起来比较正常

@property (assign,nonatomic) CGFloat length;//整个场景长度,跟屏幕无关

@property (strong,nonatomic,setter = setBackgrounds:) NSArray *backgrounds;

@property (nonatomic,strong,readonly) UIView *rootView;

- (id)init;

- (void)addSprite:(Sprite*)sprite;

- (void)removeSprite:(Sprite*)sprite;

- (void)pauseAllSprite;

- (void)startAllSprite;

- (void)moveWithOffset:(CGFloat)offset;//改变场景在屏幕的偏移

- (void)shake;

@end

@protocol SceneDelegate <NSObject>

@optional

- (void)willGetOutScene:(Sprite*)sprite;//超出场景，一定超出屏幕

- (void)willGetOutScreen:(Sprite*)sprite;//超出屏幕，不一定超出场景

- (void)willGetIntoScreen:(Sprite*)sprite;//将要显示在屏幕

@end
