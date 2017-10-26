//
//  HMBalloonRecordCell.h
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBalloonActionCell.h"

@interface HMBalloonRecordCell : HMBalloonActionCell {
    NSArray *animationImage;
    NSTimer *timer;
    long timerCountdown;
}

@end
