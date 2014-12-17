//
//  MyNBTabController.m
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//

#import "RecommendViewController.h"
#import "NextViewController.h"
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        self.title = @"推荐项目";
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.delegate isHiddenCustomTabBarByBoolean:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton * button = [[UIButton alloc]initWithFrame:self.view.frame];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark 点击按钮进入其他界面

- (void)goOtherView:(UIButton *)sender{
    
    NextViewController * fifth = [[NextViewController alloc]init];
    [self.delegate isHiddenCustomTabBarByBoolean:YES];
    [self.navigationController pushViewController:fifth animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
