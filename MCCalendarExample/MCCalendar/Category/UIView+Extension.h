//
//  MCButton.h
//  FaceBookAnimation_Pop
//
//  Created by ZMC on 16/3/30.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWindowWidth [UIScreen mainScreen].bounds.size.width
#define kWindowHeigth [UIScreen mainScreen].bounds.size.height

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat mc_x;
@property (nonatomic, assign) CGFloat mc_y;
@property (nonatomic, assign) CGFloat mc_centerX;
@property (nonatomic, assign) CGFloat mc_centerY;
@property (nonatomic, assign) CGFloat mc_width;
@property (nonatomic, assign) CGFloat mc_height;
@property (nonatomic, assign) CGSize mc_size;
@property (nonatomic, assign,readonly) CGFloat mc_maxX;
@property (nonatomic, assign,readonly) CGFloat mc_maxY;


@end
