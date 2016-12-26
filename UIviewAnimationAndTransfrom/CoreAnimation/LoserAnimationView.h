//
//  LoserAnimationView.h
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/12/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoserAnimationView : UIView
/**
 *  加载常用圆形点动画
 */
+ (void)showLoadingViewDefautRoundDotInView;
/**
 *  加载线性画圈动画
 */
+ (void)showLoadingViewDefautLineRoundInView;
/**
 *  加载脉冲点动画
 */
+ (void)showLoadingViewPulseRoundDotInView;
/**
 *  加载Boss圆动画
 */
+ (void)showLoadingViewBossRoundDotInView;
@end
