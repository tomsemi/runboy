//
//  SpriteFactory.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scene.h"

@interface SpriteFactory : NSObject

@property (assign,nonatomic) Scene *scene;

- (id)initWithScene:(Scene*)scene;

- (void)createSprite:(int)xOffset;

- (void)createWall:(int)xOffset WithOption:(int)badCount;

- (void)registClass:(Class)spriteClass;

@end
