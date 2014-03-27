//
//  NoteController.m
//  ScratchPad
//
//  Created by Alex Seifert on 27.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "NoteController.h"

@implementation NoteController

@synthesize indexPagesDict;
@synthesize indexPages;
@synthesize indexTitles;
@synthesize indexDates;

- (void)awakeFromNib {
    indexPagesDict = [[NSDictionary alloc] init];
    indexPages = [[NSMutableArray alloc] init];
    indexTitles = [[NSMutableArray alloc] init];
    indexDates = [[NSMutableArray alloc] init];
    
    [self loadPages];
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
    
    [self setNumberOfNotes:[indexPages count]];
}

- (void)setCurrentNote:(NSInteger)noteIndex {
    _currentNoteIndex = noteIndex;
    
    NSInteger pageNum = 1;
    
    if (noteIndex) {
        pageNum = noteIndex + 1;
    }
    
    [_window setTitle: [NSString stringWithFormat:@"ScratchPad (%ld)", (long)pageNum]];
}

- (NSInteger)getCurrentNote {
	return _currentNoteIndex;
}

- (void)setNumberOfNotes:(NSInteger)numOfNotes {
    _numberOfNotes = numOfNotes;
}

- (NSInteger)getNumberOfNotes {
	return _numberOfNotes;
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

- (NSMutableArray *)getPages {
    return indexPages;
}

- (NSMutableArray *)getTitles {
    return indexTitles;
}

- (NSMutableArray *)getDates {
    return indexDates;
}

@end
