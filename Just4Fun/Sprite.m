//
//  Sprite.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Sprite.h"
#import "Action.h"

@implementation Sprite
{
    Action *_action;
}

@synthesize frame = _frame,center = _center;

- (id)initWithOrigin:(CGPoint)origin
{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.speed = CGPointZero;
        self.elastic = 0.0f;
        self.tag = 0;
        self.ignoreGravity = YES;
        self.ignoreCollision = YES;
        UIImageView *temp = [[UIImageView alloc]initWithFrame:frame];
        self.imgView = temp;
        self.center = self.imgView.center;
    }
    return self;
}

- (void)destroy
{
    [self.imgView removeFromSuperview];
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    switch (direction) {
        case Up:
            if (self.speed.y<0) {
                self.speed = CGPointMake(self.speed.x, -self.speed.y*self.elastic);
            }
            break;
        case Down:
            if (self.speed.y>0) {
                if (self.speed.y < 0.8*kPoint) {
                    self.speed = CGPointMake(self.speed.x, 0);
                }
                self.speed = CGPointMake(self.speed.x, -self.speed.y*self.elastic);
            }
            break;
        case Left:
            if (self.speed.x<0) {
                self.speed = CGPointMake(-self.speed.x*self.elastic, self.speed.y);
            }
            break;
        case Right:
            if (self.speed.x>0) {
                self.speed = CGPointMake(-self.speed.x*0, self.speed.y);
            }
            break;
        default:
            break;
    }
}

- (void)runAction:(Action *)action
{
    [_action.spriteSet removeObject:self];
    _action = action;
    [action.spriteSet addObject:self];
}

- (void)cancelAction
{
    [_action.spriteSet removeObject:self];
}

- (void)setFrame:(CGRect)frame
{
    _frame = frame;
    self.imgView.frame = frame;
}

- (void)setCenter:(CGPoint)center
{
    _center =center;
    self.imgView.center = center;
}

- (CGRect)frame
{
    return self.imgView.frame;
}

- (CGPoint)center
{
    return self.imgView.center;
}

@end
