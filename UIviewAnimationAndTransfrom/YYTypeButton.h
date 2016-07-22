//
//  YYTypeButton.h
//  UIviewAnimationAndTransfrom
//
//  Created by Mac on 16/7/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTypeButton : UIButton

/**
 *  设置按钮
 *
 *  @param image 按钮图片
 *  @param title 按钮标题
 *  @param color 按钮颜色
 *  @param state 状态
 */
- (void)setMyTypeButtonImage:(UIImage *)image withTitle:(NSString *)title withTitleColor:(UIColor *)color forState:(UIControlState)state;
/**
 *  设置按钮
 *
 *  @param image 按钮背景图片
 *  @param title 按钮标题
 *  @param color 按钮颜色
 *  @param state 状态
 */
- (void)setMyTypeButtonBackgroundImage:(UIImage *)image withTitle:(NSString *)title withTitleColor:(UIColor *)color forState:(UIControlState)state;
@end
