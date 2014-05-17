//
//  AppDelegate.m
//  ScratchPad
//
//  Created by Alex Seifert on 1/31/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_mainViewController showTextView];
    
    NSUserDefaults *standardDefaults;
    standardDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger rememberPageInt = [standardDefaults integerForKey:@"rememberPageNumber"];

    if (rememberPageInt != -1) {
        [self loadNote:rememberPageInt];
    }
    else {
        [self loadNote:0];
    }
}

- (void)loadNote:(NSInteger)noteIndex {
    [_textViewController loadNote:noteIndex];
}

- (IBAction)createBackup:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories: YES];
	[panel setCanChooseFiles: NO];
	[panel setAllowsMultipleSelection: NO];
	
	if ([panel runModal] == NSOKButton) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *library = [_helper pathToLibrary];
        NSString *backupPath = [[[panel URL] path] stringByAppendingPathComponent: @"ScratchPad/"];
        
		if ([fileManager copyItemAtPath:library toPath:backupPath error:nil]) {
			NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Created", @"Localized", @"Backup Created"), NSLocalizedStringFromTable(@"Your backup has successfully been created!", @"Localized", @"Backup Success"), @"OK", nil, nil);
		}
		else {
			NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Not Created", @"Localized", @"Backup Not Created"), NSLocalizedStringFromTable(@"An error occurred and your backup was not created!", @"Localized", @"Backup Failure"), @"OK", nil, nil);
		}
	}
}

- (IBAction)openWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://scratchpad.alexseifert.com"]];
}

- (IBAction)openFeedback:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://scratchpad.alexseifert.com/feedback/"]];
}

- (IBAction)openGithub:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/eiskalteschatten/scratchpad"]];
}

- (IBAction)openReleaseNotes:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://scratchpad.alexseifert.com/developer/release-notes/"]];
}


@end
