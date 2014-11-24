//
//  ViewController.m
//  SVNTest
//
//  Created by myStyle on 14-11-21.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "ViewController.h"

#define kAnimationDuration 5.0
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    self.imgArray = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:@"campFire01.gif"],
                     [UIImage imageNamed:@"campFire02.gif"],
                     [UIImage imageNamed:@"campFire03.gif"],
                     [UIImage imageNamed:@"campFire04.gif"],
                     [UIImage imageNamed:@"campFire05.gif"],
                     [UIImage imageNamed:@"campFire06.gif"],
                     [UIImage imageNamed:@"campFire07.gif"],
                     [UIImage imageNamed:@"campFire08.gif"],
                     [UIImage imageNamed:@"campFire09.gif"],
                     nil];
        [self initImageView];
}

-(void) initImageView{
    
    for (int i=0; i<9; i++) {
        CGRect frame;
        frame.size.width = 59;//设置按钮坐标及大小
        frame.size.height = 75;
        frame.origin.x = (i%3)*(59+32)+40;
        frame.origin.y = floor(i/3)*(75+24)+40;
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.backgroundColor = [UIColor cyanColor];
        self.imageView.image = [self.imgArray objectAtIndex:i];
        self.imageView.tag = i;
        [self rotate360DegreeWithImageView:self.imageView];
        [self.view addSubview:self.imageView];
    }
}

- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView {
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0)];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0) ];
    animation.duration = 1;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
    animation.repeatCount = 0;
//    animation.removedOnCompletion = YES;
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:imageRrect];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [imageView.layer addAnimation:animation forKey:nil ];
 
    return imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
