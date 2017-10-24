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
}

@property(strong, nonatomic) UIButton *imageMessageView;
@end
