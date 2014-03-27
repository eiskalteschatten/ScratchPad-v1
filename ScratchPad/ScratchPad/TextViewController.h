//
//  TextViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "PageListViewController.h"

@interface TextViewController : NSViewController

@property (strong) IBOutlet PageListViewController *pageListViewController;

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NSTextField *noteTitle;
@property (assign) IBOutlet NSTextField *noteDate;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSSegmentedControl *backForwardButtons;

@property (assign) BOOL isRichText;

- (void)loadNote:(NSInteger)noteIndex;
- (void)loadBlankNote:(NSInteger)noteIndex;
- (void)saveNote;
- (IBAction)newNote:(id)sender;
- (void)nextNote;
- (void)prevNote;
- (IBAction)goToNote:(id)sender;
- (void)enableDisableBackButton:(NSInteger)noteIndex;

- (IBAction)toggleToolbar:(id)sender;
- (IBAction)toggleRichText:(id)sender;

@end
