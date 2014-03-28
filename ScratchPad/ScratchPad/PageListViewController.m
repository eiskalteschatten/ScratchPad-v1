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
@synthesize indexPages;
@synthesize indexTitles;
@synthesize indexDates;

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
    [_textViewController saveNote];
    [_popover showRelativeToRect:[_popoverButton bounds] ofView:_popoverButton preferredEdge:NSMinYEdge];
    [pageList reloadData];
}

- (IBAction)newNote:(id)sender {
    [_popover close];
    [_textViewController newNote:self];
}

- (IBAction)deleteNote:(id)sender {
    [_textViewController deleteNoteByIndex:[sender tag]];
    [pageList reloadData];
}

- (IBAction)renameNote:(id)sender {
    [_popover close];
    [_textViewController renameNoteByIndex:[sender tag]];
}


#pragma mark -
#pragma mark Table View Delagte methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_noteController getNumberOfNotes];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
        
        indexPages = [_noteController getPages];
        indexTitles = [_noteController getTitles];
        indexDates = [_noteController getDates];
   
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
        
        NSMenuItem *deleteButton = [cellView.subviews[3] itemAtIndex:1];
        [deleteButton setTag:row];
        
        NSMenuItem *renameButton = [cellView.subviews[3] itemAtIndex:2];
        [renameButton setTag:row];
        
        NSInteger currentNote = [_noteController getCurrentNote];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:currentNote];
        [tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        
        return cellView;
    }
    
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    _selectedNote = [pageList selectedRow];
    
    if (_selectedNote != -1) {
        [_textViewController loadNote:_selectedNote];
    }
    else {
        // No row was selected
    }
}

@end
