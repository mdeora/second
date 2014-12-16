//
//  ViewController.m
//  SMS_Test
//
//  Created by myStyle on 14-12-16.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "ViewController.h"
#import "SMS_SDK/SMS_SDK.h"
#import "SMS_SDK/CountryAndAreaCode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
    self.phoneField.backgroundColor = [UIColor grayColor];
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneField];
    
    self.checkField = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 150, 30)];
    self.checkField.backgroundColor = [UIColor grayColor];
    self.checkField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.checkField];
    
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.checkBtn.frame = CGRectMake(200, 150, 60, 30);
//    self.checkBtn.backgroundColor = [UIColor purpleColor];
    [self.checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkBtn setTitle:@"获取" forState:UIControlStateNormal];
    [self.checkBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.checkBtn];
    
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 150, 30)];
    self.countLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.countLabel];
}

-(void)checkBtnClick:(UIButton *)sender{
    NSString* str=[NSString stringWithFormat:@"%@",self.phoneField.text];
    self.telStr = str;
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"确认手机号码" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSLog(@">>>>>>>>>>>>>>点击了确定按钮！！！！");
        [SMS_SDK getVerifyCodeByPhoneNumber:self.phoneField.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
            if (1==state) {
                NSLog(@"block 获取验证码成功");
                
                [self startTime];
            }
        }];
    }
   else if (buttonIndex == 0) {
       
        NSLog(@"点击了取消按钮");
    }
}


#pragma 开启时间线程
-(void)startTime{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.checkBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                self.checkBtn.titleLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:10.0];
                self.checkBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.checkBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                self.checkBtn.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:10.0];
                self.checkBtn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
