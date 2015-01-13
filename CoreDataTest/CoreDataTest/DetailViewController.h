//
//  DetailViewController.h
//  CoreDataTest
//
//  Created by xubojoy on 15/1/11.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;
@interface DetailViewController : UIViewController

//@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

