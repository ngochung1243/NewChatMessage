//
//  HMExtraMessageBar.h
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMExtraMessageBar : UIView

@property(strong, nonatomic) UIImageView *extraImageView;
@property(strong, nonatomic) UIImageView *videoImageView;
@property(strong, nonatomic) UIButton *closeButton;

- (void)setExtraImage:(UIImage *)image isVideo:(BOOL)isVideo;

@end
