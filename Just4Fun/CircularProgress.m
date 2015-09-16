//
//  CircularProgress.m
//  cbeacon
//
//  Created by Ge on 14-12-17.
//  Copyright (c) 2014年 Mooko Software. All rights reserved.
//

#import "CircularProgress.h"

@implementation CircularProgress
{
    float r;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.percentage = 0.0;
        r = self.frame.size.width / 2;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    UIColor *aColor = [UIColor blackColor];
    
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色

    CGContextMoveToPoint(context, r, r);
    CGContextAddArc(context, r, r, r,   M_PI * 1.5 ,  - M_PI * 0.5 + M_PI * 2 * self.percentage, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill); //绘制路径
}

- (void)setPercentage:(float)percentage
{
    if (percentage < 0.0 || percentage > 1.0) {
        return;
    }
    _percentage = percentage;
    [self setNeedsDisplay];
}

@end
