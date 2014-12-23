//
//  ViewController.h
//  CollectionViewTest
//
//  Created by xubojoy on 14/12/23.
//  Copyright (c) 2014年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

