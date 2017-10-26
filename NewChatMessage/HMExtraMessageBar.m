//
//  HMExtraMessageBar.m
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMExtraMessageBar.h"
#import "Masonry.h"

#define ImagePortraitSize CGSizeMake(150, 200)
#define ImageLandscapeSize CGSizeMake(200, 150)

#define VideoIconSize CGSizeMake(50, 50)
#define CloseButtonSize CGSizeMake(20, 20)

#define ImageCornerRadius 15


@implementation HMExtraMessageBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Layout subviews
        _extraImageView = [[UIImageView alloc] init];
        _extraImageView.contentMode = UIViewContentModeScaleToFill;
        _extraImageView.layer.cornerRadius = ImageCornerRadius;
        _extraImageView.layer.masksToBounds = YES;
        [self addSubview:_extraImageView];
        [_extraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeZero);
        }];
        
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.image = [UIImage imageNamed:@"gtk_media_play_ltr"];
        _videoImageView.hidden = YES;
        [self addSubview:_videoImageView];
        [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_extraImageView);
            make.size.mas_equalTo(VideoIconSize);
        }];
        
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"ic_chat_extra_view_close"] forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_extraImageView).offset(-10);
            make.right.equalTo(_extraImageView).offset(15);
            make.size.mas_equalTo(CloseButtonSize);
        }];
    }
    return self;
}

- (void)setExtraImage:(UIImage *)image isVideo:(BOOL)isVideo {
    CGSize imageSize = image.size;
    _extraImageView.image = image;
    if (imageSize.width > imageSize.height) {
        [_extraImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(ImageLandscapeSize);
        }];
    } else {
        [_extraImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(ImagePortraitSize);
        }];
    }
    
    _videoImageView.hidden = isVideo ? NO : YES;
}

@end
