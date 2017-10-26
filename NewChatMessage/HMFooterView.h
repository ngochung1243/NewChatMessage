//
//  HMFooterView.h
//  NewChatMessage
//
//  Created by admin on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMFooterView : UIView <UITextViewDelegate>

@property(strong, nonatomic) UIButton *actionButton;
@property(strong, nonatomic) UITextView *chatTextView;
@property(strong, nonatomic) UIButton *sendButton;

@end
