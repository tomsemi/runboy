//
//  Brick.m
//  Just4Fun
//
//  Created by Ge on 14-12-31.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Brick.h"

@implementation Brick

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 35*kPoint, 35*kPoint)]) {
        self.ignoreCollision = YES;
        self.imgView.image = [UIImage imageNamed:@"brick"];
        self.tag = 3;
    }
    return self;
}

@end
