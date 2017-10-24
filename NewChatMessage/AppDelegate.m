//
//  AppDelegate.m
//  NewChatMessage
//
//  Created by admin on 10/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    IQKeyboardManager.sharedManager.enable = YES;
    return YES;
}
@end
