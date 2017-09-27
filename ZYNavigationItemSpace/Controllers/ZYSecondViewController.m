//
//  ZYSecondViewController.m
//  ZYNavigationItemSpace
//
//  Created by 石志愿 on 2017/9/27.
//  Copyright © 2017年 石志愿. All rights reserved.
//

#import "ZYSecondViewController.h"

@interface ZYSecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ZYSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightBarButtonItem];
}

- (void)setupRightBarButtonItem {
    
    UIButton *questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionButton setImage:[UIImage imageNamed:@"question_normal"] forState:UIControlStateNormal];
    [questionButton setImage:[UIImage imageNamed:@"question_heighted"] forState:UIControlStateHighlighted];
    [questionButton setFrame:CGRectMake(0, 0, 44, 44)];
    [questionButton addTarget:self action:@selector(questionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:questionButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)questionButtonClicked {
    self.showLabel.text = @"点击了 rightBarButtonItem";
}

@end
