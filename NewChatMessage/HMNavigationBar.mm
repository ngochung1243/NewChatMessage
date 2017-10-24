//
//  HMNavigationBar.m
//  iMomeet
//
//  Created by admin on 10/20/17.
//  Copyright © 2017 Softfoundry. All rights reserved.
//

#import "HMNavigationBar.h"

#define BarHeight 65
#define ButtonSize CGSizeMake(25, 25)
#define OffSetStatusBar 10
#define OffSetEdge 10

@implementation HMNavigationBar

- (id)initInView:(UIView *)view {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.169 green:0.53 blue:0.949 alpha:1.0];
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.left.equalTo(view);
            make.right.equalTo(view);
            make.height.mas_equalTo(BarHeight);
        }];
        
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        _backButton.backgroundColor = UIColor.clearColor;
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(OffSetStatusBar);
            make.left.equalTo(self).offset(OffSetEdge);
            make.size.mas_equalTo(ButtonSize);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.text = @"Text";
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(OffSetStatusBar);
        }];
        
        _chatSettingButton = [[UIButton alloc] init];
        _chatSettingButton.backgroundColor = UIColor.clearColor;
        [_chatSettingButton setImage:[UIImage imageNamed:@"icon_user_chat_scale"] forState:UIControlStateNormal];
        [self addSubview:_chatSettingButton];
        [_chatSettingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(OffSetStatusBar);
            make.right.equalTo(self).offset(-OffSetEdge);
            make.size.mas_equalTo(ButtonSize);
        }];
        
        _callButton = [[UIButton alloc] init];
        _callButton.backgroundColor = UIColor.clearColor;
        [_callButton setImage:[UIImage imageNamed:@"icon-audio-call-with-bg_white"] forState:UIControlStateNormal];
        [self addSubview:_callButton];
        [_callButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(OffSetStatusBar);
            make.right.equalTo(_chatSettingButton.mas_left).offset(-OffSetEdge);
            make.size.mas_equalTo(ButtonSize);
        }];
    }
    
    return self;
}

@end
