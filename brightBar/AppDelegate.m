//
//  AppDelegate.m
//  brightBar
//
//  Created by TangShi on 14/11/11.
//  Copyright (c) 2014年 TangShi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSStatusItem *brightItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    brightItem.button.image = [NSImage imageNamed:@"icon.png"];
    brightItem.button.action = @selector(action);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
