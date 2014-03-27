//
//  Helper.h
//  ScratchPad
//
//  Created by Alex Seifert on 15.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

@property (nonatomic) NSInteger currentNoteIndex;

- (NSString *)pathToLibrary;
- (NSString *)pathToNotes;
- (NSString *)formatDate:(NSString*)rawDate;
- (void)setCurrentNote:(NSInteger)noteIndex;
- (NSInteger)getCurrentNote;

@end
