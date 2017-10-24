//
//  HMBalloonVideoCell.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMBalloonVideoCell.h"

#define PlayButtonSize CGSizeMake(40, 40)

@implementation HMBalloonVideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _playImage = [[UIImageView alloc] init];
        _playImage.image = [UIImage imageNamed:@"gtk_media_play_ltr"];
        [self.imageMessageView addSubview:_playImage];
        [_playImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.imageMessageView);
            make.size.mas_equalTo(PlayButtonSize);
        }];
        
        //Init attributes
        self.cellType = Video;
    }
    return self;
}

@end
