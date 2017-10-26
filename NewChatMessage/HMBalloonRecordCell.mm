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
        //Init attributes
        self.actionImageView.image = [UIImage imageNamed:@"icon_speaker_animated"];
        animationImage = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"icon_speaker_animated_0.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_1.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_2.png"],
                          [UIImage imageNamed:@"icon_speaker_animated_3.png"], nil];
        self.actionImageView.animationImages = animationImage;
        self.actionImageView.animationDuration = 1;
        self.actionImageView.animationRepeatCount = 0;

        self.actionImageSize = RecordImageSize;
    }
    return self;
}

- (void)populateMessage:(NSString *)messageEvent {
    timerCountdown = 5;
    self.messageLabel.text = [NgnDateTimeUtils secondsToTimeString:timerCountdown];
}

#pragma mark - Handle Audio
- (void)handleAction {
    if ([self.actionImageView isAnimating]) {
        [self stopAudio];
    } else {
        [self playAudio];
    }
}

- (void)playAudio {
    [self.actionImageView startAnimating];
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
    [self.actionImageView stopAnimating];
    [timer invalidate];
}

@end
