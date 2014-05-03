//
//  MainWindowViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 27.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "MainWindowViewController.h"

@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

- (void)windowWillClose:(NSNotification *)aNotification {
	[_textViewController saveNote];
    

    NSUserDefaults *standardDefaults;
    standardDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger rememberPageInt = [standardDefaults integerForKey:@"rememberPageNumber"];
    
    if (rememberPageInt != -1) {
        NSInteger rememberPageInt = [_noteController getCurrentNote];
        [standardDefaults setInteger:rememberPageInt forKey:@"rememberPageNumber"];
        [standardDefaults synchronize];
    }
	
	[[NSApplication sharedApplication] terminate: self];
}

- (void)windowWillMiniaturize:(NSNotification *)aNotification {
	[_textViewController saveNote];
}

- (void)windowDidResignKey:(NSNotification *)aNotification {
	[_textViewController saveNote];
}

@end
