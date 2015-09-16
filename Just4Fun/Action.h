//
//  Action.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sprite;

typedef  void(^ActionBlock)(Sprite *);

@interface Action : NSObject

@property (copy,nonatomic) ActionBlock actionBlock;

@property (retain,atomic) NSMutableSet *spriteSet;

- (id)init;

+ (Action*)actionWithBlock:(ActionBlock)actionBlock;

@end

#pragma MoveAction

@interface Move : Action

@property (assign,nonatomic)CGPoint dstPoint;

//不一定保持匀速，取决以sprite是否无视重力，会一直执行，直到手动取消或执行其他action
+ (Move*)moveBySpeed:(CGPoint)speed;

//保持匀速，到达指定point后,自动取消action,并且回调callback
+ (Move*)moveToPoint:(CGPoint)point Duration:(NSTimeInterval)duration Completion:(void(^)()) callBack;

//根据gravity参数计算出抛物线，沿抛物线运动到point，开始运动时立即自动取消action，而不是等运动到point位置
+ (Move*)moveToPoint:(CGPoint)point Duration:(NSTimeInterval)duration WithGravity:(float)gravity;

@end


#pragma RoateAction

@interface  Rotate :  Action

+ (Rotate*)rotateByAngle:(float)angle; //按指定的角速度旋转

+ (Rotate*)rotateAutomaticAdjustSpeed; //根据sprite的速度，自动调整旋转角速度

@end

#pragma FlashAction

@interface  Flash :  Action

+ (Flash*)flashWithDuration:(NSTimeInterval)duration Completion:(void(^)()) callBack;//闪烁效果持续时间

@end
