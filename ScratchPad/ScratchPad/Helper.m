//
//  Helper.m
//  ScratchPad
//
//  Created by Alex Seifert on 15.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "Helper.h"

@implementation Helper

- (NSString *)pathToLibrary {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString *folder = @"~/Library/Application Support/ScratchPad/";
	folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder] == NO) {
        [fileManager createDirectoryAtPath: folder withIntermediateDirectories: YES attributes: nil error: nil];
    }
   	
	return [folder stringByAppendingString:@"/"];
}

- (NSString *)pathToNotes {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *library = [self pathToLibrary];
	NSString *folder = [library stringByAppendingString:@"Notes/"];
    
    if ([fileManager fileExistsAtPath: folder] == NO) {
        [fileManager createDirectoryAtPath: folder withIntermediateDirectories: YES attributes: nil error:nil];
    }
   	
	return folder;
}

- (NSString *)formatDate:(NSString*)rawDate {
    NSDate *date = [[NSDate alloc] initWithString:rawDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *dateString = [dateFormatter stringFromDate:date];
   	
	return dateString;
}

@end