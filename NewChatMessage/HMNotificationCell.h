//
//  HMNotificationCell.h
//  NewChatMessage
//
//  Created by admin on 10/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNotificationCell : UICollectionViewCell

@property(strong, nonatomic) UIView *belowView;
@property(strong, nonatomic) UILabel *notiLabel;
@property(nonatomic) BOOL isTimeNoti;

- (void)populateNoti:(NSString *)noti;

@end
