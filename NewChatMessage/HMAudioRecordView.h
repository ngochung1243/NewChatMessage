//
//  HMAudioRecordView.h
//  NewChatMessage
//
//  Created by admin on 10/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAudioRecordView : UIView {
    NSTimer *timer;
    long timerCount;
}

@property(strong, nonatomic) UIImageView *audioImageView;
@property(strong, nonatomic) UILabel *timeCountLabel;
@property(strong, nonatomic) UILabel *suggestLabel;

@property(nonatomic) BOOL isRunning;

- (void)startRecord;
- (void)stopRecord;
- (void)cancelRecord;

@end
