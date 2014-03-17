//
//  MainViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "TextViewController.h"

@interface MainViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *mainView;
@property (strong) NSViewController *currentViewController;
@property (strong) IBOutlet TextViewController *textViewController;

- (void)setMainViewTo:(NSViewController *)controller;
- (void)showTextView;
- (void)newTextView;
- (IBAction)prevNextNote:(id)sender;

@end
