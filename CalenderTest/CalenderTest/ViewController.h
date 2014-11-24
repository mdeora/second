//
//  ViewController.h
//  CalenderTest
//
//  Created by myStyle on 14-11-24.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCalendar.h"
@interface ViewController : UIViewController<PMCalendarControllerDelegate>
@property (nonatomic, strong) PMCalendarController *pmCC;

@end

