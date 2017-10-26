//
//  HMBalloonLocationCell.m
//  NewChatMessage
//
//  Created by admin on 10/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonLocationCell.h"

#define MapImageSize CGSizeMake(80, 80)

@implementation HMBalloonLocationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.actionImageView.image = [UIImage imageNamed:@"map_icon"];
        
        self.actionImageSize = MapImageSize;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isMine) {
        [self.actionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageLabel);
            make.right.equalTo(self.messageLabel.mas_left).offset(-OffsetEdge);
            make.left.greaterThanOrEqualTo(self.contentView).offset(OffsetEdge);
            make.size.mas_equalTo(self.actionImageSize);
        }];
    } else {
        [self.actionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageLabel);
            make.left.equalTo(self.balloonImageView).offset(OffsetEdge + 5);
            make.size.mas_equalTo(self.actionImageSize);
        }];
        
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.actionImageView.mas_right).offset(OffsetEdge);
        }];
    }
    
}

- (void)handleAction {
    NSLog(@"[HM] - Show location");
}

@end
