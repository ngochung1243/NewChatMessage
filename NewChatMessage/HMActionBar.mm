//
//  HMActionBar.m
//  NewChatMessage
//
//  Created by admin on 10/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMActionBar.h"
#import "HMActionCell.h"
#import "Masonry.h"

#define ImageButtonIndex 0
#define VideoButtonIndex 1
#define EmotionButtonIndex 2
#define LocationButtonIndex 3
#define AudioCallButtonIndex 4
#define VideoCallButtonIndex 5

#define NumberOfButton 6

#define ButtonSize CGSizeMake(60, 80)

@implementation HMActionBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        //Layout collection view
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setContentInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        _collectionView.backgroundColor = UIColor.whiteColor;
        [_collectionView registerClass:[HMActionCell class] forCellWithReuseIdentifier:[HMActionCell description]];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //Init attributes
        _imageButtonEnable = YES;
        _videoButtonEnable = YES;
        _emotionButtonEnable = YES;
        _locationButtonEnable = YES;
        _audioCallEnable = YES;
        _videoCallEnable = YES;
    }
    return self;
}

#pragma mark - UICollectionView Delegate & DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NumberOfButton;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HMActionCell description] forIndexPath:indexPath];
    switch (indexPath.item) {
        case ImageButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_photo"];
            cell.titleLabel.text = NSLocalizedString(@"Photos", nil);
            break;
        case VideoButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_video"];
            cell.titleLabel.text = NSLocalizedString(@"Videos", nil);
            break;
        case EmotionButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_emoji"];
            cell.titleLabel.text = NSLocalizedString(@"Emotion", nil);
            break;
        case LocationButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_location"];
            cell.titleLabel.text = NSLocalizedString(@"Location", nil);
            break;
        case AudioCallButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_audio_call"];
            cell.titleLabel.text = NSLocalizedString(@"Audio call", nil);
            break;
        case VideoCallButtonIndex:
            cell.imageView.image = [UIImage imageNamed:@"icon_menu_chat_action_video_call"];
            cell.titleLabel.text = NSLocalizedString(@"Video call", nil);
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case ImageButtonIndex: {
            if (_imageButtonEnable) {
                return ButtonSize;
            }
        }
        case VideoButtonIndex: {
            if (_videoButtonEnable) {
                return ButtonSize;
            }
        }
        case EmotionButtonIndex: {
            if (_emotionButtonEnable) {
                return ButtonSize;
            }
        }
        case LocationButtonIndex: {
            if (_locationButtonEnable) {
                return ButtonSize;
            }
        }
        case AudioCallButtonIndex: {
            if (_audioCallEnable) {
                return ButtonSize;
            }
        }
        case VideoCallButtonIndex: {
            if (_videoCallEnable) {
                return ButtonSize;
            }
        }
        default:
            break;
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case ImageButtonIndex: {
            [_delegate didSelectImageButton];
            break;
        }
        case VideoButtonIndex: {
            [_delegate didSelectVideoButton];
            break;
        }
        case EmotionButtonIndex: {
            [_delegate didSelectEmotionButton];
            break;
        }
        case LocationButtonIndex: {
            [_delegate didSelectLocationButton];
            break;
        }
        case AudioCallButtonIndex: {
            [_delegate didSelectAudioCallButton];
            break;
        }
        case VideoCallButtonIndex: {
            [_delegate didSelectVideoCallButton];
            break;
        }
        default:
            break;
    }
}

@end
