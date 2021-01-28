//
//  MCButton.h
//  FaceBookAnimation_Pop
//
//  Created by ZMC on 16/3/30.
//  Copyright © 2016年 Zmc. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setMc_x:(CGFloat)mc_x
{
    CGRect frame = self.frame;
    frame.origin.x = mc_x;
    self.frame = frame;
}

- (CGFloat)mc_x
{
    return self.frame.origin.x;
}

- (void)setMc_y:(CGFloat)mc_y
{
    CGRect frame = self.frame;
    frame.origin.y = mc_y;
    self.frame = frame;
}

- (CGFloat)mc_y
{
    return self.frame.origin.y;
}

- (void)setMc_centerX:(CGFloat)mc_centerX
{
    CGPoint center = self.center;
    center.x = mc_centerX;
    self.center = center;
}

- (CGFloat)mc_centerX
{
    return self.center.x;
}

- (void)setMc_centerY:(CGFloat)mc_centerY
{
    CGPoint center = self.center;
    center.y = mc_centerY;
    self.center = center;
}

- (CGFloat)mc_centerY
{
    return self.center.y;
}

- (void)setMc_width:(CGFloat)mc_width
{
    CGRect frame = self.frame;
    frame.size.width = mc_width;
    self.frame = frame;
}

- (CGFloat)mc_width
{
    return self.frame.size.width;
}

- (void)setMc_height:(CGFloat)mc_height
{
    CGRect frame = self.frame;
    frame.size.height = mc_height;
    self.frame = frame;
}

- (CGFloat)mc_height
{
    return self.frame.size.height;
}

- (void)setMc_size:(CGSize)mc_size
{

    CGRect frame = self.frame;
    frame.size = mc_size;
    self.frame = frame;
}

- (CGSize)mc_size
{
    return self.frame.size;
}


-(CGFloat)mc_maxX {
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)mc_maxY {
    return CGRectGetMaxY(self.frame);
}



@end
