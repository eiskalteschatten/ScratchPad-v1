//
//  PreferencesViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "NoteController.h"

@interface PreferencesViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NoteController *noteController;
@property (assign) IBOutlet NSWindow *mainWindow;
@property (assign) IBOutlet NSWindow *prefWindow;

@property (assign) IBOutlet NSButton *floatAboveWindows;
@property (assign) IBOutlet NSButton *rememberPageNumber;

@property (assign) NSUserDefaults *standardDefaults;

- (IBAction)setFloatOption:(id)sender;
- (IBAction)setRememberPageNumberOption:(id)sender;

- (void)importOldPreferences;

@end
