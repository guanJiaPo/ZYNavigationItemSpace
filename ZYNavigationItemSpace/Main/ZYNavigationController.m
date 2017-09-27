//
//  ZYNavigationController.m
//  ZYNavigationItemSpace
//
//  Created by 石志愿 on 2017/9/27.
//  Copyright © 2017年 石志愿. All rights reserved.
//

#import "ZYNavigationController.h"

@interface ZYNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ZYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
    [self.navigationBar setTintColor:[UIColor colorWithHexString:@"#2e2d33"]];
    [self.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#2e2d33"]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#29cc96"],NSFontAttributeName : [UIFont systemFontOfSize:14]}forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#26BF8C"], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateHighlighted];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.navigationItem.hidesBackButton = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back_pressed"] forState:UIControlStateHighlighted];
        [backButton setFrame:CGRectMake(0, 0, 44, 44)];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate

/** 每次viewController将要显示时都会调用此方法
 * 优点: 可以改变所有控制器的navigationItem的间距, 便于维护
 * 缺点: 每次控制器将要显示时都要设置button的内容偏移, 但也只是调用一次, 对性能影响不大, 所以本人选择在此设置button的内容偏移
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    /// 方案一
    [self resetBarItemSpacesWithController:viewController];
    
    /// 方案二 需要在0.01秒后调用, 否则可能获取不到UIStackView
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self resetNavigationBarItemSpaces];
//    });
}

#pragma mark - 方案一: 改变button的内容偏移和响应区域, 此方案同样适用iOS11之前

- (void)resetBarItemSpacesWithController:(UIViewController *)viewController {
    CGFloat space = kScreen_Width > 375 ? 20 : 16;
    for (UIBarButtonItem *buttonItem in viewController.navigationItem.leftBarButtonItems) {
        if (buttonItem.customView == nil) { continue; }
        /// 根据实际情况(自己项目UIBarButtonItem的层级)获取button
        UIButton *itemBtn = nil;
        if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
            itemBtn = (UIButton *)buttonItem.customView;
        } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
            itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
        }
        /// 设置button图片/文字偏移
        itemBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -space,0, 0);
        itemBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -space,0, 0);
        itemBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -space,0, 0);
        /// 改变button事件响应区域
        itemBtn.hitEdgeInsets = UIEdgeInsetsMake(0, -space, 0, space);
    }
    for (UIBarButtonItem *buttonItem in viewController.navigationItem.rightBarButtonItems) {
        if (buttonItem.customView == nil) { continue; }
        UIButton *itemBtn = nil;
        if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
            itemBtn = (UIButton *)buttonItem.customView;
        } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
            itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
        }
        itemBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0,0, -space);
        itemBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0, -space);
        itemBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0,0, -space);
        itemBtn.hitEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space);
    }
}

#pragma mark - 方案二: 改变私有API

- (void)resetNavigationBarItemSpaces {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 11.0) { return; }
    for (UIView *barContentView in self.navigationBar.subviews) {
        if ([NSStringFromClass([barContentView class]) isEqualToString:@"_UINavigationBarContentView"]) {
            for (NSLayoutConstraint *constraint in barContentView.constraints) {
                if ([NSStringFromClass([constraint.secondItem class]) isEqualToString:@"_UINavigationBarContentView"] && constraint.firstAttribute == NSLayoutAttributeTrailing) {
                    // 移除UIStackView左/右边12的间距
                    if ( constraint.secondAttribute == NSLayoutAttributeTrailing) {
                        [barContentView removeConstraint:constraint];
                    } else if (constraint.secondAttribute == NSLayoutAttributeLeading) {
                        [barContentView removeConstraint:constraint];
                    }
                }
            }
            for (UIView *stackView in barContentView.subviews) {
                if ([stackView isKindOfClass:[UIStackView class]]) {
                    if (CGRectGetMinX(stackView.frame) < kScreen_Width * 0.5) {
                        [stackView.superview addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:stackView.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
                    } else {
                        [stackView.superview addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:stackView.superview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
                    }
                    // 移除UITAMICAdaptorView左/右边8的间距(bug:当同一边有多个item时,其之间也没有间距)
                    for (NSLayoutConstraint *constraint in stackView.constraints) {
                        if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]]) {
                            if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem) {
                                [stackView removeConstraint:constraint];
                                break;
                            }
                        }
                    }
                }
            }
            break;
        }
    }
}
@end
