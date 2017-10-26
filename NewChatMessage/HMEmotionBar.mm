//
//  HMEmotionBar.m
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMEmotionBar.h"
#import "Masonry.h"
#import "HMEmotion.h"
#import "HMEmotionCell.h"

#define EmotionSize CGSizeMake(40, 40)
#define Inset 10

@implementation HMEmotionBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        //Layout subviews
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = EmotionSize;
        _emotionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _emotionCollectionView.backgroundColor = UIColor.whiteColor;
        _emotionCollectionView.contentInset = UIEdgeInsetsMake(Inset, Inset, Inset, Inset);
        _emotionCollectionView.delegate = self;
        _emotionCollectionView.dataSource = self;
        _emotionCollectionView.showsVerticalScrollIndicator = NO;
        [_emotionCollectionView registerClass:[HMEmotionCell class] forCellWithReuseIdentifier:[HMEmotionCell description]];
        [self addSubview:_emotionCollectionView];
        [_emotionCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //Init attributes
        _emotions = [NSMutableArray new];
        [self loadEmotion];
    }
    return self;
}

- (void)loadEmotion {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"iMomeetArray" ofType:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *emotionDicts = [dictionary objectForKey:@"Emotions"];
    for (NSDictionary *emotionDict in emotionDicts) {
        HMEmotion *emotion = [[HMEmotion alloc] initWithDictionary:emotionDict];
        [_emotions addObject:emotion];
    }
}

#pragma make - UICollectionview Delegate, DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _emotions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMEmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HMEmotionCell description] forIndexPath:indexPath];
    HMEmotion *emotion = (HMEmotion *)_emotions[indexPath.item];
    [cell.iconView setBackgroundImage:[UIImage imageNamed:emotion.icon] forState:UIControlStateNormal];
    return cell;
}

@end
