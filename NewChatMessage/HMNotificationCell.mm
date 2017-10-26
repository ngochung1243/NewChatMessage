//
//  HMNotificationCell.m
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMNotificationCell.h"
#import "Masonry.h"

#define OffsetEdge 50

@implementation HMNotificationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _belowView = [[UIView alloc] init];
        [self.contentView addSubview:_belowView];
        
        _notiLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_notiLabel];
        
        //Init attributes
        _isTimeNoti = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_notiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.left.greaterThanOrEqualTo(self.contentView).offset(OffsetEdge);
        make.right.lessThanOrEqualTo(self.contentView).offset(-OffsetEdge);
    }];
    
    _belowView.layer.cornerRadius = _belowView.frame.size.height / 2;
    [_belowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_notiLabel).insets(UIEdgeInsetsMake(-5, -10, -5, -10));
    }];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self layoutIfNeeded];
    CGSize size = _belowView.frame.size;
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    newFrame.size.height = size.height;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}

- (void)setIsTimeNoti:(BOOL)isTimeNoti {
    _isTimeNoti = isTimeNoti;
    if (_isTimeNoti) {
        _belowView.backgroundColor = UIColor.brownColor;
        _notiLabel.font = [UIFont systemFontOfSize:13];
        _notiLabel.textColor = UIColor.whiteColor;
    } else {
        _belowView.backgroundColor = UIColor.clearColor;
        _notiLabel.font = [UIFont boldSystemFontOfSize:13];
        _notiLabel.textColor = [UIColor colorWithRed:0.169 green:0.53 blue:0.949 alpha:1.0];
    }
}

- (void)populateNoti:(NSString *)noti {
    _notiLabel.text = noti;
}

@end
