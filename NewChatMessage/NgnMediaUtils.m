//
//  NgnMediaUtils.m
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "NgnMediaUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation NgnMediaUtils

+ (UIImage *)getImageFromVideo:(NSURL *)videoUrl atTime:(CGFloat)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *error = NULL;
    CMTime cmTime = CMTimeMake(time, 1);
    CGImageRef refImg = [generateImg copyCGImageAtTime:cmTime actualTime:NULL error:&error];
    NSLog(@"error==%@, Refimage==%@", error, refImg);
    
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    return FrameImage;
}

@end
