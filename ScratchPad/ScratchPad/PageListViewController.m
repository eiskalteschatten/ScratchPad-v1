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

@synthesize indexPagesDict;
@synthesize indexPages;
@synthesize indexTitles;
@synthesize indexDates;
@synthesize pageList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {
    indexPagesDict = [[NSDictionary alloc] init];
    indexPages = [[NSMutableArray alloc] init];
    indexTitles = [[NSMutableArray alloc] init];
    indexDates = [[NSMutableArray alloc] init];
    
    [self loadPages];
}

- (IBAction)openPopover:(id)sender {
    [_popover showRelativeToRect:[_popoverButton bounds] ofView:_popoverButton preferredEdge:NSMinYEdge];
}

- (void)loadPages {
    NSString* library = [_helper pathToLibrary];
	NSString *pFileName = [library stringByAppendingPathComponent: @"Notes.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {                      
        NSString *notesPath = [_helper pathToNotes];
        
        NSArray *rawnotes = [fileManager contentsOfDirectoryAtPath:notesPath error:nil];
        indexPages = [[NSMutableArray alloc] initWithCapacity:[rawnotes count]];
        
        NSEnumerator *enumerator = [rawnotes objectEnumerator];
        NSMutableArray *indexCount = [[NSMutableArray alloc] init];
        id anObject;
        int i = 0;
        
        while (anObject = [enumerator nextObject]) {
            if ([anObject isEqualToString:@".DS_Store"] == NO) {
                NSString *title = [anObject stringByDeletingPathExtension];
                
                NSString *fullPath = [notesPath stringByAppendingString:anObject];
                NSDictionary *attributes = [fileManager attributesOfItemAtPath:fullPath error:nil];
                NSDate *date = [attributes fileModificationDate];
               
                [indexPages addObject:anObject];
                [indexTitles addObject:title];
                [indexDates addObject:[date description]];
                [indexCount addObject:[NSString stringWithFormat:@"%i", i]];
                i++;
            }
        }
        
        indexPagesDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: indexCount, indexPages, indexTitles, indexDates, nil] forKeys:[NSArray arrayWithObjects: @"Index", @"Notes", @"Titles", @"Dates", nil]];
        
        NSString *error;
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:indexPagesDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
        
        if (plistData) {
            [plistData writeToFile:pFileName atomically:YES];
        }
    }
    else {
        indexPagesDict = [[NSDictionary alloc] initWithContentsOfFile:pFileName];
        indexPages = [NSMutableArray arrayWithArray:[indexPagesDict objectForKey:@"Notes"]];
        indexTitles = [indexPagesDict objectForKey:@"Titles"];
        indexDates = [indexPagesDict objectForKey:@"Dates"];
    }
}

- (NSString *)getNoteName:(NSInteger)noteIndex {
	return [indexTitles objectAtIndex:noteIndex];
}

- (NSString *)getNote:(NSInteger)noteIndex {
	return [indexPages objectAtIndex:noteIndex];
}

- (NSString *)getNoteDate:(NSInteger)noteIndex {
	return [indexDates objectAtIndex:noteIndex];
}

- (NSInteger)getNumberOfNotes {
	return [indexPages count];
}

- (void)preparePageAfterLoad:(NSInteger)noteIndex {
    NSInteger pageNum;
    
    if (noteIndex) {
       pageNum = noteIndex + 1;
    }
    else {
       pageNum = 1;
    }
    
    [_window setTitle: [NSString stringWithFormat:@"ScratchPad (%ld)", (long)pageNum]];
    
    [_helper setCurrentNote: noteIndex];
    [pageList reloadData];
}

- (IBAction)newNote:(id)sender {
    [_popover close];
}


#pragma mark -
#pragma mark Table View Delagte methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [indexTitles count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
   
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
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[_helper getCurrentNote]];
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
