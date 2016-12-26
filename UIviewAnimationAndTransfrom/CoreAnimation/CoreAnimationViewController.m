//
//  CoreAnimationViewController.m
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/12/16.
//  Copyright © 2016年 Mac. All rights reserved.
//


#define CABasicAnimationKeyPath                         @"position.x"

#import "CoreAnimationViewController.h"
#import "LoserAnimationView.h"
#import "UIButton+Category.h"


@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController
{
    UILabel *Hot;
    UIView *redBallView;
    UIImageView *potImg;
    CGFloat endFolat;
    UIImageView *showImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CoreAnimation";
    self.view.backgroundColor = [UIColor whiteColor];
#if 0
    Hot = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 100, 40)];
    Hot.text = @"火箭***********";
    Hot.backgroundColor = [UIColor blueColor];
    [self.view addSubview:Hot];
    
    
    potImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    potImg.image = [UIImage imageNamed:@"icon_close"];
    potImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:potImg];
    
    [LoserAnimationView showLoadingViewBossRoundDotInView];
    
    
    showImg = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, -50, 50, 50)];
    showImg.image = [UIImage imageNamed:@"tabbar_compose_friend"];
    showImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:showImg];
#endif
    
    
    NSArray *titleArray = @[@"常用圆点动画",@"Boss圆点动画",@"脉冲动画",@"画圈动画"];
    
    for (NSInteger index = 0; index < titleArray.count; index ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.buttonTag(100+index).buttonNormalTitle(titleArray[index]).buttonSystemFont(16).buttonFrame(CGRectMake(10, 80+60*index, self.view.frame.size.width-20, 40)).buttonNormalColor([UIColor blackColor]).buttonAddClickAction(self,@selector(choiceAnimationClick:),UIControlEventTouchUpInside).buttonLayer(0.5,5,[UIColor blueColor]);
        [self.view addSubview:btn];
        
    }
    
    // 动画移动
//    [self HowUseCABasicAnimation];
//    [self howUseCAKeyframeAnimation];
    
}


- (void)choiceAnimationClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
            [LoserAnimationView showLoadingViewDefautRoundDotInView];
            break;
        case 1:
            [LoserAnimationView showLoadingViewBossRoundDotInView];
            break;
        case 2:
            [LoserAnimationView showLoadingViewPulseRoundDotInView];
            break;
        case 3:
            [LoserAnimationView showLoadingViewDefautLineRoundInView];
            break;
            
        default:
            break;
    }
}

- (void)HowUseCABasicAnimation
{
    
    /**
        首先我们需要搞明白一点的是，layer动画运行的过程是怎样的？其实在我们给一个视图添加layer动画时，真正移动并不是我们的视图本身，而是presentation layer 的一个缓存。动画开始时 presentation layer开始移动，原始layer隐藏，动画结束时，presentation layer从屏幕上移除，原始layer显示。这就解释了为什么我们的视图在动画结束后又回到了原来的状态，因为它根本就没动过
     
     如果想让空间停留在动画结束的地方
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
     */
    // 使用方法animationWithKeyPath:对 CABasicAnimation进行实例化，
    // 并指定Layer的属性(position.x 改变x轴)作为关键路径进行注册
    CABasicAnimation *caBasicAnimation = [CABasicAnimation animationWithKeyPath:CABasicAnimationKeyPath];
    // 开始位置
    caBasicAnimation.fromValue = @10;
    // 结束为止
//    caBasicAnimation.toValue = @300;
    /**
     *  所改变属性相同起始值的改变量
        相当于  定义了 fromeValue 和 byValue   就会知道toValue = fromeValue + byValue
        所以    定义了 toValue 和 byValue   就会知道fromeValue = toValue - byValue
     */
    caBasicAnimation.byValue = @200;
    // 动画持续时间
    caBasicAnimation.duration = 1;
//    caBasicAnimation.autoreverses = YES;//动画结束时是否执行逆动画
//    caBasicAnimation.repeatDuration = HUGE_VALF;//重复的次数。不停重复设置为 HUGE_VALF
    /**
     timingFunction  设置动画的速度变化
     1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
     2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
     3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
     4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加
     5.kCAMediaTimingFunctionDefault (默认)
     */
    caBasicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;//设置动画的速度变化
    caBasicAnimation.beginTime = CACurrentMediaTime();// 马上开始
    caBasicAnimation.fillMode = kCAFillModeForwards;
    caBasicAnimation.removedOnCompletion = NO;
    [Hot.layer addAnimation:caBasicAnimation forKey:@"basic"];
}

/**
 *  关键帧动画 左右抖动
 */
- (void)howUseCAKeyframeAnimation
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:CABasicAnimationKeyPath];
    // values里面放的是控件应该到的位置
    keyAnimation.values= @[@0,@10,@-10,@10,@0];
    // 设置 keyTimes 属性让我们能够指定关键帧动画发生的时间
    //可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
//    keyAnimation.keyTimes = @[@0,@(1/6.),@(3/6.),@(5/6.),@1];
    keyAnimation.duration = 0.6;
    keyAnimation.additive = YES;// 是动画恒定的速度
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;//设置动画的速度变化
    [Hot.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
    

   
    
}
/**
 *  上下晃动
 */
- (void)howUseCAKeyframeAnimationTopAndBottom
{
   
    CAKeyframeAnimation *keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyanimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeRotation((0)/180.0 * M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation((15)/180.0 * M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15)/180.0 * M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation((15)/180.0 * M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation((0)/180.0 * M_PI, 0, 0, 1)]
                            ];
//    keyanimation.keyTimes = @[@0.5,@0.5,@0.5,@0.5];
    keyanimation.duration = 0.5;
    keyanimation.additive = YES;
    [Hot.layer addAnimation:keyanimation forKey:@"topAndBottom"];
    

}

- (void)howUseCAKeyframeAnimationRotation
{
    CAKeyframeAnimation *RotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    RotationAnimation.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(-20, 0, 200, 200), NULL));
    
    RotationAnimation.additive = YES;
    RotationAnimation.duration = 4;
    // 使用 calculationMode 是控制关键帧动画时间的另一种方法。我们通过将其设置为 kCAAnimationPaced，让 Core Animation 向被驱动的对象施加一个恒定速度，不管路径的各个线段有多长。将其设置为 kCAAnimationPaced 将无视所有我们已经设置的 keyTimes
    RotationAnimation.calculationMode = kCAAnimationPaced;
    //设置 rotationMode 属性为 kCAAnimationRotateAuto 确保飞船沿着路径旋转
    RotationAnimation.rotationMode = kCAAnimationRotateAuto;
    RotationAnimation.repeatDuration = HUGE_VALF;
    [Hot.layer addAnimation:RotationAnimation forKey:@"rotation"];
    
}


- (void)howUseCAAnimationGroup
{
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.values = @[@0,@-0.3,@0.];
    rotation.duration = 1;
    rotation.additive = YES;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(-10, 30)],
                        [NSValue valueWithCGPoint:CGPointZero]];// value是控件的偏移量
    position.duration = 1;
    position.additive = YES;
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotation,position];
    group.duration = 1;
    [potImg.layer addAnimation:group forKey:@"group"];
}


- (void)howUseCAAnimationGroup2
{
//    CAKeyframeAnimation *position_y = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
//    
//    position_y.values = @[@0,@(self.view.frame.size.height/2+25)];
//    position_y.duration = 1.0;
////    position_y.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    position_y.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////    position_y.fillMode = kCAFillModeForwards;
////    position_y.removedOnCompletion = NO;
    
    CABasicAnimation *position_y = [CABasicAnimation animationWithKeyPath:@"position.y"];
    position_y.fromValue = @(-0);
    position_y.toValue = @(self.view.frame.size.height/2 + 25);
    position_y.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    position_y.duration = 1.0;
    
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.values = @[@0,@-0.5];
    rotation.duration = 1;
    rotation.additive = YES;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

    
    
    
    CABasicAnimation *position_y1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
//    position_y1.fromValue = @(self.view.frame.size.height/2 + 25);
    position_y1.toValue = @(self.view.frame.size.height+25);
//    position_y1.values = @[@0,@(self.view.frame.size.height)];
    position_y1.duration = 1.0;
    //    position_y.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position_y1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[position_y,rotation,position_y1];
    group.duration = 1.0;
//    group.fillMode = kCAFillModeBackwards;
//    group.removedOnCompletion = NO;
    [showImg.layer addAnimation:group forKey:@"showGroup"];
    
//    [showImg.layer addAnimation:rotation forKey:@"rotation"];
    
    
}

- (void)drawCircle
{
    CAShapeLayer *circleL = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
    circleL.path = path.CGPath;
    circleL.strokeColor = [UIColor blackColor].CGColor;
    circleL.lineWidth = 1.0;
    circleL.strokeStart = 0;
    circleL.strokeEnd = 0.0;
    circleL.fillColor = [UIColor clearColor].CGColor;
    
    endFolat = 0.0;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        endFolat += 0.033;
        NSLog(@"%f",endFolat);
        
        if (endFolat >= 1.f) {
            endFolat = 1.f;
            dispatch_source_cancel(timer);
        }
        circleL.strokeEnd = endFolat;
    });
    dispatch_resume(timer);
    [potImg.layer addSublayer:circleL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self loadingReplicatorLayer_Translation];
    
    
}



- (CAShapeLayer *)creatShapeLayerWithRadius:(CGFloat)radius
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    return shapeLayer;
}


- (CAReplicatorLayer *)creatReplicatorLayerWithCount:(NSInteger)count tranform:(CATransform3D) transform  copyLayer:(CALayer*)copyLayer
{
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.instanceCount = count; // 要复制的子layer(count-1)个
    repLayer.instanceTransform = transform;// 复制之后所有子layer在矩阵的位置
    repLayer.frame = copyLayer.frame;//要复制的子layer 的frame
    repLayer.instanceDelay = 1.0/count;// 每隔多长时间出现一个layer
    [repLayer addSublayer:copyLayer];
    return repLayer;
}

- (void)loadingReplicatorLayer_RoundDot
{
    CAShapeLayer *shapeLayer = [self creatShapeLayerWithRadius:20];// 创建一个圆
    [shapeLayer addAnimation:[self addReplicatorLayerScaleAnition] forKey:@"addscale"];
    shapeLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);// 初始化圆时候的透明度
    NSInteger subviewCount = 15;
    
    CATransform3D trans3D = CATransform3DMakeRotation(3*M_PI/subviewCount, 0, 0, 1);// 每个圆点的位置
    CAReplicatorLayer *rountLayer = [self creatReplicatorLayerWithCount:subviewCount tranform:trans3D copyLayer:shapeLayer];
    rountLayer.bounds = CGRectMake(0, 0, 100, 100);// 控制圆点的范围
    rountLayer.position = CGPointMake(50, 50);// 控制圆点转动的中心
    [potImg.layer addSublayer:rountLayer];
}

- (void)loadingReplicatorLayer_Translation
{
    CAShapeLayer *shapeLayer = [self creatShapeLayerWithRadius:20];// 创建一个圆
    [shapeLayer addAnimation:[self addReplicatorLayerScaleAnition] forKey:@"addscale"];
    shapeLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);// 初始化圆时候的透明度
    NSInteger subviewCount = 3;
    
    CATransform3D trans3D = CATransform3DMakeRotation(3*M_PI/subviewCount, 0, 0, 1);// 每个圆点的位置
    CATransform3D trans3d = CATransform3DMakeTranslation(Hot.frame.size.width/subviewCount, 0, 1);
    CAReplicatorLayer *rountLayer = [self creatReplicatorLayerWithCount:subviewCount tranform:trans3d copyLayer:shapeLayer];
//    rountLayer.bounds = CGRectMake(0, 0, 100, 40);// 控制圆点的范围
//    rountLayer.position = CGPointMake(100, 100);// 控制圆点转动的中心
    [Hot.layer addSublayer:rountLayer];
}

-(CABasicAnimation *)addReplicatorLayerScaleAnition
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.duration = 1;
    animation.repeatDuration = HUGE_VALF;
    return animation;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
