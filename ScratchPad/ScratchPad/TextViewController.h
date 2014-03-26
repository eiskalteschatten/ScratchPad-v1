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

@property (assign) BOOL isRichText;

- (void)loadNote:(NSInteger)noteIndex;
- (void)saveNote;
- (void)nextNote;
- (void)prevNote;
- (void)goToNote:(NSInteger)noteIndex;

- (IBAction)toggleToolbar:(id)sender;
- (IBAction)toggleRichText:(id)sender;

@end
