//
//  HMBalloonActionCell.m
//  NewChatMessage
//
//  Created by admin on 10/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonActionCell.h"

@implementation HMBalloonActionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _actionImageView = [[UIImageView alloc] init];
        [self.balloonImageView addSubview:_actionImageView];
        
        //Init attributes
        _actionImageSize = CGSizeZero;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isMine) {
        [_actionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageLabel);
            make.right.equalTo(self.messageLabel.mas_left);
            make.size.mas_equalTo(_actionImageSize);
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.avatarView.mas_left);
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(_actionImageView).offset(-OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(self.timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    } else {
        [_actionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.messageLabel);
            make.left.equalTo(self.balloonImageView).offset(OffsetEdge + 5);
            make.size.mas_equalTo(_actionImageSize);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balloonImageView).offset(5);
            make.left.equalTo(_actionImageView.mas_right);
            make.right.lessThanOrEqualTo(self.contentView).offset(-OffsetEdge);
        }];
        
        [self.balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView.mas_right);
            make.top.equalTo(self.contentView);
            make.right.mas_equalTo(self.messageLabel).offset(OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(self.timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(self.timeLabel).offset(OffsetEdge / 2);
        }];
    }
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_actionImageView.mas_bottom).offset(5);
        make.left.equalTo(_actionImageView);
    }];
}

@end
