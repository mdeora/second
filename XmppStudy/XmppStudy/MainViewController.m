//
//  MainViewController.m
//  XmppStudy
//
//  Created by myStyle on 14-11-26.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initLogin];
}

-(void)initLogin{
    
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 80, 30)];
    self.nameLab.textAlignment = NSTextAlignmentRight;
    self.nameLab.text = @"用户名：";
    [self.view addSubview:self.nameLab];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(120, 80, 150, 30)];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"请输入用户名";
    [self.view addSubview:self.nameField];
    
    self.pwdLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 80, 30)];
    self.pwdLab.textAlignment = NSTextAlignmentRight;
    self.pwdLab.text = @"密  码：";
    [self.view addSubview:self.pwdLab];
    
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(120, 120, 150, 30)];
    self.pwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdField.placeholder = @"请输入密码";
    [self.view addSubview:self.pwdField];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(120, 200, 100, 40);
    self.loginBtn.backgroundColor = [UIColor purpleColor];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
}

-(void)loginBtnClick:(UIButton *)sender {
    
    if ([self validateWithUser:self.nameField.text andPass:self.pwdField.text]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.nameField.text forKey:@"userName"];
        [defaults setObject:self.pwdField.text forKey:@"pwd"];
        //保存
        [defaults synchronize];
        
        [self dismissModalViewControllerAnimated:YES];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名，密码和服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    MainViewController *mvc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
    
}

-(BOOL)validateWithUser:(NSString *)userText andPass:(NSString *)passText{
    
    if (userText.length > 0 && passText.length > 0) {
        return YES;
    }
    
    return NO;
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
