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

#define ImageButtonIndex        0
#define CaptureButtonIndex      1
#define VideoButtonIndex        2
#define EmotionButtonIndex      3
#define LocationButtonIndex     4
#define AudioCallButtonIndex    5
#define VideoCallButtonIndex    6

#define NumberOfButton          7

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
    [cell.imageView removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    switch (indexPath.item) {
        case ImageButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_photo"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(imageCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Photos", nil);
            break;
        case CaptureButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"ic_menu_chat_action_camera"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(captureCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Camera", nil);
            break;
        case VideoButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_video"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(videoCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Videos", nil);
            break;
        case EmotionButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_emoji"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(emojiCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Emotion", nil);
            break;
        case LocationButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_location"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(locationCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Location", nil);
            break;
        case AudioCallButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_audio_call"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(audioCallCellClick) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLabel.text = NSLocalizedString(@"Audio call", nil);
            break;
        case VideoCallButtonIndex:
            [cell.imageView setImage:[UIImage imageNamed:@"icon_menu_chat_action_video_call"] forState:UIControlStateNormal];
            [cell.imageView addTarget:self action:@selector(videoCallCellClick) forControlEvents:UIControlEventTouchUpInside];
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
        case CaptureButtonIndex: {
            if (_captureButtonEnable) {
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

- (void)imageCellClick {
    [_delegate didSelectImageButton];
}

- (void)captureCellClick {
    [_delegate didSelectCaptureButton];
}

- (void)videoCellClick {
    [_delegate didSelectVideoButton];
}

- (void)emojiCellClick {
    [_delegate didSelectEmotionButton];
}

- (void)locationCellClick {
    [_delegate didSelectLocationButton];
}

- (void)audioCallCellClick {
    [_delegate didSelectAudioCallButton];
}

- (void)videoCallCellClick {
    [_delegate didSelectVideoCallButton];
}

@end
