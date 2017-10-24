//
//  HMNavigationBar.h
//  iMomeet
//
//  Created by admin on 10/20/17.
//  Copyright © 2017 Softfoundry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface HMNavigationBar : UIView
@property(strong, nonatomic) UIButton* backButton;
@property(strong, nonatomic) UILabel* titleLabel;
@property(strong, nonatomic) UIButton* callButton;
@property(strong, nonatomic) UIButton* chatSettingButton;

- (id)initInView:(UIView *)view;

@end
