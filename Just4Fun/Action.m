//
//  Action.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Action.h"
#import "Sprite.h"
#import "ActionManager.h"

@implementation Action

- (id)init
{
    self = [super init];
    if (self) {
        self.spriteSet = [NSMutableSet set];
        self.actionBlock = nil;
        [[ActionManager defaultManager].actionSet addObject:self];
    }
    return self;
}

+ (Action*)actionWithBlock:(ActionBlock)actionBlock
{
    Action *action = [self init];
    action.actionBlock = actionBlock;
    return action;
}

@end

#pragma Move

@implementation Move

- (id)init
{
    self = [super init];
    return self;
}

+ (Move *)moveToPoint:(CGPoint)point Duration:(NSTimeInterval)duration Completion:(void (^)())callBack
{
    Move *move = [[Move alloc]init];
    
    __block NSTimeInterval t =  duration*100.0;
    
    move.actionBlock = ^(Sprite *sprite){
        
        float x = point.x - sprite.center.x;
        float y = point.y - sprite.center.y;
        
        sprite.center = CGPointMake(sprite.center.x+x/t, sprite.center.y+y/t);
        
        if (x<1.0 && y <1.0) {
            [sprite cancelAction];
            
            if (callBack) {
                callBack();
            }
        }
    };
    
    return move;
}

+ (Move*)moveToPoint:(CGPoint)point Duration:(NSTimeInterval)duration WithGravity:(float)gravity
{
    Move *move = [[Move alloc]init];
    
    __block NSTimeInterval t =  duration*100.0;
    
    move.actionBlock = ^(Sprite *sprite){
        
        float x = point.x - sprite.center.x;
        float y = point.y - sprite.center.y;
        
        sprite.speed = CGPointMake(x/t, 2*y/t - 0.06*gravity*t);

        [sprite cancelAction];
    };
    
    return move;
}

+ (Move *)moveBySpeed:(CGPoint)speed
{
    Move *move = [[Move alloc]init];
    
    move.actionBlock = ^(Sprite *sprite){
        sprite.speed = speed;
        [sprite cancelAction];
    };
    
    return move;
}

@end

#pragma Rotate

@implementation Rotate

- (id)init
{
    self = [super init];
    return self;
}

+ (Rotate *)rotateByAngle:(float)angle
{
    Rotate *rotate = [[Rotate alloc]init];
    rotate.actionBlock = ^(Sprite* sprite){
        sprite.imgView.transform = CGAffineTransformRotate(sprite.imgView.transform, angle);
    };
    return rotate;
}

+ (Rotate *)rotateAutomaticAdjustSpeed
{
    Rotate *rotate = [[Rotate alloc]init];
    rotate.actionBlock = ^(Sprite* sprite){
        sprite.imgView.transform = CGAffineTransformRotate(sprite.imgView.transform, sprite.speed.x/sprite.frame.size.width*1.2);
    };
    return rotate;
}

@end

#pragma FlashAction

@implementation Flash

+ (Flash *)flashWithDuration:(NSTimeInterval)duration Completion:(void (^)())callBack
{
    Flash *flash = [[Flash alloc]init];
    
    __block NSTimeInterval t =  0;
    
    flash.actionBlock = ^(Sprite *sprite){
        t++;
        if (t < duration*100/5) {
            sprite.imgView.alpha = 0.3;
        }else if (t< duration*200/5){
            sprite.imgView.alpha = 1;
        }
        else if (t< duration*300/5){
            sprite.imgView.alpha = 0.3;
        }
        else if (t< duration*400/5){
            sprite.imgView.alpha = 1;
        }
        else if (t< duration*500/5){
            sprite.imgView.alpha = 0.3;
        }
        else{
            [sprite cancelAction];
            if (callBack) {
                callBack();
            }
        }
    };
    
    return flash;
}

@end



