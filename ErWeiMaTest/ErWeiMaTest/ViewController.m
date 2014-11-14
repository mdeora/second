//
//  ViewController.m
//  ErWeiMaTest
//
//  Created by myStyle on 14-11-12.
//  Copyright (c) 2014年 XB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(50, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];

    
}
-(void)btnClick{
    
    // ADD: present a barcode reader that scans from the camera feed
    
    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc]init];
    
    reader.readerDelegate = self;
    
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    // TODO: (optional) additional reader configuration here
    
    
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    
    [scanner setSymbology: ZBAR_I25
     
                   config: ZBAR_CFG_ENABLE
     
                       to: 0];
    
    
    
    // present and release the controller
    
    [self presentViewController:reader animated:YES completion:^{
    }];
    

}

//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    
//    NSLog(@"info=%@",info);
//    // 得到条形码结果
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // 将获得到条形码显示到我们的界面上
////    resultText.text = symbol.data;
//    
//    // 扫描时的图片显示到我们的界面上
////    resultImage.image =[info objectForKey: UIImagePickerControllerOriginalImage];
////    
////    // 扫描界面退出
//    [reader dismissModalViewControllerAnimated: YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
