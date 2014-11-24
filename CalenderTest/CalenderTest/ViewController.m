//
//  ViewController.m
//  CalenderTest
//
//  Created by myStyle on 14-11-24.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
}

-(void)btnClick:(UIButton *)sender{
    self.pmCC = [[PMCalendarController alloc] init];
    self.pmCC.delegate = self;
    self.pmCC.mondayFirstDayOfWeek = YES;
    
    [self.pmCC presentCalendarFromView:sender
         permittedArrowDirections:PMCalendarArrowDirectionAny
                         animated:YES];
    /*    [pmCC presentCalendarFromRect:[sender frame]
     inView:[sender superview]
     permittedArrowDirections:PMCalendarArrowDirectionAny
     animated:YES];*/
    [self calendarController:self.pmCC didChangePeriod:self.pmCC.period];


}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    
    NSLog(@">>>>>>>>>>>日期：%@ - %@",[newPeriod.startDate dateStringWithFormat:@"yyyy年MM月dd日"], [newPeriod.endDate dateStringWithFormat:@"yyyy年MM月dd日"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
