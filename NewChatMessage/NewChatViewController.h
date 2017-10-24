//
//  NewChatViewController.h
//  iMomeetInHouseCM
//
//  Created by admin on 10/4/17.
//  Copyright © 2017 Softfoundry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "HMNavigationBar.h"
#import "HMAudioRecordView.h"
#import "HMActionBar.h"
#import "HMBalloonBaseCell.h"
#import <IGListKit.h>

@class BaloonCell;
@class ChatImageViewController;
@class AbstractActionSheetPicker;
@class ConferencePageViewController;

#if XMPP_MUC
#import "XMPPService.h"
#endif

@interface NewChatViewController : UIViewController <UITextViewDelegate, HMActionBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IGListAdapterDataSource> {
    NSMutableArray* messages;
    NSMutableDictionary *recordSetting;
    BOOL isShowingActionBar;
    IGListAdapter *adapter;
}

@property(strong, nonatomic) HMNavigationBar *navigationBar;
@property(strong, nonatomic) UITableView *chatTableView;
@property(strong, nonatomic) UICollectionView *chatCollectionView;
@property(strong, nonatomic) UIView *footerView;
@property(strong, nonatomic) UIButton *actionButton;
@property(strong, nonatomic) UITextView *chatTextView;
@property(strong, nonatomic) UIButton *sendButton;
@property(strong, nonatomic) HMActionBar *actionView;
@property(strong, nonatomic) HMAudioRecordView *recordView;

@end
