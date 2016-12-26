//
//  UIButton+Category.h
//  masonry链式编程
//
//  Created by Loser on 16/11/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)
/**
 *  默认标题
 */
- (UIButton *(^)(NSString *title))buttonNormalTitle;
/**
 *  默认标题颜色
 */
- (UIButton *(^)(UIColor *norColor))buttonNormalColor;
/**
 *  选中标题
 */
- (UIButton *(^)(NSString *seleTitle))buttonSelecteTitle;
/**
 *  选中标题颜色
 */
- (UIButton *(^)(UIColor *SelecteColor))buttonSelecteColor;
/**
 *  默认图标
 */
- (UIButton *(^)(UIImage *normalImg))buttonNormalImg;
/**
 *  选中图标
 */
- (UIButton *(^)(UIImage *selecteImg))buttonSelecteImg;
/**
 *  frame
 */
- (UIButton *(^)(CGRect frame))buttonFrame;
/**
 *  标题字体大小
 */
- (UIButton *(^)(float fontSize))buttonSystemFont;
/**
 *  tag
 */
- (UIButton *(^)(NSUInteger tag))buttonTag;
/**
 *  添加点击事件
 */
- (UIButton *(^)(id target,SEL action,UIControlEvents ControlEvents))buttonAddClickAction;

- (UIButton *(^)(CGFloat width,CGFloat Radius,UIColor *color))buttonLayer;

@end
