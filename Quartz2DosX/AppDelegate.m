//
//  AppDelegate.m
//  Quartz2DosX
//
//  Created by mar Jinn on 1/24/15.
//  Copyright (c) 2015 mar Jinn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSArray* array = nil;
    array = @[@"i",@"p",@"h",@"a",@"m"];
    
    NSLog(@"%@",
          [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]);
    
    NSLog(@"%@",[[NSString alloc] initWithData:[array sortedArrayHint]
                                       encoding:NSUTF8StringEncoding]);
    

              
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
