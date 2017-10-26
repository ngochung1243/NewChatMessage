//
//  HMActionBar.h
//  NewChatMessage
//
//  Created by admin on 10/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMActionBarDelegate <NSObject>

- (void)didSelectImageButton;
- (void)didSelectCaptureButton;
- (void)didSelectVideoButton;
- (void)didSelectEmotionButton;
- (void)didSelectLocationButton;
- (void)didSelectAudioCallButton;
- (void)didSelectVideoCallButton;

@end

@interface HMActionBar : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(strong, nonatomic) UICollectionView *collectionView;

@property(weak, nonatomic) id<HMActionBarDelegate> delegate;
@property(nonatomic) BOOL imageButtonEnable;
@property(nonatomic) BOOL captureButtonEnable;
@property(nonatomic) BOOL videoButtonEnable;
@property(nonatomic) BOOL emotionButtonEnable;
@property(nonatomic) BOOL locationButtonEnable;
@property(nonatomic) BOOL audioCallEnable;
@property(nonatomic) BOOL videoCallEnable;

@end
