//
//  PreferencesViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"

@interface PreferencesViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NSWindow *mainWindow;
@property (assign) IBOutlet NSWindow *prefWindow;

@end
