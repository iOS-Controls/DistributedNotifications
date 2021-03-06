//
//  main.m
//  LaunchDaemon-Daemon
//
//  Created by Miralem Cebic on 12/02/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Daemon.h"
#import "LogManager.h"
#import "NotificationsManager.h"

int main(int argc, const char * argv[]) {

    [[LogManager sharedManager] logWithFormat:@"LaunchDaemon-Daemon"];

    [[LogManager sharedManager] logWithFormat:@"Starting LaunchDaemon-Daemon Cocoa application"];
    [Daemon sharedDaemon];

    [[NotificationsManager sharedInstance] registerForNotificationName:@"kLaunchAgentPostPressAbout" callback:^{

        [[LogManager sharedManager] logWithFormat:@"Recevied Notification kLaunchAgentPostPressAbout"];
        [[Daemon sharedDaemon] showAboutAgentInformation];
    }];

//    CFRunLoopRun();
//    [[NSRunLoop mainRunLoop] run];
    NSTimer *timer = [NSTimer timerWithTimeInterval:60
                                             target:[Daemon sharedDaemon]
                                           selector:@selector(showAboutAgentInformation)
                                           userInfo:nil
                                            repeats:YES];

    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    [runLoop run];


    return NSApplicationMain(argc, argv);
    return 0;
}