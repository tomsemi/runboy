//
//  ZBCButton.h
//
//  Created by qianfeng on 14-7-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZBCButtonDelegate <NSObject>

@optional

- (void)touchedUp:(UIButton*)sender;

- (void)touchedDown:(UIButton *)sender;

@end

@interface ZBCButton : UIButton

@property (copy) void (^clickBlocks) ();

@property (assign,nonatomic,setter = setDelegate:) id<ZBCButtonDelegate> delegate;

@property (retain,nonatomic,setter = setImageDeselected:) NSString *imageDeselected;

@property (retain,nonatomic,setter = setImageSelected:) NSString *imageSelected;

- (id)initWithFrame:(CGRect)frame ImageName:(NSString*)imgName SuperView:(UIView*)view Titlle:(NSString*)title Delegate :(id<ZBCButtonDelegate>)delegate Tag:(int)tag;

- (id)initWithFrame:(CGRect)frame ImageName:(NSString*)imgName SuperView:(UIView*)view Titlle:(NSString*)title Clicked:(void (^) (void)) blocks;

+ (id)buttonWithFrame:(CGRect)frame ImageName:(NSString*)imgName SuperView:(UIView*)view Titlle:(NSString*)title  Delegate :(id<ZBCButtonDelegate>)delegate Tag:(int)tag;

+ (id)buttonWithFrame:(CGRect)frame ImageName:(NSString*)imgName SuperView:(UIView*)view Titlle:(NSString*)title  Clicked:(void (^) (void)) blocks;

@end
