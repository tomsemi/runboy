//
//  Dinosaur.m
//  Just4Fun
//
//  Created by Ge on 15/4/25.
//  Copyright (c) 2015年 Ge. All rights reserved.
//

#import "Dinosaur.h"
#import "Hero.h"

@implementation Dinosaur

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 40*kPoint, 48*kPoint)]) {
        self.ignoreCollision = NO;
        self.ignoreGravity = NO;
        self.imgView.image = [UIImage imageNamed:@"dinosaur"];
        self.tag = 3;
        self.speed = CGPointMake(1.5, -2);
    }
    return self;
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    self.speed = CGPointMake(2.0, 3);
    if (sprite.tag == 2 && direction == Right) {
        self.speed = CGPointMake(2.0, -4);
    }

    if (sprite.tag == 1 && direction == Left) {
//        Hero *h = (Hero*)sprite;
//        h.state = Cry;
    }
    
    [super collidedWith:sprite AtDirection:direction];
}

@end
