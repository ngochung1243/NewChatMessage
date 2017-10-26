//
//  HMEmotion.h
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMEmotion : NSObject

@property(strong, nonatomic) NSString *icon;
@property(strong, nonatomic) NSString *text;

- initWithDictionary:(NSDictionary *)dict;
@end
