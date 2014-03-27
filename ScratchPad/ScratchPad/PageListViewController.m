//
//  PageListViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "PageListViewController.h"

@interface PageListViewController ()

@end

@implementation PageListViewController

@synthesize pageList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {

}

- (IBAction)openPopover:(id)sender {
    [_popover showRelativeToRect:[_popoverButton bounds] ofView:_popoverButton preferredEdge:NSMinYEdge];
}

- (void)preparePageAfterLoad:(NSInteger)noteIndex {
    NSInteger pageNum = 1;
    
    if (noteIndex) {
       pageNum = noteIndex + 1;
    }
    
    [_window setTitle: [NSString stringWithFormat:@"ScratchPad (%ld)", (long)pageNum]];
    
    [_noteController setCurrentNote: noteIndex];
    [pageList reloadData];
}

- (IBAction)newNote:(id)sender {
    [_popover close];
}


#pragma mark -
#pragma mark Table View Delagte methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_noteController numberOfNotes];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
        
        NSMutableArray *indexPages = [_noteController getPages];
        NSMutableArray *indexTitles = [_noteController getTitles];
        NSMutableArray *indexDates = [_noteController getDates];
   
        NSString *titleSubString = indexTitles[row];
        
        if ([indexTitles[row] length] > 10) {
            titleSubString = [indexTitles[row] substringToIndex:10];
        }
        
        NSString *path = [[_helper pathToNotes] stringByAppendingString:indexPages[row]];
        
        NSRect cFrame =[[_window contentView] frame];
        NSTextView *textView = [[NSTextView alloc] initWithFrame:cFrame];
        [textView readRTFDFromFile:path];
        
        NSSize size = NSMakeSize(35, 35);
        
        NSImage *textImg = [[NSImage alloc] initWithSize:[textView bounds].size];
        [textImg setFlipped:NO];
        [textImg setScalesWhenResized:YES];
        [textImg lockFocus];
        [textView drawRect:[textView bounds]];
        [textImg unlockFocus];
        [textImg setSize:size];
        
        NSImage* img = [[NSImage alloc] initWithSize:size];
        NSAffineTransform *transform = [NSAffineTransform transform];
        [transform translateXBy:size.width/2 yBy:size.height/2];
        [transform scaleXBy:1.0 yBy:-1.0];
        [transform translateXBy:-size.width/2 yBy:-size.height/2];
        
        [img lockFocus];
        [transform concat];
        [textImg drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
        [img unlockFocus];
        
        [cellView.imageView setImage:img];
        [cellView.textField setStringValue:indexTitles[row]];
        [cellView.subviews[2] setStringValue:[_helper formatDate:indexDates[row]]];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[_noteController getCurrentNote]];
        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        
        return cellView;
    }
    
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSInteger selectedRow = [pageList selectedRow];
    
    if (selectedRow != -1) {
//        [_appDelegate loadNote:selectedRow];
    }
    else {
        // No row was selected
    }
}

@end
