//
//  MainWindowViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 27.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TextViewController.h"

@interface MainWindowViewController : NSViewController

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet TextViewController *textViewController;

@end
