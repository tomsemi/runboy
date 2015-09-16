//
//  ActionManager.m
//  Just4Fun
//
//  Created by Ge on 15-1-29.
//  Copyright (c) 2015年 Ge. All rights reserved.
//

#import "ActionManager.h"
#import "Action.h"
#import "Sprite.h"

static ActionManager *actionManager = Nil;

@implementation ActionManager
{
    NSTimer *timer;
}

+ (ActionManager*)defaultManager
{
    if (actionManager == Nil) {
        actionManager = [[ActionManager alloc]init];
    }
    return actionManager;
}

- (id)init
{
    if (self = [super init]) {
        self.actionSet = [NSMutableSet set];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(doAction) userInfo:Nil repeats:YES];
    }
    return self;
}

- (void)doAction
{
    for (Action *action in self.actionSet) {
        for (Sprite *sprite in action.spriteSet) {
            if (action.actionBlock) {
                action.actionBlock(sprite);
            }
        }
    }
}

@end
