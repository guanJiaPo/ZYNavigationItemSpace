//
//  ZYFirstViewController.m
//  ZYNavigationItemSpace
//
//  Created by 石志愿 on 2017/9/27.
//  Copyright © 2017年 石志愿. All rights reserved.
//

#import "ZYFirstViewController.h"

@interface ZYFirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ZYFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightBarButtonItem];
}

- (void)setupRightBarButtonItem {
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"search_highlighted"] forState:UIControlStateHighlighted];
    [searchButton setFrame:CGRectMake(0, 0, 44, 44)];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)searchButtonClicked {
    self.showLabel.text = @"点击了search按钮";
}

@end
