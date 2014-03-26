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
        else {
            NSLog(error);
        }
    }
    else {
        indexPagesDict = [[NSDictionary alloc] initWithContentsOfFile:pFileName];
        indexPages = [NSMutableArray arrayWithArray:[indexPagesDict objectForKey:@"Notes"]];
        indexTitles = [indexPagesDict objectForKey:@"Titles"];
        indexDates = [indexPagesDict objectForKey:@"Dates"];
    }
}

- (NSString *)getNoteName:(NSInteger*)noteIndex {
	return [indexTitles objectAtIndex:noteIndex];
}

- (NSString *)getNote:(NSInteger*)noteIndex {
	return [indexPages objectAtIndex:noteIndex];
}

- (NSString *)getNoteDate:(NSInteger*)noteIndex {
	return [indexDates objectAtIndex:noteIndex];
}

- (void)preparePageAfterLoad:(NSInteger*)noteIndex {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:noteIndex];
    [pageList selectRowIndexes:indexSet byExtendingSelection:NO];
    
    NSInteger *pageNum;
    
    if (noteIndex) {
       pageNum = noteIndex + 1;
    }
    else {
       pageNum = 1;
    }
    
    [_window setTitle: [NSString stringWithFormat:@"ScratchPad (%i)", pageNum]];
    
    _currentNoteIndex = noteIndex;
}

- (NSInteger *)getCurrentNote {
	return _currentNoteIndex;
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
        
        [cellView.imageView setImage:[NSImage imageNamed:NSImageNameMultipleDocuments]];
        [cellView.textField setStringValue:indexTitles[row]];
        [cellView.subviews[2] setStringValue:[_helper formatDate:indexDates[row]]];
        
        return cellView;
    }
    
    return nil;
}

//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    return [indexTitles objectAtIndex:row];
//}
//
//- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object
//   forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    [indexTitles replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:row] withObjects:[NSArray arrayWithObject:object]];
//}

@end
