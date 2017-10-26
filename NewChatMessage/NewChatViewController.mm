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
#import "NgnMediaUtils.h"

#define DistanceToCancelRecordView [[UIScreen mainScreen] bounds].size.width / 2
#define MenuBarHeight 220


@implementation NewChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //---LAYOUT UI---
    //layout navigation bar
    _navigationBar = [[HMNavigationBar alloc] initInView:self.view];
    
    //layout extra view
    _extraView = [[HMExtraMessageBar alloc] init];
    [_extraView.closeButton addTarget:self action:@selector(closeExtraView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_extraView];
    [_extraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    //layout emotion view
    _emotionView = [[HMEmotionBar alloc] init];
    [self.view addSubview:_emotionView];
    [_emotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(MenuBarHeight);
    }];
    
    //layout action view
    _actionView = [[HMActionBar alloc] init];
    _actionView.delegate = self;
    [self.view addSubview:_actionView];
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(_emotionView.mas_left);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    //layout footer view
    _footerView = [[HMFooterView alloc] init];
    _footerView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_footerView];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        footerViewBottomConstraint = make.bottom.mas_equalTo(_actionView.mas_top);
        make.top.equalTo(_footerView.chatTextView).offset(-10);
    }];
    
    [_footerView.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleSendRecord:)];
    [_footerView.sendButton addGestureRecognizer:longGesture];
    
    [_footerView.actionButton addTarget:self action:@selector(showMenuBarAction) forControlEvents:UIControlEventTouchUpInside];
    //*****
    
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
    if (isShowingEmotionBar) {
        isShowingEmotionBar = NO;
        [_emotionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
            _footerView.actionButton.transform = CGAffineTransformIdentity;
        }];
        return;
    }
    if (!isShowingActionBar) {
        [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MenuBarHeight);
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

#pragma mark - Extra View Display
- (void)showExtraViewWithImage:(UIImage *)image isVideo:(BOOL)isVideo {
    isShowingActionBar = NO;
    [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [_extraView setExtraImage:image isVideo:isVideo];
    [_extraView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MenuBarHeight);
    }];
    
    [footerViewBottomConstraint uninstall];
    [_footerView mas_updateConstraints:^(MASConstraintMaker *make) {
        footerViewBottomConstraint = make.bottom.mas_equalTo(_extraView.mas_top);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)closeExtraView {
    [_extraView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [footerViewBottomConstraint uninstall];
    [_footerView mas_updateConstraints:^(MASConstraintMaker *make) {
        footerViewBottomConstraint = make.bottom.mas_equalTo(_actionView.mas_top);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Message & Record
- (void)sendMessage {
    if ([_footerView.chatTextView.text isEqualToString:@""]) {
        return;
    }
}

- (void)handleSendRecord:(UILongPressGestureRecognizer *)gesture {
    if (![_footerView.chatTextView.text isEqualToString:@""]) {
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
            CGPoint originPoint = _footerView.sendButton.frame.origin;
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
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didSelectCaptureButton {
    NSLog(@"Select camera");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didSelectVideoButton {
    NSLog(@"Select video");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didSelectEmotionButton {
    NSLog(@"Select emotion");
    isShowingEmotionBar = YES;
    [_emotionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
        _footerView.actionButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"Finish picking");
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString: (NSString*)kUTTypeImage] ) {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            [self showExtraViewWithImage:image isVideo:NO];
        }
        else if ([type isEqualToString: (NSString*)kUTTypeMovie] ) {
            NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            UIImage *image = [NgnMediaUtils getImageFromVideo:videoUrl atTime:1];
            [self showExtraViewWithImage:image isVideo:YES];
        }
    }];
}
@end

