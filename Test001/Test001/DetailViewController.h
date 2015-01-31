//
//  DetailViewController.h
//  Test001
//
//  Created by xubojoy on 15/1/17.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

