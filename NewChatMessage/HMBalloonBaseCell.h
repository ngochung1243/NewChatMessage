//
//  HMBaloonBaseCell.h
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define OffsetEdge 15
#define AvatarImageSize CGSizeMake(45, 45)

#define InBalloonImage [[UIImage imageNamed:@"baloon_in_Flat"] resizableImageWithCapInsets:UIEdgeInsetsMake(13, 17, 13, 17)]
#define OutBallonImage [[UIImage imageNamed:@"baloon_out_Flat"] resizableImageWithCapInsets:UIEdgeInsetsMake(13, 17, 13, 17)]

typedef enum {
    Text,
    Image,
    Video,
    Audio,
    Location
} HMBalloonCellType;

@interface HMBalloonBaseCell : UICollectionViewCell 

@property(strong, nonatomic) UIImageView *balloonImageView;
@property(strong, nonatomic) UIImageView *avatarView;
@property(strong, nonatomic) UILabel *messageLabel;
@property(strong, nonatomic) UILabel *timeLabel;

@property(nonatomic) HMBalloonCellType cellType;
@property(nonatomic) BOOL isMine;

- (void)populateMessage:(NSString *)messageEvent;
- (void)handleAction;
@end
