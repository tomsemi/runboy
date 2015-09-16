//
//  Ground.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Ground.h"

@implementation Ground

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 41*kPoint, 80*kPoint)]) {
        self.ignoreCollision = NO;
        self.imgView.image = [UIImage imageNamed:@"ground"];
        self.tag = 2;
    }
    return self;
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    if (_isBad && sprite.tag == 1) {
        self.ignoreGravity = NO;
    }
}

@end
