//
//  LoserAnimationView.m
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/12/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#define AnimationContainerViewWidth                 150
#define AnimationContainterViewHeight               150

#define SelfWidth                                   [UIScreen mainScreen].bounds.size.width
#define SelfHeight                                  [UIScreen mainScreen].bounds.size.height


#import "LoserAnimationView.h"
#import "LoserCoreAnimation.h"
static LoserAnimationView *loserView;
@interface LoserAnimationView ()
@property (nonatomic,strong) UIView *animationContainerView;
@end

@implementation LoserAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLoserViewBackground)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.animationContainerView];
    }
    return self;
}

/**
 *  加载常用圆形点动画
 */
+ (void)showLoadingViewDefautRoundDotInView
{
    [LoserAnimationView loadLoserAnimationViewAddSuperView];
    CGFloat round = 80.0;
    CALayer *replicatorL = [LoserCoreAnimation loadingCommonlyUsedCircularPointAnimation];
    replicatorL.bounds = CGRectMake(0, 0, round, round);// 控制圆点的范围
    replicatorL.position = CGPointMake(AnimationContainerViewWidth*0.5, AnimationContainterViewHeight*0.5);// 控制圆点转动的中心
    [loserView.animationContainerView.layer addSublayer:replicatorL];
    
}


/**
 *  加载Boss圆动画
 */
+ (void)showLoadingViewBossRoundDotInView
{
    [LoserAnimationView loadLoserAnimationViewAddSuperView];
    CGFloat round = 80.0;
    CALayer *layer = [LoserCoreAnimation loadingBossCirculaPointAnimationWithTrabslation_x:round/2];
    layer.bounds = CGRectMake(0, 0, round, round);
    layer.position = CGPointMake(AnimationContainerViewWidth*0.5, AnimationContainterViewHeight*0.5);// 控制圆点转动
    [loserView.animationContainerView.layer addSublayer:layer];
}

/**
 *  加载线性画圈动画
 */
+(void)showLoadingViewDefautLineRoundInView
{
    [LoserAnimationView loadLoserAnimationViewAddSuperView];
    
    CGFloat round = 80.0;
    CALayer *layer = [LoserCoreAnimation loadingCommonlyUsedCircularLineAnimationWithRadius:round];
    layer.bounds = CGRectMake(0, 0, round, round);// 控制圆点的范围
    layer.position = CGPointMake(AnimationContainerViewWidth*0.5, AnimationContainterViewHeight*0.5);// 控制圆点转动的中心
    [loserView.animationContainerView.layer addSublayer:layer];
    UILabel *bumber = [[UILabel alloc] initWithFrame:CGRectMake(0, (AnimationContainterViewHeight-30)/2, AnimationContainerViewWidth, 30)];
    bumber.text  = @"0.00%";
    bumber.font = [UIFont systemFontOfSize:18];
    bumber.textColor = [UIColor orangeColor];
    bumber.textAlignment = NSTextAlignmentCenter;
    [loserView.animationContainerView addSubview:bumber];
    __block CGFloat strokeEnd = 0.0;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        strokeEnd += 0.03;
        if (strokeEnd >= 1.f) {
            strokeEnd = 1.0;
            dispatch_source_cancel(timer);
        }
        bumber.text = [NSString stringWithFormat:@"%0.2f%%",strokeEnd];
    });
    dispatch_resume(timer);
}


/**
 *  加载脉冲点动画
 */
+ (void)showLoadingViewPulseRoundDotInView
{
    [LoserAnimationView loadLoserAnimationViewAddSuperView];
    
    CALayer *layer = [LoserCoreAnimation loadingCommonlyUsedLinePulseWithRange:AnimationContainerViewWidth];
    layer.bounds = CGRectMake(0, 0, AnimationContainerViewWidth, AnimationContainterViewHeight*0.2);// 控制圆点的范围
    layer.position = CGPointMake(AnimationContainerViewWidth*0.5, AnimationContainterViewHeight*0.5);// 控制圆点转动的中心
    [loserView.animationContainerView.layer addSublayer:layer];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        loserView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [loserView.animationContainerView.layer removeAllAnimations];
        [loserView.animationContainerView removeFromSuperview];
        [loserView removeFromSuperview];
    }];
}

-(UIView *)animationContainerView
{

    if (!_animationContainerView) {
        
        _animationContainerView = [UIView new];
        _animationContainerView.frame = CGRectMake((SelfWidth-AnimationContainerViewWidth)/2, (SelfHeight-AnimationContainterViewHeight)/2, AnimationContainerViewWidth, AnimationContainterViewHeight);
        _animationContainerView.backgroundColor = [UIColor clearColor];
    }
    
    return _animationContainerView;
}

+ (LoserAnimationView *)loadLoserAnimationViewAddSuperView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    loserView = [LoserAnimationView new];
    loserView.frame = [UIScreen mainScreen].bounds;
    loserView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [keyWindow addSubview:loserView];
    return loserView;
}


- (void)clickLoserViewBackground
{
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
