//
//  HMBaloonBaseCell.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonBaseCell.h"

@implementation HMBalloonBaseCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //Layout Subviews
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = AvatarImageSize.height / 2;
        _avatarView.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_avatarView];
        
        _balloonImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_balloonImageView];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = @"I love you";
        [_balloonImageView addSubview:_messageLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"23:30";
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = UIColor.lightGrayColor;
        [_balloonImageView addSubview:_timeLabel];
        [_timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_messageLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_messageLabel);
        }];
        
        //Init gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAction)];
        tapGesture.numberOfTapsRequired = 1;
        [_balloonImageView addGestureRecognizer:tapGesture];
        [_balloonImageView setUserInteractionEnabled:YES];
        
        //Init Attributes
        _isMine = YES;
        _cellType = Text;
    }
    return self;
}

- (void)layoutSubviews {
    if (_isMine) {
        [_avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-OffsetEdge);
            make.top.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeZero);
        }];
        
        [_balloonImageView setImage:InBalloonImage];
        [_balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_avatarView.mas_left);
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(_messageLabel).offset(-OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(_timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(_timeLabel).offset(OffsetEdge / 2);
        }];

        [_messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_balloonImageView).offset(5);
            make.right.mas_equalTo(_balloonImageView).offset(-OffsetEdge - 2);
            make.left.greaterThanOrEqualTo(self.contentView).offset(OffsetEdge);
        }];
    } else {
        [_avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(OffsetEdge);
            make.top.equalTo(self.contentView);
            make.size.mas_equalTo(AvatarImageSize);
        }];
        
        [_balloonImageView setImage:OutBallonImage];
        [_balloonImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(_avatarView.mas_right);
            make.right.mas_equalTo(_messageLabel).offset(OffsetEdge).priorityMedium();
            make.width.greaterThanOrEqualTo(_timeLabel.mas_width).offset(OffsetEdge * 2).priorityHigh();
            make.bottom.equalTo(_timeLabel).offset(OffsetEdge / 2);
        }];
        
        [_messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_balloonImageView).offset(5);
            make.left.mas_equalTo(_balloonImageView).offset(OffsetEdge + 5);
            make.right.lessThanOrEqualTo(self.contentView).offset(-OffsetEdge);
        }];
    }
}

#pragma mark - Action
- (void)populateMessage:(NSString *)messageEvent {
    _messageLabel.text = messageEvent;
}

- (void)handleAction {
    NSLog(@"[HM] - Click action");
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = _balloonImageView.frame.size;
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    newFrame.size.height = size.height;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}
@end
