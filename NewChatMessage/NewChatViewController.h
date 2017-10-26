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
#import "HMEmotionBar.h"
#import "HMFooterView.h"
#import "HMExtraMessageBar.h"
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
    BOOL isShowingEmotionBar;
    IGListAdapter *adapter;
    
    //Constraint can change
    MASConstraint *footerViewBottomConstraint;
}

@property(strong, nonatomic) HMNavigationBar *navigationBar;
@property(strong, nonatomic) UITableView *chatTableView;
@property(strong, nonatomic) UICollectionView *chatCollectionView;
@property(strong, nonatomic) HMFooterView *footerView;
@property(strong, nonatomic) HMActionBar *actionView;
@property(strong, nonatomic) HMEmotionBar *emotionView;
@property(strong, nonatomic) HMAudioRecordView *recordView;
@property(strong, nonatomic) HMExtraMessageBar *extraView;

@end
