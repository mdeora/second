//
//  ShareContent.h
//  styler
//
//  Created by wangwanggy820 on 14-8-8.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
<<<<<<< HEAD
#import <ShareSDK/ShareSDK.h>
=======
>>>>>>> 4b83cea78f217faa6da38ccde81864c406c38ac8
@interface ShareContent : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *sinaWeiBoContent;
@property (assign, nonatomic) UIImage *sinaWeiBoImage;
@property (copy, nonatomic) NSString *url;
@property (assign, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *imageUrl;

-(id)initWithTitle:(NSString *)title
           content:(NSString *)content
  sinaWeiBoContent:(NSString *)sinaWeiBoContent
               url:(NSString *)url
             image:(UIImage *)image
          imageUrl:(NSString *)imageUrl;

@end
