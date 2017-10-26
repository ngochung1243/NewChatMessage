//
//  HMBaloonImageCell.h
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBalloonBaseCell.h"

@interface HMBalloonImageCell : HMBalloonBaseCell {
    CGSize imageSize;
    int count;
}

@property(strong, nonatomic) UIImageView *imageMessageView;
@property(strong, nonatomic) UIButton *downloadButton;
@property(strong, nonatomic) UILabel *progressLabel;

@end
