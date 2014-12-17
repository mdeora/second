//
//  ViewController.m
//  Play
//
//  Created by xubojoy on 14/12/17.
//  Copyright (c) 2014年 xubojoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (assign, nonatomic) BOOL isPlay;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isPlay = NO;
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn.backgroundColor  = [UIColor purpleColor];
    self.btn.frame = CGRectMake(30, 50, 100, 100);
    [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setTitle:@"播放" forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
}

-(void)click{
    self.isPlay =!self.isPlay;
    if (self.isPlay) {
       [self.btn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else{
        [self.btn setTitle:@"播放" forState:UIControlStateNormal];
    }


}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
