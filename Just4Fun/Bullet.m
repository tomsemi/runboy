//
//  Bullet.m
//  Just4Fun
//
//  Created by Ge on 15-1-1.
//  Copyright (c) 2015年 Ge. All rights reserved.
//

#import "Bullet.h"
#import "Hero.h"

@implementation Bullet

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 35*kPoint, 20*kPoint)]) {
        self.ignoreCollision = NO;
        self.ignoreGravity = YES;
        self.imgView.image = [UIImage imageNamed:@"bullet"];
        self.tag = 3;
        self.speed = CGPointMake(-1.5, 0);
    }
    return self;
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    if (sprite.tag == 1 && direction == Left && [(Hero*)sprite state]!= Strong) {
        Hero *h = (Hero*)sprite;
        h.state = Cry;
    }
    
    [super collidedWith:sprite AtDirection:direction];
}

@end
