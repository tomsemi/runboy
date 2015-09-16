//
//  GameView.h
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeedBar.h"

@interface GameView : UIView

@property (assign,nonatomic) BOOL isShowMsg;

@property (assign,nonatomic) SpeedBar *speedBar;

@property (assign,nonatomic) UILabel *scoreLabel;

@property (assign,nonatomic) UILabel *distanceLabel;

@property (assign,nonatomic) float cd;

- (void)showMessage:(NSString*)msg Duration:(NSTimeInterval)duration CallBack:(void(^)())callBack;


@end