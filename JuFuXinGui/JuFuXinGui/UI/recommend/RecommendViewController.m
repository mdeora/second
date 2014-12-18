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
        self.view.backgroundColor = [UIColor whiteColor];
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
    [self initBtn];
    [self initScrollView];
}

-(void)initBtn{

    UIButton * button = [[UIButton alloc]initWithFrame:self.view.frame];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(goOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//初始化自动轮播视图
-(void)initScrollView{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    for (int i = 0; i < 5; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        tempLabel.text = @"春运票荒！！！";
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.backgroundColor = [(UIColor *)[colorArray objectAtIndex:i] colorWithAlphaComponent:0.5];
        [viewsArray addObject:tempLabel];
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 150) animationDuration:2];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0];
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 5;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",pageIndex);
    };
    [self.view addSubview:self.mainScorllView];

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
