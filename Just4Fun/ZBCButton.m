//
//  ZBCButton.m
//
//  Created by qianfeng on 14-7-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ZBCButton.h"

@implementation ZBCButton

- (id)initWithFrame:(CGRect)frame ImageName:(NSString *)imgName SuperView:(UIView *)view Titlle:(NSString *)title Clicked:(void (^)(void))blocks
{
    self = [super initWithFrame:frame];
    
    UIImage *img = [UIImage imageNamed:imgName];
    
    if (self) {
        [self setImage:img forState:UIControlStateNormal];
        [self setClickBlocks:blocks];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.5 green:0.7 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithRed:15/255.0 green:93/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame ImageName:(NSString *)imgName SuperView:(UIView *)view Titlle:(NSString *)title Delegate:(id<ZBCButtonDelegate>)delegate Tag:(int)tag
{
    self = [super initWithFrame:frame];
    
    UIImage *img = [UIImage imageNamed:imgName];

    if (self) {
        self.tag = tag;
        [self setImage:img forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.5 green:0.7 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithRed:15/255.0 green:93/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.delegate = delegate;
        [view addSubview:self];
    }
    
    return self;
}


+ (id)buttonWithFrame:(CGRect)frame ImageName:(NSString *)imgName SuperView:(UIView *)view Titlle:(NSString *)title  Delegate:(id<ZBCButtonDelegate>)delegate Tag:(int)tag
{
    ZBCButton* btn = [[ZBCButton alloc]initWithFrame:frame ImageName:imgName  SuperView:view Titlle:title Delegate:delegate Tag:tag];
    return btn;
}

+(id)buttonWithFrame:(CGRect)frame ImageName:(NSString *)imgName SuperView:(UIView *)view Titlle:(NSString *)title Clicked:(void (^)(void))blocks
{
    ZBCButton* btn = [[ZBCButton alloc]initWithFrame:frame ImageName:imgName SuperView:view Titlle:title Clicked:blocks];
    return btn;
}


-(void)setDelegate:(id<ZBCButtonDelegate>)delegate
{
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(touchedUp:)]) {
        [self addTarget:delegate action:@selector(touchedUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([self.delegate respondsToSelector:@selector(touchedDown:)]) {
        [self addTarget:delegate action:@selector(touchedDown:) forControlEvents:UIControlEventTouchDown];
    }
}


-(void)clicked
{
    if (self.clickBlocks) {
        self.clickBlocks();
    }
}

- (void)setImageDeselected:(NSString *)imageDeselected
{
    UIImage *img = [UIImage imageNamed:imageDeselected];
    [self setImage:img forState:UIControlStateNormal];
}

- (void)setImageSelected:(NSString *)imageSelected
{
    UIImage *img = [UIImage imageNamed:imageSelected];
    [self setImage:img forState:UIControlStateSelected];
}


@end
