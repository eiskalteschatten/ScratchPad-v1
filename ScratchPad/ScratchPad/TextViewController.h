//
//  TextViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "NoteController.h"

@interface TextViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NoteController *noteController;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *noteTitle;
@property (assign) IBOutlet NSTextField *noteDate;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSSegmentedControl *backForwardButtons;
@property (assign) IBOutlet NSMenuItem *previousNoteMenuItem;

@property (assign) BOOL isRichText;

- (void)loadNote:(NSInteger)noteIndex;
- (void)loadBlankNote:(NSInteger)noteIndex;
- (void)saveNote;
- (IBAction)saveNoteAction:(id)sender;
- (void)deleteCurrentNote;
- (IBAction)deleteNoteAction:(id)sender;
- (void)deleteNoteByIndex:(NSInteger)index;
- (IBAction)newNote:(id)sender;
- (IBAction)nextNote:(id)sender;
- (IBAction)prevNote:(id)sender;
- (IBAction)goToNote:(id)sender;
- (IBAction)goToFirstNote:(id)sender;
- (IBAction)goToLastNote:(id)sender;
- (void)enableDisableBackButton:(NSInteger)noteIndex;

- (IBAction)toggleToolbar:(id)sender;
- (IBAction)toggleRichText:(id)sender;

@end
