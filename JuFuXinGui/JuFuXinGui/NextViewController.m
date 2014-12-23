//
//  NextViewController.m
//  JuFuXinGui
//
//  Created by myStyle on 14-12-17.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NTViewController sharedController] hidesTabBar:YES animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设定位置和大小
    CGRect frame = CGRectMake(0,80,[UIScreen mainScreen].bounds.size.width,320);
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"play" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    webView.backgroundColor = [UIColor clearColor];
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
