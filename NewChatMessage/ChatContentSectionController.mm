//
//  ChatContentSectionController.m
//  NewChatMessage
//
//  Created by admin on 10/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ChatContentSectionController.h"
#import "HMBalloonBaseCell.h"
#import "HMBalloonImageCell.h"
#import "HMBalloonVideoCell.h"
#import "HMBalloonRecordCell.h"

@implementation ChatContentSectionController

- (NSInteger)numberOfItems {
    return 100;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
//    HMBalloonBaseCell *cell = [self.collectionContext dequeueReusableCellOfClass:[HMBalloonBaseCell class] forSectionController:self atIndex:index];
    
//    HMBalloonImageCell *cell = [self.collectionContext dequeueReusableCellOfClass:[HMBalloonImageCell class] forSectionController:self atIndex:index];
    
//    HMBalloonVideoCell *cell = [self.collectionContext dequeueReusableCellOfClass:[HMBalloonVideoCell class] forSectionController:self atIndex:index];
    
    HMBalloonRecordCell *cell = [self.collectionContext dequeueReusableCellOfClass:[HMBalloonRecordCell class] forSectionController:self atIndex:index];
    [cell populateMessage:@"I love you"];

    return cell;
}

- (CGFloat)minimumLineSpacing {
    return 5;
}

- (void)didUpdateToObject:(id)object {
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
