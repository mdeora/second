//
//  MyNBTabController.h
//  NB2
//
//  Created by kohn on 13-11-16.
//  Copyright (c) 2013年 Kohn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@interface RecommendViewController : UIViewController
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@property (nonatomic, strong) NTViewController *ntvc;
@end
