//
//  NewChatViewController.m
//  iMomeetInHouseCM
//
//  Created by admin on 10/4/17.
//  Copyright © 2017 Softfoundry. All rights reserved.
//

#import "NewChatViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ChatContentSectionController.h"

#define FooterButtonSize CGSizeMake(30, 30)

#define DistanceToCancelRecordView [[UIScreen mainScreen] bounds].size.width / 2
#define ActionBarHeight 200

@implementation NewChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //---LAYOUT UI---
    //layout navigation bar
    _navigationBar = [[HMNavigationBar alloc] initInView:self.view];
    _footerView = [[UIView alloc] init];
    _footerView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_footerView];
    
    //layout action view
    _actionView = [[HMActionBar alloc] init];
    _actionView.delegate = self;
    [self.view addSubview:_actionView];
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    _actionButton = [[UIButton alloc] init];
    [_actionButton setImage:[UIImage imageNamed:@"icon_chat_action_bar_add_light"] forState:UIControlStateNormal];
    [_actionButton addTarget:self action:@selector(showMenuBarAction) forControlEvents:UIControlEventTouchUpInside];
    _actionButton.backgroundColor = UIColor.clearColor;
    [_footerView addSubview:_actionButton];
    [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_footerView).offset(10);
        make.centerY.equalTo(_footerView);
        make.size.mas_equalTo(FooterButtonSize);
    }];
    
    _sendButton = [[UIButton alloc] init];
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleSendRecord:)];
    [_sendButton addGestureRecognizer:longGesture];
    [_sendButton setImage:[UIImage imageNamed:@"icon_chat_action_bar_voice"] forState:UIControlStateNormal];
    _sendButton.backgroundColor = UIColor.clearColor;
    [_footerView addSubview:_sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_footerView).offset(-10);
        make.centerY.equalTo(_footerView);
        make.size.mas_equalTo(FooterButtonSize);
    }];
    
    _chatTextView = [[UITextView alloc] init];
    _chatTextView.backgroundColor = UIColor.whiteColor;
    _chatTextView.layer.cornerRadius = 5;
    _chatTextView.delegate = self;
    _chatTextView.font = [UIFont systemFontOfSize:13];
    [_footerView addSubview:_chatTextView];
    [_chatTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_actionButton.mas_right).offset(15);
        make.right.equalTo(_sendButton.mas_left).offset(-15);
        make.bottom.equalTo(_footerView).offset(-10);
        make.height.mas_equalTo(30).priorityMedium();
        make.height.mas_greaterThanOrEqualTo(30).priorityHigh();
        make.height.mas_lessThanOrEqualTo(60).priorityHigh();
    }];
    
    //layout footer view
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_actionView.mas_top);
        make.top.equalTo(_chatTextView).offset(-10);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(1, 1);
    _chatCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _chatCollectionView.allowsSelection = NO;
    _chatCollectionView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_chatCollectionView];
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self workingRangeSize:0];
    adapter.collectionView = _chatCollectionView;
    adapter.dataSource = self;
    [_chatCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navigationBar.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(_footerView.mas_top);
    }];

    
    //Layout record view
    _recordView = [[HMAudioRecordView alloc] init];
    [self.view addSubview:_recordView];
    [_recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
        make.right.equalTo(self.view);
        make.top.equalTo(_footerView);
        make.bottom.equalTo(_footerView);
    }];
    
    //---INIT ATTRIBUTE---
    messages = [NSMutableArray new];
    isShowingActionBar = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Action method
#pragma mark -

- (void)refreshData
{
    [_chatTableView reloadData];
}

- (void)showMenuBarAction {
    if (!isShowingActionBar) {
        [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(ActionBarHeight);
        }];
    } else {
        [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    isShowingActionBar = !isShowingActionBar;
}

#pragma mark - Message & Record
- (void)sendMessage {
    if ([_chatTextView.text isEqualToString:@""]) {
        return;
    }
}

- (void)handleSendRecord:(UILongPressGestureRecognizer *)gesture {
    if (![_chatTextView.text isEqualToString:@""]) {
        return;
    }
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            [_recordView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.view.frame.size.width);
            }];
            [UIView animateWithDuration:0.2 animations:^{
                [self.view layoutIfNeeded];
            }];
            [_recordView startRecord];
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            if (!_recordView.isRunning) {
                return;
            }
            
            CGPoint targetPoint = [gesture locationInView:self.view];
            CGPoint originPoint = _sendButton.frame.origin;
            CGFloat ratio = (targetPoint.x - DistanceToCancelRecordView) / (originPoint.x - DistanceToCancelRecordView);
            _recordView.alpha = ratio;
            if (ratio <= 0.1f) {
                [_recordView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(0);
                }];
                [_recordView cancelRecord];
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            [_recordView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
            [UIView animateWithDuration:0.2 animations:^{
                [self.view layoutIfNeeded];
            }];
            [_recordView stopRecord];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - DATASOURCE & DELEGATE

#pragma mark - HMActionBarDelegate
- (void)didSelectImageButton {
    NSLog(@"Select image");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didSelectVideoButton {
    NSLog(@"Select video");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didSelectEmotionButton {
    NSLog(@"Select emotion");
}

- (void)didSelectLocationButton {
    NSLog(@"Select location");
}

- (void)didSelectAudioCallButton {
    NSLog(@"Select audio call");
}

- (void)didSelectVideoCallButton {
    NSLog(@"Select video call");
}

#pragma mark - IGListAdapter DataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:@""];
    return array;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[ChatContentSectionController alloc] init];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%f", _chatTextView.contentSize.height);
    [_chatTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_chatTextView.contentSize.height).priorityMedium();
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"Finish picking");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

