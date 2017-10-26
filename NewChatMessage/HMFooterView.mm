//
//  HMFooterView.m
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "HMFooterView.h"
#import "Masonry.h"

#define FooterButtonSize CGSizeMake(30, 30)

@implementation HMFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton setImage:[UIImage imageNamed:@"icon_chat_action_bar_add_light"] forState:UIControlStateNormal];
        _actionButton.backgroundColor = UIColor.clearColor;
        [self addSubview:_actionButton];
        [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(FooterButtonSize);
        }];
        
        _sendButton = [[UIButton alloc] init];
        [_sendButton setImage:[UIImage imageNamed:@"icon_chat_action_bar_voice"] forState:UIControlStateNormal];
        _sendButton.backgroundColor = UIColor.clearColor;
        [self addSubview:_sendButton];
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(FooterButtonSize);
        }];
        
        _chatTextView = [[UITextView alloc] init];
        _chatTextView.backgroundColor = UIColor.whiteColor;
        _chatTextView.layer.cornerRadius = 5;
        _chatTextView.delegate = self;
        _chatTextView.font = [UIFont systemFontOfSize:13];
        [self addSubview:_chatTextView];
        [_chatTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_actionButton.mas_right).offset(15);
            make.right.equalTo(_sendButton.mas_left).offset(-15);
            make.bottom.equalTo(self).offset(-10);
            make.height.mas_equalTo(30).priorityMedium();
            make.height.mas_greaterThanOrEqualTo(30).priorityHigh();
            make.height.mas_lessThanOrEqualTo(60).priorityHigh();
        }];
    }
    return self;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [_chatTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_chatTextView.contentSize.height).priorityMedium();
    }];
}

@end
