//
//  HMAudioRecordView.m
//  NewChatMessage
//
//  Created by admin on 10/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMAudioRecordView.h"
#import "Masonry.h"
#import "NgnDateTimeUtils.h"

#define AudioImageSize CGSizeMake(30, 30)
#define OffsetLeft 10

@implementation HMAudioRecordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.greenColor;

        //Layout audio image
        _audioImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"action_messaging_record_audio"]];
        [self addSubview:_audioImageView];
        [_audioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(OffsetLeft);
            make.size.mas_equalTo(AudioImageSize);
        }];
        
        //Layout time count label
        _timeCountLabel = [[UILabel alloc] init];
        _timeCountLabel.font = [UIFont boldSystemFontOfSize:17];
        _timeCountLabel.textColor = UIColor.blackColor;
        _timeCountLabel.text = @"00:00";
        [self addSubview:_timeCountLabel];
        [_timeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_audioImageView.mas_right).offset(OffsetLeft);
        }];
        
        //Layout suggest label
        _suggestLabel = [[UILabel alloc] init];
        _suggestLabel.font = [UIFont systemFontOfSize:15];
        _suggestLabel.textColor = UIColor.blackColor;
        _suggestLabel.text = NSLocalizedString(@"Slide to cancel", nil);
        [self addSubview:_suggestLabel];
        [_suggestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_timeCountLabel.mas_right).offset(OffsetLeft);
        }];
        
        //Init timer count
        timerCount = 0;
        _isRunning = NO;
    }
    return self;
}

#pragma mark - Record action
- (void)startRecord {
    if (_isRunning) {
        return;
    }
    
    NSLog(@"[HMAudioRecordView] Start record");
    _isRunning = YES;
    self.alpha = 1;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        timerCount += 1;
        _timeCountLabel.text = [NgnDateTimeUtils secondsToTimeString:timerCount];
    }];
}

- (void)stopRecord {
    if (!_isRunning) {
        return;
    }
    
    NSLog(@"[HMAudioRecordView] Stop record");
    _isRunning = NO;
    [timer invalidate];
    timerCount = 0;
    _timeCountLabel.text = @"00:00";
}

- (void)cancelRecord {
    if (!_isRunning) {
        return;
    }
    
    NSLog(@"[HMAudioRecordView] Cancel record");
    _isRunning = NO;
    [timer invalidate];
    timerCount = 0;
    _timeCountLabel.text = @"00:00";
}
@end
