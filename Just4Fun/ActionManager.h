//
//  ActionManager.h
//  Just4Fun
//
//  Created by Ge on 15-1-29.
//  Copyright (c) 2015年 Ge. All rights reserved.
//

#import <Foundation/Foundation.h>

//不要直接使用本类
@interface ActionManager : NSObject

@property (retain,atomic) NSMutableSet *actionSet;

+ (ActionManager*)defaultManager;

@end