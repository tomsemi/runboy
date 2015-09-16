//
//  Gold.m
//  Just4Fun
//
//  Created by Ge on 14-12-31.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Gold.h"
#import "Hero.h"

#define FONT_NAME @"FZJZJW--GB1-0"

@implementation Gold

- (id)initWithOrigin:(CGPoint)origin
{
    if (self = [super initWithFrame:CGRectMake(origin.x, origin.y, 25*kPoint, 30*kPoint)]) {
        self.ignoreCollision = NO;
        self.imgView.image = [UIImage imageNamed:@"gold"];
        self.tag = 3;
    }
    return self;
}

- (void)collidedWith:(Sprite *)sprite AtDirection:(Direction)direction
{
    if (sprite.tag != 1) {
        return;
    }
    
    Hero *h = (Hero*)sprite;
    h.score += 10;
    
    self.ignoreCollision = YES;
    
    CGRect frame1 = [self.imgView convertRect:CGRectMake(10, -24, 50, 20) toView:self.imgView.superview];
    CGRect frame2 = [self.imgView convertRect:CGRectMake(20, -54, 50, 20) toView:self.imgView.superview];
    
    UILabel *l = [[UILabel alloc]initWithFrame:frame1];
    l.text = @"+10";
    l.font = [UIFont fontWithName:FONT_NAME size:24];
    l.textColor = [UIColor orangeColor];
    [self.imgView.superview addSubview:l];
    
    [self.imgView removeFromSuperview];
    self.shouldDestory = YES;
    
    [UIView animateWithDuration:1 animations:^{
        l.frame = frame2;
        l.alpha = 0.2;
    } completion:^(BOOL finished) {
        if (finished) {
            [l removeFromSuperview];
        }
    }];
    
    [super collidedWith:sprite AtDirection:direction];
}

@end
