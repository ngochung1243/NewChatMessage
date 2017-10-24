//
//  HMActionCelllCollectionViewCell.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMActionCell.h"
#import "Masonry.h"

#define OffsetEdge 10

@implementation HMActionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(OffsetEdge);
            make.left.equalTo(self.contentView).offset(OffsetEdge);
            make.right.equalTo(self.contentView).offset(-OffsetEdge);
            make.height.equalTo(_imageView.mas_width);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-OffsetEdge);
        }];
    }
    return self;
}
@end
