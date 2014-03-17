//
//  PageListViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"

@interface PageListViewController : NSViewController

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NSSegmentedControl *popoverButton;
@property (assign) IBOutlet NSPopover *popover;
@property (assign) IBOutlet NSTableView *pageList;

@property (retain, nonatomic) NSDictionary *indexPagesDict;
@property (retain, nonatomic) NSMutableArray *indexPages;
@property (retain, nonatomic) NSMutableArray *indexTitles;

- (IBAction)openPopover:(id)sender;
- (void)loadPages;
- (NSString *)getNoteName:(NSInteger*)noteIndex;
- (NSString *)getNote:(NSInteger*)noteIndex;
- (void)preparePageAfterLoad:(NSInteger*)noteIndex;


@end
