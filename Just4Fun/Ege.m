//
//  Ege.m
//  Just4Fun
//
//  Created by Ge on 15/4/24.
//  Copyright (c) 2015年 Ge. All rights reserved.
//

#import "Ege.h"
#import "Scene.h"
#import "Dinosaur.h"

@implementation Ege

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 35*kPoint, 45*kPoint)]) {
        self.ignoreCollision = NO;
        self.imgView.image = [UIImage imageNamed:@"ege"];
        self.tag = 3;
    }
    return self;
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.shouldDestory = YES;

        Dinosaur *d = [[Dinosaur alloc]initWithOrigin:self.frame.origin];
        [self.scene addSprite:d];
    });
    
    [super collidedWith:sprite AtDirection:direction];
}

@end
