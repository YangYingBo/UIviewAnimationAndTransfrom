//
//  ViewController.m
//  UIviewAnimationAndTransfrom
//
//  Created by Mac on 16/7/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "YYTypeButton.h"

#define screWidth    self.view.frame.size.width

#define screHeight   self.view.frame.size.height

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) UIView *btnSuperView;
@property (nonatomic,strong) YYTypeButton *closeBtn;
@end

@implementation ViewController
{
    BOOL isClose;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"UIviewAnimationAndTransfrom";
    self.view.backgroundColor = [UIColor grayColor];
    
    /**
     *  CGAffineTransformMakeTranslation       // 在原有的基础上平移
     CGAffineTransformMakeScale             // 在原有基础上缩放
     CGAffineTransformMakeRotation          // 在原有基础上旋转
     CGAffineTransformIdentity              // 在原有基础上的设置还原
     */
    
    
    
    
    /**
     [UIView animateWithDuration:动画时间 animations:动画设置代码块]
     [UIView animateWithDuration:动画时间 animations:动画设置代码块 completion:动画完成]
     [UIView animateWithDuration:动画时间 delay:动画等待执行时间 options:动画过渡效果 animations:动画设置代码块 completion:动画完成]
     [UIView animateWithDuration:动画时间 delay:动画等待执行时间  usingSpringWithDamping:类似弹簧振动效果 0-1.0 initialSpringVelocity:初始速度 options:动画过渡效果 animations:动画设置代码块 completion:动画完成]
     添加关键帧方法
     [UIView animateKeyframesWithDuration:动画时长 delay:动画等待执行时间 options:动画效果选项 animations:动画设置代码块 completion:动画完成]
     [UIView addKeyframeWithRelativeStartTime:动画相对开始时间 relativeDuration:动画相对持续时间 animations:动画设置代码块]
     
     */
    
    
    
    [self.view addSubview:self.btnSuperView];
    [self.btnSuperView addSubview:self.closeBtn];
    
    NSArray *imgNameArray = @[@"tabbar_compose_camera"
                              ,@"tabbar_compose_friend"
                              ,@"tabbar_compose_idea"
                              ,@"tabbar_compose_music"
                              ,@"tabbar_compose_photo"
                              ,@"tabbar_compose_more"];
    
    NSArray *titleArray = @[@"相机"
                            ,@"朋友"
                            ,@"消息"
                            ,@"音乐"
                            ,@"相机"
                            ,@"更多"];
    NSInteger spase = (self.view.frame.size.width - 3*120)/4;
    CGFloat btnWidth = 120;
    
    for (NSInteger index = 0; index < imgNameArray.count; index ++) {
        YYTypeButton *myButton = [YYTypeButton buttonWithType:UIButtonTypeCustom];
        myButton.frame = CGRectMake(spase + (spase + btnWidth) * (index % 3), self.view.center.y-120 + btnWidth * (index/3), btnWidth, btnWidth);
        myButton.tag = 100 + index;
        [myButton setMyTypeButtonImage:[UIImage imageNamed:imgNameArray[index]] withTitle:titleArray[index] withTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(myTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnSuperView addSubview:myButton];
        [self.btnArray addObject:myButton];
        myButton.transform = CGAffineTransformMakeTranslation(0, screHeight);
    }
}


- (void)myTypeButtonClick:(UIButton *)sender
{
    __block typeof(_btnSuperView) weakSupView = _btnSuperView;
    for (NSInteger index = 0; index < _btnArray.count; index ++) {
        __block YYTypeButton *btn = _btnArray[index];
        
        if (btn == sender) {
            [UIView animateWithDuration:0.5 animations:^{
//                btn.transform = CGAffineTransformMakeScale(3, 3);
                // 放大
                btn.layer.transform = CATransform3DMakeScale(3, 3, 1);
                btn.alpha = 0;
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    [weakSupView removeFromSuperview];
                }];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                // 缩小
                btn.transform = CGAffineTransformMakeScale(0.001, 0.001);
                btn.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (NSInteger index = 0; index < _btnArray.count; index ++) {
        __block YYTypeButton *btn = _btnArray[index];
        [UIView animateWithDuration:0.5 delay:index * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}


-(NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    
    return _btnArray;
}

-(UIView *)btnSuperView
{
    if (!_btnSuperView) {
        _btnSuperView = [[UIView alloc] initWithFrame:self.view.bounds];
        _btnSuperView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    return _btnSuperView;
}

-(YYTypeButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [YYTypeButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setMyTypeButtonBackgroundImage:[UIImage imageNamed:@"icon_close"] withTitle:nil withTitleColor:nil forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeSuperButtonView) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.frame = CGRectMake((screWidth - 30)/2, screHeight - 30, 30, 30);
//        _closeBtn.transform = CGAffineTransformMakeRotation(M_PI/4);
    }
    
    return _closeBtn;
}

- (void)closeSuperButtonView
{
    if (!isClose) {
        // 把数组里面的 数据倒转过来
        NSArray *array = [[_btnArray reverseObjectEnumerator] allObjects];
        
        for (NSInteger index = 0; index < array.count; index ++) {
            __block YYTypeButton *btn = array[index];
            [UIView animateWithDuration:0.5 delay:index * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                // 平移到屏幕下面
                btn.transform = CGAffineTransformMakeTranslation(0, screHeight);
            } completion:^(BOOL finished) {
                
            }];
        }
        [UIView animateWithDuration:0.5 animations:^{
            // 旋转45°
            _closeBtn.transform = CGAffineTransformMakeRotation(-M_PI/4);
        }];

    }
    else
    {
        for (NSInteger index = 0; index < _btnArray.count; index ++) {
            __block YYTypeButton *btn = _btnArray[index];
            [UIView animateWithDuration:0.5 delay:index * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                // 还原上次设置
                btn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            _closeBtn.transform = CGAffineTransformIdentity;
        }];
    }
    
    
    
    isClose = !isClose;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
