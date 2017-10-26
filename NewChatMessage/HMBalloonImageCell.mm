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
#define DownloadButtonSize CGSizeMake(15, 15)

@implementation HMBalloonImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Layout subviews
        _imageMessageView = [[UIImageView alloc] init];
        _imageMessageView.image = [UIImage imageNamed:@"test"];
        _imageMessageView.contentMode = UIViewContentModeScaleToFill;
        [self.balloonImageView addSubview:_imageMessageView];
        
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setImage:[UIImage imageNamed:@"ic_download"] forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _downloadButton.hidden = YES;
        [self.contentView addSubview:_downloadButton];
        
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textColor = [UIColor colorWithRed:0.169 green:0.53 blue:0.949 alpha:1.0];
        _progressLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_progressLabel];
        
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
            make.size.mas_equalTo(imageSize);
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
            make.size.mas_equalTo(imageSize);
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right);
            make.top.equalTo(self.contentView);
            make.right.equalTo(_imageMessageView).offset(OffsetEdge);
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    }
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageMessageView.mas_bottom).offset(10);
        make.left.mas_equalTo(_imageMessageView);
        make.right.mas_equalTo(_imageMessageView);
    }];
    
    [_downloadButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel);
        make.right.equalTo(_imageMessageView);
        make.size.mas_equalTo(DownloadButtonSize);
    }];
    
    [_progressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_downloadButton);
        make.right.equalTo(_imageMessageView);
    }];
}

#pragma mark - Action
- (void)populateMessage:(NSString *)messageEvent {
    [super populateMessage:messageEvent];
    imageSize = ImageLandscapeSize;
    _downloadButton.hidden = NO;
    _progressLabel.hidden = YES;
}

- (void)handleAction {
    NSLog(@"[HM] - Show Media");
}

- (void)downloadButtonClick {
    _downloadButton.hidden = YES;
    _progressLabel.hidden = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _progressLabel.text = [NSString stringWithFormat:@"%d%%", count];
        count += 1;
        if (count == 100) {
            [self animateShowDoneDownloadButton];
            [timer invalidate];
        }
    }];
}

- (void)animateShowDoneDownloadButton {
    _progressLabel.hidden = YES;
    [_downloadButton setUserInteractionEnabled:NO];
    [_downloadButton setImage:[UIImage imageNamed:@"ic_chat_done"] forState:UIControlStateNormal];
    _downloadButton.hidden = NO;
    _downloadButton.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _downloadButton.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _downloadButton.alpha = 0;
        } completion:^(BOOL finished) {
            _downloadButton.hidden = YES;
        }];
    }];
}
@end
