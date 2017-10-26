//
//  NgnMediaUtils.h
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NgnMediaUtils : NSObject

+ (UIImage *)getImageFromVideo:(NSURL *)videoUrl atTime:(CGFloat)time;

@end
