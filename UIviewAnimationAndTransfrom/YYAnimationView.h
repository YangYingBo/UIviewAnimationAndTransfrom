//
//  YYAnimationView.h
//  UIviewAnimationAndTransfrom
//
//  Created by Loser on 16/7/21.
//  Copyright © 2016年 Mac. All rights reserved.
//


typedef enum {
    YYAnimationLeftToRightType = 0,
    YYAnimationRightToLeftType,
    YYAnimationTopToBottomType,
    YYAnimationBottomToTopType
    
}YYAnimationType;

#import <UIKit/UIKit.h>

@interface YYAnimationView : UIView
/**
 *  按钮大小
 */
@property (nonatomic,assign) CGSize itmeSize;
/**
 *  每行按钮数量
 */
@property (nonatomic,assign) NSInteger lineItmeNumber;
/**
 *  按钮图片名字
 */
@property (nonatomic,strong) NSArray *imageNameArray;
/**
 *  按钮title
 */
@property (nonatomic,strong) NSArray *itmeTitleArray;
/**
 *  按钮字体大小
 */
@property (nonatomic,strong) UIFont *itmeTitleFont;

@property (nonatomic,assign) YYAnimationType animationType;
/**
 *  按钮点击事件回调
 */
@property (nonatomic,strong) void (^yyAnimationButtonItmeClick)(NSInteger tags);

- (instancetype)initImageNameArray:(NSArray *)imgs withItmeTitleArray:(NSArray *)titles;

- (void)addButtonItmeToAnimationView;

- (void)showAnimationView;

@end
