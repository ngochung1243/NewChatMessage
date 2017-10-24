//
//  HMBalloonRecordCell.h
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBalloonBaseCell.h"

@interface HMBalloonRecordCell : HMBalloonBaseCell <UIGestureRecognizerDelegate> {
    NSArray *animationImage;
    NSTimer *timer;
    long timerCountdown;
}

@property(strong, nonatomic) UIImageView *recordImageView;

@end
