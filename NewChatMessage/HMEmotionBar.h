//
//  HMEmotionBar.h
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMEmotionBar : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property(strong, nonatomic) UICollectionView *emotionCollectionView;

@property(strong, nonatomic) NSMutableArray *emotions;

@end
