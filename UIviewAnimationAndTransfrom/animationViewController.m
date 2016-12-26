//
//  animationViewController.m
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/7/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "animationViewController.h"
#import "YYAnimationView.h"

@interface animationViewController ()

@end

@implementation animationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"animationViewController";
    
    
    
    UIButton *animationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    animationBtn.frame = CGRectMake(100, 200, 200, 50);
    
    [animationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [animationBtn setTitle:@"animationViewController" forState:UIControlStateNormal];
    [animationBtn addTarget:self action:@selector(showAnimationView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animationBtn];
}

- (void)showAnimationView
{
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
    
    __block typeof(self) weakSelf = self;
    
    YYAnimationView *animationView = [[YYAnimationView alloc] initImageNameArray:imgNameArray withItmeTitleArray:titleArray];
    animationView.lineItmeNumber = 3;
    animationView.itmeSize = CGSizeMake(120, 120);
    animationView.itmeTitleFont = [UIFont systemFontOfSize:15];
    animationView.animationType = YYAnimationTopToBottomType;
    [animationView addButtonItmeToAnimationView];
    [animationView showAnimationView];
    animationView.yyAnimationButtonItmeClick = ^( NSInteger tags){
        NSLog(@"tags  %ld",(long)tags);
        
        NSUInteger intg = [weakSelf randomIntBetweenNumber:2 andNumber:tags];
        NSLog(@"intg    %lu",(unsigned long)intg);
    };
}


- (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber
{
    if (minNumber > maxNumber) {
        return [self randomIntBetweenNumber:maxNumber andNumber:minNumber];
    }
    // 获取随机数范围在[minNumber maxNumber]之间包括两端数值
    NSUInteger i = (arc4random() % (maxNumber - minNumber + 1)) + minNumber;
    
    return i;
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
