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

@interface PageListViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NoteController *noteController;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSSegmentedControl *popoverButton;
@property (assign) IBOutlet NSPopover *popover;
@property (assign) IBOutlet NSTableView *pageList;

- (IBAction)openPopover:(id)sender;
- (void)preparePageAfterLoad:(NSInteger)noteIndex;
- (IBAction)newNote:(id)sender;


@end
