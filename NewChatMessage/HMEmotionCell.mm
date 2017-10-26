//
//  HMEmotionCell.m
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMEmotionCell.h"
#import "Masonry.h"

@implementation HMEmotionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIButton alloc] init];
        _iconView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
@end
