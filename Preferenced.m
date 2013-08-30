#import "Preferenced.h"

@implementation Preferenced

- (void)awakeFromNib {
	
}

- (void)checkAndReadPreferences {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = @"~/Library/Application Support/ScratchPad/Preferences/";
    folder2 = [folder2 stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder2] == NO) {
        [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
    }
	
	NSString *syncDropBoxPref = [folder2 stringByAppendingPathComponent: @"SyncDropBox.txt"];
	
	if ([fileManager fileExistsAtPath:syncDropBoxPref]) {
		NSString *yesNo3 = [NSString stringWithContentsOfFile:syncDropBoxPref encoding: NSUTF8StringEncoding error:nil];
		
		if ([yesNo3 isEqualToString: @"NO"] == NO) {
			[syncDropBox setState: NSOnState];
            [dropBoxLocationButton setEnabled:YES];
		}
		else {
			[syncDropBox setState: NSOffState];
            [dropBoxLocationButton setEnabled:NO];
		}
	}
	else {
        [@"NO" writeToFile:syncDropBoxPref atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
    
	NSString *syncDropBoxLocPref = [folder2 stringByAppendingPathComponent: @"SyncDropBoxLocation.txt"];
	NSString *dbLoc = @"";
    
	if ([fileManager fileExistsAtPath:syncDropBoxLocPref]) {
		dbLoc = [NSString stringWithContentsOfFile:syncDropBoxLocPref encoding: NSUTF8StringEncoding error:nil];
	}
	else {
        [dbLoc writeToFile:syncDropBoxLocPref atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
    
    [dropBoxLocation setStringValue: dbLoc];
    
    folder2 = [self pathToPrefs];
    
	NSString *showPageNumberBox = [folder2 stringByAppendingPathComponent: @"ShowPageNumberBox.txt"];
	
	if ([fileManager fileExistsAtPath:showPageNumberBox]) {
		NSString *yesNo = [NSString stringWithContentsOfFile:showPageNumberBox encoding: NSUTF8StringEncoding error:nil];
		
		if ([yesNo isEqualToString: @"NO"]) {
			[self togglePageNumberBox: NO];
		}
	}
	else {
		[@"NO" writeToFile:showPageNumberBox atomically:YES encoding:NSUTF8StringEncoding error:nil];
		
		[self togglePageNumberBox: NO];
	}
	
	NSString *rememberPageNumber = [folder2 stringByAppendingPathComponent: @"RememberPageNumber.txt"];
	
	if ([fileManager fileExistsAtPath:rememberPageNumber]) {
		NSString *yesNo = [NSString stringWithContentsOfFile:rememberPageNumber encoding: NSUTF8StringEncoding error:nil];
		
		if ([yesNo isEqualToString: @"NO"] == NO) {
			int iYesNo = [yesNo intValue];
			[mainWindow goToPageNumber:iYesNo pageNum:yesNo];
			[changeRememberPageNumberBox setState: NSOnState];
		}
		else {
			[changeRememberPageNumberBox setState: NSOffState];
		}
	}
	else {
		[@"1" writeToFile:rememberPageNumber atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	
	NSString *transparency = [folder2 stringByAppendingPathComponent: @"Transparency.txt"];
	
	if ([fileManager fileExistsAtPath:transparency]) {
		NSString *transValue = [NSString stringWithContentsOfFile:transparency encoding: NSUTF8StringEncoding error:nil];
		float f = [transValue floatValue];
	
		f = f / 100;
	
		[mainWindow setOpaque: NO];
		[mainWindow setAlphaValue: f];
		[mainWindow update];
	
		[transSlider setFloatValue: [transValue floatValue]];	
		[transTextbox setIntValue: [transValue intValue]];
	}
	else {
		[@"100" writeToFile:transparency atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	
	NSString *floatAboveWindows = [folder2 stringByAppendingPathComponent: @"FloatAboveWindows.txt"];
	
	if ([fileManager fileExistsAtPath:floatAboveWindows]) {
		NSString *yesNo2 = [NSString stringWithContentsOfFile:floatAboveWindows encoding: NSUTF8StringEncoding error:nil];
		
		if ([yesNo2 isEqualToString: @"NO"] == NO) {
			[mainWindow setLevel: NSPopUpMenuWindowLevel];
            
			[floatAboveWindowsBox setState: NSOnState];
		}
		else {
			[floatAboveWindowsBox setState: NSOffState];
		}
	}
	else {
		[@"NO" writeToFile:floatAboveWindows atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
}

- (NSString*)pathToSp {
    if ([syncDropBox state] == 1) {        
        return [[self syncDropBoxLoc] stringByAppendingPathComponent: @"/ScratchPad/"];
    }
    else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *folder2 = @"~/Library/Application Support/ScratchPad/";
        folder2 = [folder2 stringByExpandingTildeInPath];
        
        if ([fileManager fileExistsAtPath: folder2] == NO) {
            [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
        }
        
        return folder2;
    }   
}

- (NSString*)pathToPrefs {
    if ([syncDropBox state] == 1) {        
        return [[self syncDropBoxLoc] stringByAppendingPathComponent: @"/ScratchPad/Preferences/"];
    }
    else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *folder2 = @"~/Library/Application Support/ScratchPad/Preferences/";
        folder2 = [folder2 stringByExpandingTildeInPath];
        
        if ([fileManager fileExistsAtPath: folder2] == NO) {
            [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
        }
        
        return folder2;
    }
}

- (NSString*)pathToNotes {
    if ([syncDropBox state] == 1) {        
        return [[self syncDropBoxLoc] stringByAppendingPathComponent: @"/ScratchPad/Notes/"];
    }
    else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *folder2 = @"~/Library/Application Support/ScratchPad/Notes/";
        folder2 = [folder2 stringByExpandingTildeInPath];
        
        if ([fileManager fileExistsAtPath: folder2] == NO) {
            [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
        }
        
        return folder2;
    }
}

#pragma mark -
#pragma mark Page Number Functions

- (IBAction)changePageNumberBox:(id)sender {
	if ([pageNumberBox isHidden]) {
		[self togglePageNumberBox: YES];
	}
	else {
		[self togglePageNumberBox: NO];
	}
}

- (void)togglePageNumberBox:(BOOL)yesNo {
	NSString *path = [[self pathToPrefs] stringByAppendingPathComponent: @"ShowPageNumberBox.txt"];
	NSRect pageNumberSize = [pageNumberBox frame];
	NSRect textViewSize = [textView frame];
	NSRect textViewNewSize = textViewSize;
	
	if (yesNo == YES) {
		if ([pageNumberBox isHidden] == YES) {
			[pageNumberBox setHidden: NO];
		
			textViewNewSize.origin.y = ((pageNumberSize.size.height * -1) + pageNumberSize.size.height);
			textViewNewSize.size.height = textViewSize.size.height - pageNumberSize.size.height;
		
			[changePageNumberMenu setState: NSOnState];
			[@"YES" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	}
	else {
		if ([pageNumberBox isHidden] == NO) {
			[pageNumberBox setHidden: YES];
		
			textViewNewSize.origin.y = 0;
			textViewNewSize.size.height = textViewSize.size.height + pageNumberSize.size.height;
		
			[changePageNumberMenu setState: NSOffState];
			[@"NO" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	}
	
	[textView setFrame: textViewNewSize];
}

- (IBAction)changeRememberPageNumber:(id)sender {    
	NSString *folder2 = [self pathToPrefs];

	NSString *rememberPageNumber = [folder2 stringByAppendingPathComponent: @"RememberPageNumber.txt"];

	if ([sender state] == NSOnState) {
		[@"1" writeToFile:rememberPageNumber atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	else {
		[@"NO" writeToFile:rememberPageNumber atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
}

#pragma mark -
#pragma mark Float Functions

- (IBAction)changeFloatAboveWindows:(id)sender {    
	NSString *folder2 = [self pathToPrefs];
	
	NSString *floatAboveWindows = [folder2 stringByAppendingPathComponent: @"FloatAboveWindows.txt"];

	if ([sender state] == NSOnState) {
		[mainWindow setLevel: NSPopUpMenuWindowLevel];
		[@"YES" writeToFile:floatAboveWindows atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	else {
		[mainWindow setLevel: NSNormalWindowLevel];
		[@"NO" writeToFile:floatAboveWindows atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
}

#pragma mark -
#pragma mark Dropbox Sync Functions

- (IBAction)toggleSyncDropBox:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = @"~/Library/Application Support/ScratchPad/Preferences/";
    folder2 = [folder2 stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder2] == NO) {
        [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
    }

    NSString *syncLoc = [self syncDropBoxLoc];
    NSString *dbDirectory = [syncLoc stringByAppendingPathComponent: @"/ScratchPad"];
    NSString *localDir = @"~/Library/Application Support/ScratchPad";
    localDir = [localDir stringByExpandingTildeInPath];
    
    NSString *syncDropBoxPref = [folder2 stringByAppendingPathComponent: @"SyncDropBox.txt"];

    if ([syncDropBox state] == 1) {
        [dropBoxLocationButton setEnabled:YES];
        
        NSInteger sCode = NSRunAlertPanel(NSLocalizedStringFromTable(@"Sync with Dropbox", @"Localized", @"Sync with Dropbox"), NSLocalizedStringFromTable(@"Before enabling synchronization with Dropbox, it is highly recommended that you first make a backup of your ScratchPad files using the built-in backup feature.", @"Localized", @"Before enabling synchronization with Dropbox, it is highly recommended that you first make a backup of your ScratchPad files using the built-in backup feature."), NSLocalizedStringFromTable(@"Continue", @"Localized", @"Continue"), NSLocalizedStringFromTable(@"Cancel", @"Localized", @"Cancel"), nil);
        
        switch(sCode) {
            case NSAlertDefaultReturn:
                if (!syncLoc || syncLoc == @"") {
                    [self setDropBoxLoc:self];
                    return;
                }
                
                break;
            case NSAlertAlternateReturn:
                [dropBoxLocationButton setEnabled:NO];
                [syncDropBox setState: NSOffState];
                return;
                break;
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath: dbDirectory] == YES) {
            NSInteger code = NSRunAlertPanel(@"ScratchPad", NSLocalizedStringFromTable(@"ScratchPad has already been synchronized with this Dropbox account either on this computer or another. Please choose carefully how to proceed as all changes are permanent and CANNOT be undone. If you are unsure, click 'Cancel' and backup your ScratchPad files before continuing to avoid data loss.", @"Localized", @"Already previously synchronized"), NSLocalizedStringFromTable(@"Cancel", @"Localized", @"Cancel"), NSLocalizedStringFromTable(@"Replace files on this computer", @"Localized", @"Replace files on this computer"), NSLocalizedStringFromTable(@"Replace files on Dropbox", @"Localized", @"Replace files on Dropbox"));
            int pInt = 1;
            
            switch(code) {
                case NSAlertDefaultReturn:
                    // Cancel
                    [dropBoxLocationButton setEnabled:NO];
                    [syncDropBox setState: NSOffState];
                    return;
                    break;
                case NSAlertAlternateReturn:
                    // Replace on Computer                    
                    [fileManager removeItemAtPath: localDir error: NULL];
                    
                    if (![fileManager copyItemAtPath: dbDirectory toPath: localDir error: NULL]) {
                        NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem with copying your ScratchPad files from Dropbox to your computer", @"Localized", @"There was a problem with copying your ScratchPad files from Dropbox to your computer"), @"OK", nil, nil);
                    }
                    
                    [mainWindow goToPageNumber:pInt pageNum:@"1"];
                    
                    break;
                case NSAlertOtherReturn:
                    // Replace on Dropbox                    
                    [fileManager removeItemAtPath: dbDirectory error: NULL];
                    
                    if (![fileManager copyItemAtPath: localDir toPath: dbDirectory error: NULL]) {
                        NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem with copying your ScratchPad files to Dropbox", @"Localized", @"There was a problem with copying your ScratchPad files to Dropbox"), @"OK", nil, nil);
                    }
                    
                    [syncDropBox setState: NSOffState];
                    [mainWindow goToPageNumber:pInt pageNum:@"1"];
                    [syncDropBox setState: NSOnState];
                    
                    break;
            }
            
            /*NSString *prefFilesDb = [dbDirectory stringByAppendingPathComponent: @"/Preferences"];
            NSString *noteFilesDb = [dbDirectory stringByAppendingPathComponent: @"/Notes"];
            NSString *prefFilesLocal = [localDir stringByAppendingPathComponent: @"/Preferences"];
            NSString *noteFilesLocal = [localDir stringByAppendingPathComponent: @"/Notes"];
            
            //NSArray *prefFilesDbChildren = [fileManager contentsOfDirectoryAtPath: prefFilesDb error: NULL];
            NSArray *prefFilesLocalChildren = [fileManager contentsOfDirectoryAtPath: prefFilesLocal error: NULL];
            
            for (NSString *fileName in prefFilesLocalChildren) {
                NSString *pathToChildDb = [prefFilesDb stringByAppendingPathComponent: fileName];
                NSString *pathToChildLocal = [prefFilesLocal stringByAppendingPathComponent: fileName];
                
                if ([fileManager fileExistsAtPath: pathToChildDb] == YES) {
                    if ([fileManager contentsEqualAtPath: pathToChildDb andPath: pathToChildLocal] == NO) {
                        NSString *localContents = [NSString stringWithContentsOfFile:pathToChildLocal encoding: NSUTF8StringEncoding error:nil];
                        NSString *dbContents = [NSString stringWithContentsOfFile:pathToChildLocal encoding: NSUTF8StringEncoding error:nil];
                        
                        if (localContents != @"" && dbContents != @"") {
                            NSDate *modDateDb = [[fileManager attributesOfItemAtPath:pathToChildDb error:nil] fileModificationDate];
                            NSDate *modDateLocal = [[fileManager attributesOfItemAtPath:pathToChildLocal error:nil] fileModificationDate];
                            
                            if (modDateDb < modDateLocal) {                            
                                [fileManager removeItemAtPath: pathToChildDb error: NULL];
                                
                                if (![fileManager copyItemAtPath: pathToChildLocal toPath: pathToChildDb error: NULL]) {
                                    NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem copying your preferences to Dropbox", @"Localized", @"There was a problem copying your preferences to Dropbox"), @"OK", nil, nil);
                                }
                            }
                        }
                    }
                }
                else {
                    if (![fileManager copyItemAtPath: pathToChildLocal toPath: pathToChildDb error: NULL]) {
                        NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem copying your preferences to Dropbox", @"Localized", @"There was a problem copying your preferences to Dropbox"), @"OK", nil, nil);
                    }
                }
            }
            
            //NSArray *noteFilesDbChildren = [fileManager contentsOfDirectoryAtPath: noteFilesDb error: NULL];
            NSArray *noteFilesLocalChildren = [fileManager contentsOfDirectoryAtPath: noteFilesLocal error: NULL];
            
            for (NSString *fileName in noteFilesLocalChildren) {
                NSString *pathToChildDb = [noteFilesDb stringByAppendingPathComponent: fileName];
                NSString *pathToChildLocal = [noteFilesLocal stringByAppendingPathComponent: fileName];
                
                if ([fileManager fileExistsAtPath: pathToChildDb] == YES) {
                    if ([fileManager contentsEqualAtPath: pathToChildDb andPath: pathToChildLocal] == NO) {
                        NSString *localContents = [NSString stringWithContentsOfFile:pathToChildLocal encoding: NSUTF8StringEncoding error:nil];
                        NSString *dbContents = [NSString stringWithContentsOfFile:pathToChildLocal encoding: NSUTF8StringEncoding error:nil];
                        
                        if (localContents != @"" && dbContents != @"") {
                            NSDate *modDateDb = [[fileManager attributesOfItemAtPath:pathToChildDb error:nil] fileModificationDate];
                            NSDate *modDateLocal = [[fileManager attributesOfItemAtPath:pathToChildLocal error:nil] fileModificationDate];
                            
                            if (modDateDb < modDateLocal) {                            
                                [fileManager removeItemAtPath: pathToChildDb error: NULL];
                                
                                if (![fileManager copyItemAtPath: pathToChildLocal toPath: pathToChildDb error: NULL]) {
                                    NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem copying your notes to Dropbox", @"Localized", @"There was a problem copying your notes to Dropbox"), @"OK", nil, nil);
                                }
                            }
                        }
                    }
                }
                else {
                    if (![fileManager copyItemAtPath: pathToChildLocal toPath: pathToChildDb error: NULL]) {
                        NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem copying your notes to Dropbox", @"Localized", @"There was a problem copying your notes to Dropbox"), @"OK", nil, nil);
                    }
                }
            }*/
        }
        else {
            if (![fileManager copyItemAtPath: localDir toPath: dbDirectory error: NULL]) {
                NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem with copying your ScratchPad files to Dropbox", @"Localized", @"There was a problem with copying your ScratchPad files to Dropbox"), @"OK", nil, nil);
            }
        }
        
        [@"YES" writeToFile:syncDropBoxPref atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else {
        [dropBoxLocationButton setEnabled:NO];
        
        NSString *folder = @"~/Library/Application Support/ScratchPad/";
		folder = [folder stringByExpandingTildeInPath];
        
        if ([fileManager fileExistsAtPath: dbDirectory] == YES) {
            [fileManager removeItemAtPath: localDir error: NULL];
            
            if (![fileManager copyItemAtPath: dbDirectory toPath: localDir error: NULL]) {
                NSRunAlertPanel(NSLocalizedStringFromTable(@"Problem with Dropbox", @"Localized", @"Problem with Dropbox"), NSLocalizedStringFromTable(@"There was a problem with copying your ScratchPad files from Dropbox", @"Localized", @"There was a problem with copying your ScratchPad files from Dropbox"), @"OK", nil, nil);
            }
        }
            
        [@"NO" writeToFile:syncDropBoxPref atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (IBAction)setDropBoxLoc:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories: YES];
	[panel setCanChooseFiles: NO];
	[panel setAllowsMultipleSelection: NO];
	
	if ([panel runModal] == NSOKButton) {		
		NSString *dbLoc = [[panel filenames] objectAtIndex: 0];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *folder2 = @"~/Library/Application Support/ScratchPad/Preferences/";
        folder2 = [folder2 stringByExpandingTildeInPath];
        
        if ([fileManager fileExistsAtPath: folder2] == NO) {
            [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
        }
        
        NSString *syncDropBoxLoc = [folder2 stringByAppendingPathComponent: @"SyncDropBoxLocation.txt"];
        
        [dbLoc writeToFile:syncDropBoxLoc atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [dropBoxLocation setStringValue: dbLoc];
        
        [self toggleSyncDropBox:self];
	}
}

- (NSString*)syncDropBoxLoc {
    return [dropBoxLocation stringValue];
}

#pragma mark -
#pragma mark Font Functions

- (IBAction)selectDefaultFont:(id)sender {
	NSFontManager *fontManager = [NSFontManager sharedFontManager];
	[fontManager orderFrontFontPanel:self];
	
	NSFont *newFont = [fontManager selectedFont];
	[defaultFontDisplayBox setFont: newFont];
}

@end
