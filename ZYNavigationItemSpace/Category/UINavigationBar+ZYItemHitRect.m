//
//  UINavigationBar+ZYItemHitRect.m
//  ZYNavigationItemSpace
//
//  Created by 石志愿 on 2017/9/27.
//  Copyright © 2017年 石志愿. All rights reserved.
//

#import "UINavigationBar+ZYItemHitRect.h"

@implementation UINavigationBar (ZYItemHitRect)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    if (point.x<= kScreen_Width * 0.5) {
        for (UIBarButtonItem *buttonItem in self.topItem.leftBarButtonItems) {
            if (buttonItem.customView == nil) { continue; }
            /// 根据实际情况(自己项目UIBarButtonItem的层级)获取button
            UIButton *itemBtn = nil;
            if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
                itemBtn = (UIButton *)buttonItem.customView;
            } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
                itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
            }
            /// 将button的坐标系从父视图转化到UINavigationBar上
            CGRect newRect = [itemBtn convertRect:[itemBtn hitFrame] toView:self];
            /// 如果触摸点在button的响应范围内,让button响应此次触摸事件
            if (CGRectContainsPoint(newRect, point)) {
                view = itemBtn;
                break;
            }
        }
    } else {
        for (UIBarButtonItem *buttonItem in self.topItem.rightBarButtonItems) {
            if (buttonItem.customView == nil) { continue; }
            UIButton *itemBtn = nil;
            if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
                itemBtn = (UIButton *)buttonItem.customView;
            } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
                itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
            }
            CGRect newRect = [itemBtn convertRect:[itemBtn hitFrame] toView:self];
            if (CGRectContainsPoint(newRect, point)) {
                view = itemBtn;
                break;
            }
        }
    }
    return view;
}

@end
