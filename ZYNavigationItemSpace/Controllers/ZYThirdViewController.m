//
//  ZYThirdViewController.m
//  ZYNavigationItemSpace
//
//  Created by 石志愿 on 2017/9/27.
//  Copyright © 2017年 石志愿. All rights reserved.
//

#import "ZYThirdViewController.h"

@interface ZYThirdViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ZYThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftBarButtonItem];
    [self setupRightBarButtonItem];
}

- (void)setupLeftBarButtonItem {
    
    [self.navigationItem hidesBackButton];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(0, 0, 62, 44)];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"#4d4d4d"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
}

- (void)setupRightBarButtonItem {
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setFrame:CGRectMake(0, 0, 62, 44)];
    [saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithHexString:@"#29cc96"] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithHexString:@"#1a805e"] forState:UIControlStateHighlighted];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButtonItem;
}

- (void)cancelButtonClicked {
    NSLog(@"点击了 取消 按钮");
    self.showLabel.text = @"点击了 取消 按钮";
}

- (void)saveButtonClicked {
    NSLog(@"点击了 保存 按钮");
    self.showLabel.text = @"点击了 保存 按钮";
}

- (IBAction)popClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
