//
//  YYTypeButton.m
//  UIviewAnimationAndTransfrom
//
//  Created by Mac on 16/7/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "YYTypeButton.h"

@implementation YYTypeButton

/*
 - (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;                     // default is nil. title is assumed to be single line
 - (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default if nil. use opaque white
 - (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil. use 50% black
 - (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;                      // default is nil. should be same size if different for different states
 - (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state
 */






/**
*  设置按钮
*
*  @param image 按钮图片
*  @param title 按钮标题
*  @param color 按钮颜色
*  @param state 状态
*/
- (void)setMyTypeButtonImage:(UIImage *)image withTitle:(NSString *)title withTitleColor:(UIColor *)color forState:(UIControlState)state
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:title forState:state];
    [self setTitleColor:color forState:state];
    [self setImage:image forState:state];
    
}



/**
 *  设置按钮
 *
 *  @param image 按钮背景图片
 *  @param title 按钮标题
 *  @param color 按钮颜色
 *  @param state 状态
 */
- (void)setMyTypeButtonBackgroundImage:(UIImage *)image withTitle:(NSString *)title withTitleColor:(UIColor *)color forState:(UIControlState)state
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:title forState:state];
    [self setTitleColor:color forState:state];
    [self setBackgroundImage:image forState:state];
    
}

//设置按钮当中图片的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = contentRect.size.width * 0.2;
    CGFloat y = contentRect.size.height * 0.15;
    CGFloat w = contentRect.size.width - x * 2;
    CGFloat h = contentRect.size.height * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = contentRect.size.height * 0.65;
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.3;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
