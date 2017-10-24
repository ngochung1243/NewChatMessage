//
//  HMBalloonRecordCell.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonRecordCell.h"
#import "NgnDateTimeUtils.h"

#define RecordImageSize CGSizeMake(22, 22)

@implementation HMBalloonRecordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _recordImageView = [[UIImageView alloc] init];
        _recordImageView.image = [UIImage imageNamed:@"icon_speaker_animated"];
        [self.balloonImageView addSubview:_recordImageView];
        
        //Init gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAudio)];
        tapGesture.numberOfTapsRequired = 1;
        [self.balloonImageView addGestureRecognizer:tapGesture];
        [self.balloonImageView setUserInteractionEnabled:YES];
        
        //Init attributes
        animationImage = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"icon_speaker_animated_0.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_1.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_2.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_3.png"], nil];
        _recordImageView.animationImages = animationImage;
        _recordImageView.animationDuration = 1;
        _recordImageView.animationRepeatCount = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isMine) {
        [_recordImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageLabel);
            make.right.equalTo(self.messageLabel.mas_left);
            make.size.mas_equalTo(RecordImageSize);
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.avatarView.mas_left);
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(_recordImageView).offset(-OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(self.timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    } else {
        [_recordImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageLabel);
            make.left.equalTo(self.balloonImageView).offset(OffsetEdge + 5);
            make.size.mas_equalTo(RecordImageSize);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balloonImageView).offset(5);
            make.left.equalTo(_recordImageView.mas_right);
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView.mas_right);
            make.top.equalTo(self.contentView);
            make.right.mas_equalTo(self.messageLabel).offset(OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(self.timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    }
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recordImageView.mas_bottom).offset(5);
        make.left.equalTo(_recordImageView);
    }];
}

- (void)populateMessage:(NSString *)messageEvent {
    timerCountdown = 5;
    self.messageLabel.text = [NgnDateTimeUtils secondsToTimeString:timerCountdown];
}

#pragma mark - Handle Audio
- (void)handleAudio {
    if ([_recordImageView isAnimating]) {
        [self stopAudio];
    } else {
        [self playAudio];
    }
}

- (void)playAudio {
    [_recordImageView startAnimating];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        timerCountdown -= 1;
        if (timerCountdown == 0) {
            [self stopAudio];
            timerCountdown = 5;
        }
        self.messageLabel.text = [NgnDateTimeUtils secondsToTimeString:timerCountdown];
    }];
}

- (void)stopAudio {
    [_recordImageView stopAnimating];
    [timer invalidate];
}

@end
