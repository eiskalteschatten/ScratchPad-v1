//
//  DropboxController.m
//  ScratchPad
//
//  Created by Alex Seifert on 16/05/2015.
//  Copyright (c) 2015 Alex Seifert. All rights reserved.
//

#import "DropboxController.h"

@implementation DropboxController

- (void)awakeFromNib {
    _standardDefaults = [NSUserDefaults standardUserDefaults];
    _dropBoxLocation = [_standardDefaults stringForKey:@"dropBoxLocation"];

    [_locationField setStringValue:_dropBoxLocation];
    
    bool dropBoxSet = [_standardDefaults boolForKey:@"syncDropBox"];
    
    if (dropBoxSet) {
        [self turnEverythingOn];
    }
    else {
        [self turnEverythingOff];
    }
}

- (IBAction)toggleDropBox:(id)sender {
    if ([sender state] == NSOnState) {
        [self turnEverythingOn];
        [self moveNotesToDropBox];
    }
    else {
        [self turnEverythingOff];
    }
}

- (IBAction)chooseLocation:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    
    [panel setCanChooseDirectories: YES];
    [panel setCanChooseFiles: NO];
    [panel setAllowsMultipleSelection: NO];
    
    if ([panel runModal] == NSOKButton) {
        _dropBoxLocation = [[panel URL] path];
        [self turnEverythingOn];
        [self moveNotesToDropBox];
    }
}

- (void)moveNotesToDropBox {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *library = [_helper pathToLibrary];
    NSString *moveToLocation = [_dropBoxLocation stringByAppendingString:@"Scratchpad/"];
    
    if ([fileManager copyItemAtPath:library toPath:moveToLocation error:nil]) {
        // Moved!
    }
    else {
        // Error!
    }
}

- (void)turnEverythingOn {
    [_dropBoxCheck setState:NSOnState];
    [_locationField setStringValue:_dropBoxLocation];
    
    [_standardDefaults setBool:YES forKey:@"syncDropBox"];
    [_standardDefaults setObject:_dropBoxLocation forKey:@"dropBoxLocation"];
    [_standardDefaults synchronize];
}

- (void)turnEverythingOff {
    [_dropBoxCheck setState:NSOffState];
    
    [_standardDefaults setBool:NO forKey:@"syncDropBox"];
    [_standardDefaults synchronize];
}

@end
