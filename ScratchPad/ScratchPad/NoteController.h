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

@property (retain, nonatomic) NSMutableDictionary *indexPagesDict;
@property (retain, nonatomic) NSMutableArray *indexPages;
@property (retain, nonatomic) NSMutableArray *indexTitles;
@property (retain, nonatomic) NSMutableArray *indexDates;
@property (retain, nonatomic) NSMutableArray *indexCount;

@property (assign) IBOutlet NSWindow *window;

- (void)loadPages;
- (void)refreshNoteArrays;
- (void)refreshDictionary;
- (void)setCurrentNote:(NSInteger)noteIndex;
- (NSInteger)getCurrentNote;
- (NSInteger)getNumberOfNotes;
- (NSString *)getNoteName:(NSInteger)noteIndex;
- (NSString *)getNote:(NSInteger)noteIndex;
- (NSString *)getNoteDate:(NSInteger)noteIndex;
- (void)setNoteName:(NSString*)noteName index:(NSInteger)noteIndex;
- (void)setNote:(NSString*)note index:(NSInteger)noteIndex;
- (void)setNoteDate:(NSString*)noteDate index:(NSInteger)noteIndex;
- (void)setNewIndex:(NSInteger)noteIndex;
- (void)saveDictionary;
- (void)deleteNoteByIndex:(NSInteger)index;
- (NSMutableArray *)getPages;
- (NSMutableArray *)getTitles;
- (NSMutableArray *)getDates;

@end
