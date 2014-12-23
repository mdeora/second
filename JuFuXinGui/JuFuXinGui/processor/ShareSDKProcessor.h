//
//  ShareSDKProcessor.h
//  styler
//
//  Created by wangwanggy820 on 14-8-8.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareContent.h"
<<<<<<< HEAD
#import <ShareSDK/ShareSDK.h>
=======

>>>>>>> 4b83cea78f217faa6da38ccde81864c406c38ac8

@interface ShareSDKProcessor : NSObject<ISSShareViewDelegate>

- (void)share:(ShareContent *)shareContent shareViewDelegate:(id)shareViewDelegate sender:(id)sender shareSuccessBlock:(void(^)())shareSuccessBlock;

+(void)customShareView:(UIViewController *)viewController;

+(void)initShareSDK;

-(void)followWeiXinTimeLine:(id)sender
               shareContent:(ShareContent *)shareContent
          shareSuccessBlock:(void(^)())shareSuccessBlock;

@end
