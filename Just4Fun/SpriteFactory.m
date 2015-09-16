//
//  SpriteFactory.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "SpriteFactory.h"
#import "Sprite.h"
#import "Hero.h"
#import "Ground.h"
#import "Brick.h"
#import "Gold.h"
#import "Bullet.h"
#import "Ege.h"

@implementation SpriteFactory
{
    int h,w;
    int lastWallHigh;
    NSArray *classArray;
    
    int count;
}

- (id)initWithScene:(Scene *)scene
{
    if (self = [super init]) {
        self.scene = scene;
        h = self.scene.screenSize.height;
        w = self.scene.screenSize.width;
        lastWallHigh = h*4/5+(arc4random()%2+1)*h/20;
        
        // self.classArr = [NSMutableArray array];
        classArray = @[[Brick class],[Gold class],[Bullet class],[Ege class]];
    }
    return self;
}

- (void)registClass:(Class)spriteClass
{
    // [self.classArr addObject:spriteClass];
}

- (void)createSprite:(int)xOffset
{
    if (classArray.count == 0) {
        return;
    }
    int type = arc4random()%100;
    Class class;
    if (type < 5) {
        class = classArray[0];
    }else if (type < 85) {
        class = classArray[1];
    }else if (type < 95) {
        class = classArray[2];
    }else if (type < 100) {
        class = classArray[3];
    }


    Sprite *s = [(Sprite*)[class alloc]initWithOrigin:CGPointMake(xOffset+w, h/5+arc4random()%(2*h/5))];
    [self.scene addSprite:s];
}

- (void)createWall:(int)xOffset WithOption:(int)badCount
{
    if (badCount > 0) {
        count = badCount;
    }
    
    if ((arc4random()%4) == 0) {
        if (badCount >= 0) {
            lastWallHigh = h*0.7+(arc4random()%3+1)*h*0.05;
        }
    }
    
    Ground *s = [[Ground alloc]initWithOrigin:CGPointMake(xOffset+w, lastWallHigh)];
    s.isBad = count > 0;
    count --;
    [self.scene addSprite:s];

//    s = [[Ground alloc]initWithOrigin:CGPointMake(xOffset+w, lastWallHigh - 0.8*h)];
//    s.isBad = count > 0;
//    [self.scene addSprite:s];
}

@end
