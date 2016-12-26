//
//  LoserCoreAnimation.m
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/12/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "LoserCoreAnimation.h"

@implementation LoserCoreAnimation
/**
 *  加载常用圆形点动画
 *
 *  @return layer
 */
+(CALayer *)loadingCommonlyUsedCircularPointAnimation
{
    CAShapeLayer *shapeLayer = [self creatShapeLayerWithRadius:20];// 创建一个圆
    [shapeLayer addAnimation:[self creatBasicaAnimation_transformScale] forKey:@"addscale"];// 添加动画
    shapeLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);// 设置初始时透明度
    NSInteger count = 10;
    CATransform3D trans3D = CATransform3DMakeRotation(2*M_PI/count, 0, 0, 1);// 每个圆点的位置
    
    CAReplicatorLayer *repLayer = [self creatReplicatorLayerNumber:count withTransfrom:trans3D copyLayer:shapeLayer];
    repLayer.instanceDelay = 1.0/count;// 每隔多长时间出现一个layer
    return repLayer;
    
}

/**
 *  加载Boss原点动画
 *
 *  @return layer
 */
+ (CALayer *)loadingBossCirculaPointAnimationWithTrabslation_x:(CGFloat)lation_x
{
    CGFloat Radius = 10.0;
    CAShapeLayer *shapeLayer = [self creatShapeLayerWithRadius:Radius*2];
    [shapeLayer addAnimation:[self creatBasicAnimation_transformWithTrabslation_x:lation_x+Radius] forKey:@"boss"];
    
    NSInteger count = 4;
    
    CATransform3D trans3D = CATransform3DMakeRotation(90.0*M_PI/180.0, 0, 0, 1);
    CAReplicatorLayer *repLayer = [self creatReplicatorLayerNumber:count withTransfrom:trans3D copyLayer:shapeLayer];
//    repLayer.instanceDelay = 1.0/count;
    return repLayer;
    
}


/**
 *  加载线性脉冲动画
 *
 *  @param withRange 脉冲范围
 *
 *  @return layer
 */
+ (CALayer *)loadingCommonlyUsedLinePulseWithRange:(CGFloat)withRange
{
    CAShapeLayer *shapeLayer = [self creatShapeLayerWithRadius:20];// 创建一个圆
    [shapeLayer addAnimation:[self creatBasicaAnimation_transformScale] forKey:@"addscale"];// 添加动画
    shapeLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);// 设置初始时透明度
    NSInteger count = 5;
    CATransform3D trans3D = CATransform3DMakeTranslation(withRange/count, 0, 1);// 每个圆点的位置
    
    CAReplicatorLayer *repLayer = [self creatReplicatorLayerNumber:count withTransfrom:trans3D copyLayer:shapeLayer];
    repLayer.instanceDelay = 1.0/count;// 每隔多长时间出现一个layer
    return repLayer;
    
}

/**
 *  加载常用圆形线动画
 *
 *  @return layer
 */
+ (CALayer *)loadingCommonlyUsedCircularLineAnimationWithRadius:(CGFloat)radius
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius*0.5, radius*0.5) radius:radius*0.5 startAngle:-0.25*M_PI endAngle:1.75*M_PI clockwise:YES].CGPath;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.strokeStart = 0.0;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    __block CGFloat strokeEnd = 0;
    shapeLayer.strokeEnd = strokeEnd;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        strokeEnd += 0.03;
        if (strokeEnd >= 1.f) {
            strokeEnd = 1.0;
            dispatch_source_cancel(timer);
        }
        shapeLayer.strokeEnd = strokeEnd;
    });
    dispatch_resume(timer);
    
    return shapeLayer;
}

/**
 *  使用关键帧动画使控件达到左右抖动动画
 *
 *  @param range 左右抖动范围
 *
 *  @return CAAnimation
 */
+ (CAAnimation *)howUseCAKeyframeAnimationLeftAndRightJitterWithRange:(NSArray *)range keyTimeValues:(NSArray *)times
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    // values里面放的是控件应该到的位置
    keyAnimation.values = range;
    // 设置 keyTimes 属性让我们能够指定关键帧动画发生的时间
    //可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
    if (times.count > 0) {
      keyAnimation.keyTimes = times;
    }

    // 动画持续的时间
    keyAnimation.duration = 1;
    //设置动画的速度变化
    /**
     timingFunction  设置动画的速度变化
     1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
     2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
     3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
     4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加
     5.kCAMediaTimingFunctionDefault (默认)
     */
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyAnimation.additive = YES;// 是动画速度恒定
    return keyAnimation;
}


/**
 *  创建一个圆
 *
 *  @param radius 半径
 *
 *  @return CAShapeLayer
 */
+ (CAShapeLayer *)creatShapeLayerWithRadius:(CGFloat)radius
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    
    return shapeLayer;
}
/**
 *  能够复制相同属性的子layer
 *
 *  @param count     复制子layer个数
 *  @param transfrom transfrom
 *  @param copyLayer 被复制的对象
 *
 *  @return CAReplicatorLayer
 */
+ (CAReplicatorLayer *)creatReplicatorLayerNumber:(NSInteger)count withTransfrom:(CATransform3D)transfrom copyLayer:(CALayer *)copyLayer
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = count;// 要复制的子layer(count-1)个
    replicatorLayer.instanceTransform = transfrom;// 复制之后所有子layer在矩阵的位置
    replicatorLayer.frame = copyLayer.frame;//要复制的子layer 的frame
    // 调色
//    replicatorLayer.instanceBlueOffset = -0.2;
//    replicatorLayer.instanceGreenOffset = 0.2;
//    replicatorLayer.instanceRedOffset = -0.2;
    [replicatorLayer addSublayer:copyLayer];
    return replicatorLayer;
}

+ (CABasicAnimation *)creatBasicAnimation_transformWithTrabslation_x:(CGFloat)loation_x
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D form3D = CATransform3DMakeTranslation(0, 0, 0);
    animation.fromValue = [NSValue valueWithCATransform3D:form3D];
    
    // 顺时针
    CATransform3D to3D = CATransform3DMakeTranslation(loation_x+10, 0, 0);
    // 逆时针
//    CATransform3D to3D = CATransform3DMakeTranslation(0, loation_x+10, 0);
//    to3D = CATransform3DRotate(to3D, 0.5*M_PI, 0, 0, 1);
    animation.toValue = [NSValue valueWithCATransform3D:to3D];
    animation.duration = 1.0;
    animation.additive = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatDuration = HUGE_VALF;
    return animation;
}

/**
 *  添加动画
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)creatBasicaAnimation_transformScale
{
    /**
     首先我们需要搞明白一点的是，layer动画运行的过程是怎样的？其实在我们给一个视图添加layer动画时，真正移动并不是我们的视图本身，而是presentation layer 的一个缓存。动画开始时 presentation layer开始移动，原始layer隐藏，动画结束时，presentation layer从屏幕上移除，原始layer显示。这就解释了为什么我们的视图在动画结束后又回到了原来的状态，因为它根本就没动过
     
     如果想让空间停留在动画结束的位置
     1. 把控件的layer的属性进行修改
     2.你可以通过设置动画的 fillMode 属性为 kCAFillModeForwards 以留在最终状态，并设置removedOnCompletion 为 NO 以防止它被自动移除
     
     */
    
    /**
     *  1.duration    动画的时长
     2.repeatCount  重复的次数。不停重复设置为 HUGE_VALF
     3.repeatDuration  设置动画的时间。在该时间内动画一直执行，不计次数
     4.beginTime       指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
     5.timingFunction    设置动画的速度变化
     6.autoreverses      动画结束时是否执行逆动画
     
     basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;//设置动画的速度变化
     basicAnimation.beginTime = CACurrentMediaTime();// 马上开始
     basicAnimation.fillMode = kCAFillModeForwards;
     basicAnimation.removedOnCompletion = NO;
     
     */
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = @1;
    basicAnimation.toValue = @0;
    basicAnimation.duration = 1;// 动画持续时间
    basicAnimation.repeatDuration = HUGE_VALF;//重复的次数。不停重复设置为 HUGE_VALF 
    return basicAnimation;
}
@end
