//
//  LoserCoreAnimation.h
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/12/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoserCoreAnimation : NSObject
/**
 *  加载常用圆形点动画
 *
 *  @return layer
 */
+ (CALayer *)loadingCommonlyUsedCircularPointAnimation;
/**
 *  加载Boss原点动画
 *
 *  @return layer
 */
+ (CALayer *)loadingBossCirculaPointAnimationWithTrabslation_x:(CGFloat)lation_x;

/**
 *  加载常用圆形线动画
 *
 *  @return layer
 */
+ (CALayer *)loadingCommonlyUsedCircularLineAnimationWithRadius:(CGFloat)radius;
/**
 *  加载线性脉冲动画
 *
 *  @param withRange 脉冲范围
 *
 *  @return layer
 */
+ (CALayer *)loadingCommonlyUsedLinePulseWithRange:(CGFloat)withRange;
/**
 *  使用关键帧动画使控件达到左右抖动动画
 *
 *  @param range 左右抖动范围
 *
 *  @return CAAnimation
 */
+ (CAAnimation *)howUseCAKeyframeAnimationLeftAndRightJitterWithRange:(NSArray *)range keyTimeValues:(NSArray *)times;
@end
