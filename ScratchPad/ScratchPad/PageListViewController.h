//
//  PageListViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PageListViewController : NSViewController

@property (assign) IBOutlet NSSegmentedControl *popoverButton;
@property (assign) IBOutlet NSPopover *popover;

- (IBAction)openPopover:(id)sender;
- (void)loadPages;

@end
