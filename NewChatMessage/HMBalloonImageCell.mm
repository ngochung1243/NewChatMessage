//
//  HMBaloonImageCell.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonImageCell.h"

#define ImagePortraitSize CGSizeMake(100, 150)
#define ImageLandscapeSize CGSizeMake(150, 100)

@implementation HMBalloonImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageMessageView = [[UIButton alloc] init];
        _imageMessageView.layer.cornerRadius = 10;
        _imageMessageView.backgroundColor = UIColor.blueColor;
        _imageMessageView.contentMode = UIViewContentModeScaleToFill;
        [_imageMessageView setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        [self.balloonImageView addSubview:_imageMessageView];
        
        //Init attributes
        imageSize = ImagePortraitSize;
        self.cellType = Image;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isMine) {
        [_imageMessageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balloonImageView).offset(OffsetEdge);
            make.right.equalTo(self.balloonImageView).offset(-OffsetEdge - 2);
            make.size.mas_equalTo(imageSize).priorityHigh();
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.avatarView.mas_left);
            make.top.equalTo(self.contentView);
            make.left.equalTo(_imageMessageView).offset(-OffsetEdge);
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    } else {
        [_imageMessageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balloonImageView).offset(OffsetEdge);
            make.left.equalTo(self.balloonImageView).offset(OffsetEdge + 5);
            make.size.mas_equalTo(imageSize).priorityHigh();
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right);
            make.top.equalTo(self.contentView);
            make.right.equalTo(_imageMessageView).offset(OffsetEdge);
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    }
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageMessageView.mas_bottom).offset(10).priorityHigh();
        make.left.mas_equalTo(_imageMessageView);
        make.right.mas_equalTo(_imageMessageView);
    }];
}

- (void)populateMessage:(NSString *)messageEvent {
    [super populateMessage:messageEvent];
    imageSize = ImageLandscapeSize;
}

@end
