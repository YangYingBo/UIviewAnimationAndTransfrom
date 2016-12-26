//
//  UIButton+Category.m
//  masonry链式编程
//
//  Created by Loser on 16/11/25.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)
- (UIButton *(^)(NSString *))buttonNormalTitle
{
    return ^UIButton *(NSString *Normaltitle){
        
        [self setTitle:Normaltitle forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIColor *))buttonNormalColor
{
    return ^UIButton *(UIColor *NormalColor){
        [self setTitleColor:NormalColor forState:UIControlStateNormal];
        return self;
    };
}

-(UIButton *(^)(UIImage *))buttonNormalImg
{
    return ^UIButton *(UIImage *normalImg){
        [self setImage:normalImg forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(NSString *))buttonSelecteTitle
{
    return ^UIButton *(NSString *selecteTitle){
        [self setTitle:selecteTitle forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(UIColor *))buttonSelecteColor
{
    return ^UIButton *(UIColor *selecteColor){
        [self setTitleColor:selecteColor forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(UIImage *))buttonSelecteImg
{
    return ^UIButton *(UIImage *selecteImg){
        [self setImage:selecteImg forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(CGRect))buttonFrame
{
    return ^UIButton *(CGRect frame){
        self.frame = frame;
        return self;
    };
}

- (UIButton *(^)(float))buttonSystemFont
{
    return ^UIButton *(float fontSize){
        [self.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        return self;
    };
}

- (UIButton *(^)(NSUInteger))buttonTag
{
    return ^UIButton *(NSUInteger tag){
        self.tag = tag;
        return self;
    };
}

- (UIButton *(^)(id target,SEL action,UIControlEvents ControlEvents))buttonAddClickAction
{
    return ^UIButton *(id target,SEL action,UIControlEvents controlEvents){
        [self addTarget:target action:action forControlEvents:controlEvents];
        return self;
    };
}

- (UIButton *(^)(CGFloat width,CGFloat Radius,UIColor *color))buttonLayer
{
    return ^UIButton *(CGFloat width,CGFloat Radius,UIColor *color){
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
        self.layer.cornerRadius = Radius;
        return self;
    };
}

@end
