//
//  PageListViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "NoteController.h"
#import "TextViewController.h"

@interface PageListViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NoteController *noteController;
@property (assign) IBOutlet TextViewController *textViewController;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSSegmentedControl *popoverButton;
@property (assign) IBOutlet NSPopover *popover;
@property (assign) IBOutlet NSTableView *pageList;

@property (retain, nonatomic) NSMutableArray *indexPages;
@property (retain, nonatomic) NSMutableArray *indexTitles;
@property (retain, nonatomic) NSMutableArray *indexDates;
@property (nonatomic) NSInteger selectedNote;

- (IBAction)openPopover:(id)sender;
- (IBAction)newNote:(id)sender;
- (IBAction)deleteNote:(id)sender;
- (IBAction)renameNote:(id)sender;

@end
