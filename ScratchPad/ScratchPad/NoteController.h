//
//  NoteController.h
//  ScratchPad
//
//  Created by Alex Seifert on 27.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

@interface NoteController : NSObject

@property (assign) IBOutlet Helper *helper;

@property (nonatomic) NSInteger currentNoteIndex;
@property (nonatomic) NSInteger numberOfNotes;

@property (retain, nonatomic) NSDictionary *indexPagesDict;
@property (retain, nonatomic) NSMutableArray *indexPages;
@property (retain, nonatomic) NSMutableArray *indexTitles;
@property (retain, nonatomic) NSMutableArray *indexDates;

- (void)loadPages;
- (void)setCurrentNote:(NSInteger)noteIndex;
- (NSInteger)getCurrentNote;
- (void)setNumberOfNotes:(NSInteger)numOfNotes;
- (NSInteger)getNumberOfNotes;
- (NSString *)getNoteName:(NSInteger)noteIndex;
- (NSString *)getNote:(NSInteger)noteIndex;
- (NSString *)getNoteDate:(NSInteger)noteIndex;
- (NSMutableArray *)getPages;
- (NSMutableArray *)getTitles;
- (NSMutableArray *)getDates;

@end
