//
//  Scene.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "Scene.h"
#import "Sprite.h"
#import "Hero.h"

@implementation Scene
{
    UIView *sceneView;
    NSTimer *timer;
    NSMutableArray *bgViews;
    int n; //偏移几个屏幕宽度
    float w,h;
}

- (id)init
{
    self = [super init];
    if (self) {
        n = 1;
        w = [UIScreen mainScreen].bounds.size.width;
        h = [UIScreen mainScreen].bounds.size.height;
        _sprites = [NSMutableArray array];
        _rootView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        sceneView = [[UIView alloc]initWithFrame:_rootView.bounds];
        self.screenSize = [UIScreen mainScreen].bounds.size;
        [_rootView addSubview: sceneView];
    }
    return self;
}

- (void)setBackgrounds:(NSArray *)backgrounds
{
    int i = 0;
    bgViews = [NSMutableArray array];
    for (UIImage *bg in backgrounds) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(w * i, 0, w, h)];
        imgView.image = bg;
        [bgViews addObject:imgView];
        [sceneView addSubview:imgView];
        i++;
    }
}

- (void)setGravity:(CGFloat)gravity
{
    _gravity = gravity;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:kSceneGravityChanged object:[[NSNumber alloc]initWithFloat:_gravity]];
}

- (void)addSprite:(Sprite *)sprite
{
    sprite.scene= self;
    [self.sprites addObject:sprite];
    [sceneView addSubview:sprite.imgView];
}

- (void)removeSprite:(Sprite *)sprite
{
    sprite.scene = nil;
    [self.sprites removeObject:sprite];
    [sprite destroy];
}

- (void)pauseAllSprite
{
    [timer invalidate];
    timer = nil;
}

- (void)startAllSprite
{
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer  = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(update) userInfo:Nil repeats:YES];
}

- (void)shake
{
    for (Sprite *s in self.sprites) {
        
        if ([s isKindOfClass:[Hero class]]) {
            continue;
        }

        CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        animate.duration = 1;
        animate.values = @[@(20*kPoint),@(-15*kPoint),@(20*kPoint),@(-10*kPoint),@(15*kPoint),@(-10*kPoint),@(5*kPoint),@0];
        
        int random = arc4random()%3;
        if (random == 1) {
            animate.values = @[@(-20*kPoint),@(25*kPoint),@(-10*kPoint),@(30*kPoint),@(-10*kPoint),@(10*kPoint),@(-5*kPoint),@0];
        }
        
        [s.imgView.layer addAnimation:animate forKey:nil];
    }
}

- (void)update
{
    NSArray *temp = [NSArray arrayWithArray:self.sprites];
    for (Sprite *s1 in temp) {
        
        CGFloat x = s1.speed.x;
        CGFloat y = s1.speed.y;
        
        s1.center = CGPointMake(s1.center.x+x, s1.center.y+y);
        
        if (!s1.ignoreGravity) {
            s1.speed = CGPointMake(x, y+0.03*self.gravity*kPoint);
        }
        
        if (x*x< 0.01) {
            s1.speed = CGPointMake(0, s1.speed.y);
        }
        
        if (s1.frame.origin.y < -s1.frame.size.height || s1.frame.origin.y>sceneView.bounds.size.height) {
            [self.delegate willGetOutScene:s1];
        }
        
        if (s1.shouldDestory) {
            [self removeSprite:s1];
            return;
        }
        
        if (s1.ignoreCollision) {
            continue;
        }
        
        for (Sprite *s2 in temp) {
            if (s1.tag != s2.tag && CGRectIntersectsRect(s1.frame, s2.frame)) {
                [self collisionDetecte:s1 And:s2];
            }
        }
    }
}

- (void)moveWithOffset:(CGFloat)offset
{
    if (offset > n * w) {
        [bgViews[0] setFrame:CGRectMake(w*(n+bgViews.count-1), 0, w, h)];
        UIImageView *temp = bgViews[0];
        for (int i = 0; i < bgViews.count -1; i++) {
            bgViews[i] = bgViews[i+1];
        }
        bgViews[bgViews.count - 1] = temp;
        n++;
    }
    sceneView.center = CGPointMake(w*0.5-offset, sceneView.center.y);
    
    CGRect screenFame = CGRectMake(offset, 0, w, h);
    
    NSArray *temp = [NSArray arrayWithArray:self.sprites];
    
    for (Sprite *s in temp) {
        if (!CGRectIntersectsRect(s.frame, screenFame)) {
            [self.delegate willGetOutScreen:s];
        }else{
            [self.delegate willGetIntoScreen:s];
        }
    }
}

- (void)collisionDetecte:(Sprite*)s1 And:(Sprite*)s2
{
    CGRect rect = CGRectIntersection(s1.frame, s2.frame);
    int dx = rect.size.width;
    int dy = rect.size.height;
    
    if (dy<dx+5*kPoint) {
        if (s1.center.y - s2.center.y < 0) {
            [s1 collidedWith:s2 AtDirection:Down];
        } else {
            [s1 collidedWith:s2 AtDirection:Up];
        }
        return;
    }
    
    if (dy>dx){
        if (s1.center.x - s2.center.x < 0) {
            [s1 collidedWith:s2 AtDirection:Right];
        } else {
            [s1 collidedWith:s2 AtDirection:Left];
        }
    }
}

@end
