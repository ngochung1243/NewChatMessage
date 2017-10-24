//
//  NgnDateTimeUtils.m
//  NewChatMessage
//
//  Created by admin on 10/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "NgnDateTimeUtils.h"

@implementation NgnDateTimeUtils

+ (NSString *)secondsToTimeString:(long)seconds {
    long hours = seconds / (60 * 60);
    long minutes = seconds / 60;
    long realSeconds = seconds % 60;
    NSString *hourString = @"";
    if (hours > 0) {
        hourString = [NSString stringWithFormat:@"%02ld:", hours];
    }
    NSString *timeString = [NSString stringWithFormat:@"%@%02ld:%02ld", hourString, minutes, realSeconds];
    return timeString;
}

@end
