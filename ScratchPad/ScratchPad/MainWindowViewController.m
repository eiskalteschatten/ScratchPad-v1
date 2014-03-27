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
    //	[mainWindow writeRememberPageNumber];
	
	[[NSApplication sharedApplication] terminate: self];
}

- (void)windowWillMiniaturize:(NSNotification *)aNotification {
	[_textViewController saveNote];
}

- (void)windowDidResignKey:(NSNotification *)aNotification {
	[_textViewController saveNote];
}

@end
