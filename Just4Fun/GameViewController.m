//
//  GameViewController.m
//  Just4Fun
//
//  Created by Ge on 14-12-30.
//  Copyright (c) 2014年 Ge. All rights reserved.
//

#import "GameViewController.h"
#import "Scene.h"
#import "GameView.h"
#import "GameManager.h"

@interface GameViewController ()
{
    GameManager *gm;
}

@property (retain,nonatomic) Scene *scene;

@end

@implementation GameViewController

- (void)loadScene
{
    Scene *s = [[Scene alloc]init];
    self.view = s.rootView;
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 1; i < 5; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"bg%i",i]];
        [imgArray addObject:img];
    }
    s.backgrounds = imgArray;
    self.scene = s;
}

- (void)loadGameView
{
    GameView *gv = [[GameView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:gv];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gm = [GameManager newGame];
    gm.vc = self;
    
    [self loadScene];
    
    gm.currentScene = self.scene;

    [self loadGameView];
    
    [gm startGame];
}

@end