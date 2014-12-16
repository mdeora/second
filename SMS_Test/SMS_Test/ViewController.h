//
//  ViewController.h
//  SMS_Test
//
//  Created by myStyle on 14-12-16.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *checkField;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, copy) NSString *telStr;


@end

