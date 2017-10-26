//
//  HMEmotion.m
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMEmotion.h"

@implementation HMEmotion

- initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _icon = [dict objectForKey:@"icon"];
        _text = [dict objectForKey:@"text"];
    }
    
    return self;
}

@end
