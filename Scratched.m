#import "Scratched.h"

@implementation Scratched

- (void)awakeFromNib {
	[prefWindow checkAndReadPreferences];
	
	items = [[NSMutableDictionary alloc] init];
	[self makeToolbarItems];

	toolbar = [[NSToolbar alloc] initWithIdentifier:@"mainWindowToolbar"];
	[toolbar setDelegate:self];
	[toolbar setAllowsUserCustomization:YES];
	[toolbar setAutosavesConfiguration:YES];
	[self setToolbar:toolbar];
	
	if ([pageNumber intValue] <= 1) {
		[navigateButtons setEnabled:NO forSegment:0];
		[navBackMenu setEnabled:NO];
	}
	else {
		[navigateButtons setEnabled:YES forSegment:0];
		[navBackMenu setEnabled:YES];
	}
	
	NSString *path = [self pathToOpenNote];
	[textView readRTFDFromFile:path];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo {
    [sheet orderOut:self];
}

#pragma mark -
#pragma mark Toolbar Functions

- (void)makeToolbarItems {
	NSToolbarItem *toolbarItem;
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"openPrefs"];

	[toolbarItem setLabel:NSLocalizedStringFromTable(@"Preferences", @"Localized", @"Preferences toolbar label")];
	[toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Preferences", @"Localized", @"Preferences toolbar palette label")];
	[toolbarItem setToolTip:NSLocalizedStringFromTable(@"Opens the application preferences", @"Localized", @"Preferences toolbar item tooltip")];
	[toolbarItem setImage:[NSImage imageNamed:@"NSPreferencesGeneral"]];
	[toolbarItem setTarget:self];
	[toolbarItem setAction:@selector(openPrefs:)];
	
	[items setObject:toolbarItem forKey:@"openPrefs"];
	
	[toolbarItem release];
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"navigateButtons"];
	
    [toolbarItem setLabel:NSLocalizedStringFromTable(@"Navigate", @"Localized", @"Navigate toolbar label")];
    [toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Navigate", @"Localized", @"Navigate toolbar palette label")];
    [toolbarItem setToolTip:NSLocalizedStringFromTable(@"Navigate pages", @"Localized", @"Navigate toolbar item tooltip")];
    [toolbarItem setView:navigateButtons];
    [toolbarItem setMinSize:NSMakeSize(NSWidth([navigateButtons frame]),NSHeight([navigateButtons frame]))];
	[toolbarItem setMaxSize:NSMakeSize(NSWidth([navigateButtons frame]),NSHeight([navigateButtons frame]))];
	
	[items setObject:toolbarItem forKey:@"navigateButtons"];
	
	[toolbarItem release];
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"goToPageNumber"];
	
    [toolbarItem setLabel:NSLocalizedStringFromTable(@"Go To Page", @"Localized", @"Go To Page toolbar label")];
    [toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Go To Page Number", @"Localized", @"Go To Page toolbar palette label")];
    [toolbarItem setToolTip:NSLocalizedStringFromTable(@"Go to a specific page number", @"Localized", @"Go To Page toolbar item tooltip")];
    [toolbarItem setView:goToPageNumber];
    [toolbarItem setMinSize:NSMakeSize(27,22)];
	[toolbarItem setMaxSize:NSMakeSize(27,22)];
	
	[items setObject:toolbarItem forKey:@"goToPageNumber"];
	
	[toolbarItem release];
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"exportNote"];

	[toolbarItem setLabel:NSLocalizedStringFromTable(@"Export", @"Localized", @"Export toolbar label")];
	[toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Export Page", @"Localized", @"Export toolbar palette label")];
	[toolbarItem setToolTip:NSLocalizedStringFromTable(@"Export a page to a file", @"Localized", @"Export toolbar item tooltip")];
    [toolbarItem setView:exportButton];
    [toolbarItem setMinSize:NSMakeSize(NSWidth([exportButton frame]),NSHeight([exportButton frame]))];
    [toolbarItem setMaxSize:NSMakeSize(NSWidth([exportButton frame]),NSHeight([exportButton frame]))];
	[toolbarItem setAction:@selector(exportNote:)];
	
	[items setObject:toolbarItem forKey:@"exportNote"];
	
	[toolbarItem release];
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"showRuler"];
    
	[toolbarItem setLabel:NSLocalizedStringFromTable(@"Ruler", @"Localized", @"Show Ruler toolbar label")];
	[toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Ruler", @"Localized", @"Show Ruler toolbar palette label")];
	[toolbarItem setToolTip:NSLocalizedStringFromTable(@"Show or hide the ruler", @"Localized", @"Show Ruler toolbar item tooltip")];
	[toolbarItem setImage:[NSImage imageNamed:@"showruler"]];
	[toolbarItem setTarget:self];
	[toolbarItem setAction:@selector(showRuler:)];
    
	[items setObject:toolbarItem forKey:@"showRuler"];
	
	[toolbarItem release];	
	
	toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:@"deleteNote"];

	[toolbarItem setLabel:NSLocalizedStringFromTable(@"Delete Page", @"Localized", @"Delete Page toolbar label")];
	[toolbarItem setPaletteLabel:NSLocalizedStringFromTable(@"Delete Page", @"Localized", @"Delete Page toolbar palette label")];
	[toolbarItem setToolTip:NSLocalizedStringFromTable(@"Delete the page", @"Localized", @"Delete Page toolbar item tooltip")];
	[toolbarItem setImage:[NSImage imageNamed:@"NSTrashEmpty"]];
	[toolbarItem setTarget:self];
	[toolbarItem setAction:@selector(deleteNote:)];
	
	[items setObject:toolbarItem forKey:@"deleteNote"];
	
	[toolbarItem release];	
		
	[items setObject:NSToolbarPrintItemIdentifier forKey:NSToolbarPrintItemIdentifier];
	[items setObject:NSToolbarCustomizeToolbarItemIdentifier forKey:NSToolbarCustomizeToolbarItemIdentifier];
	[items setObject:NSToolbarFlexibleSpaceItemIdentifier forKey:NSToolbarFlexibleSpaceItemIdentifier];
	[items setObject:NSToolbarSpaceItemIdentifier forKey:NSToolbarSpaceItemIdentifier];
	[items setObject:NSToolbarSeparatorItemIdentifier forKey:NSToolbarSeparatorItemIdentifier];
	[items setObject:NSToolbarShowFontsItemIdentifier forKey:NSToolbarShowFontsItemIdentifier];
	[items setObject:NSToolbarShowColorsItemIdentifier forKey:NSToolbarShowColorsItemIdentifier];
}

- (NSToolbarItem *) toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
	return [items objectForKey:itemIdentifier];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar {
	return [items allKeys];
}

- (NSArray *) toolbarDefaultItemIdentifiers: (NSToolbar *) toolbar {
	return [NSArray arrayWithObjects: @"navigateButtons", @"goToPageNumber", NSToolbarFlexibleSpaceItemIdentifier, @"showRuler", NSToolbarShowColorsItemIdentifier, NSToolbarShowFontsItemIdentifier, nil];
}

- (void) toolbarWillAddItem: (NSNotification *) notification {
//    NSToolbarItem *addedItem = [[notification userInfo] objectForKey:@"item"];
}

- (IBAction)customizeToolbar:(id)sender {
	 [toolbar runCustomizationPalette:sender]; 
}

- (float)ToolbarHeightForWindow {
	float toolbarHeight = 0.0;

    NSRect windowFrame;

	if(toolbar && [toolbar isVisible]) {
		windowFrame = [NSWindow contentRectForFrameRect:[self frame] styleMask:[self styleMask]];
		toolbarHeight = NSHeight(windowFrame) - NSHeight([[self contentView] frame]);
    }
    return toolbarHeight;
}

#pragma mark -
#pragma mark Toolbar Actions

- (IBAction)navigate:(id)sender {
    NSInteger clicked = [sender selectedSegment];
    
    if (clicked == 0) {
        [self navBack:sender];
    }
    else {
        [self navForward:sender];
    }
}

- (IBAction)navBack:(id)sender {
    [self saveNote: self];

    int pageNum = [pageNumber intValue];
    
    if (pageNum != 1) {
        pageNum = pageNum - 1;
        [pageNumber setIntValue: pageNum];
        [self setTitle: [NSString stringWithFormat:@"ScratchPad (%i)", pageNum]];

        NSString *path = [self pathToOpenNote];

        if ([self doesNoteExist] == YES) {
            [textView readRTFDFromFile:path];
        }
        else {
            [textView setString: @""];
        }
        
        if (pageNum <= 1) {
            [sender setEnabled:NO forSegment:0];
            [navBackMenu setEnabled:NO];
        }
    }
}

- (IBAction)navForward:(id)sender {
	[self saveNote: self];

	int pageNum = [pageNumber intValue];
	pageNum = pageNum + 1;
	[pageNumber setIntValue: pageNum];
	[self setTitle: [NSString stringWithFormat:@"ScratchPad (%i)", pageNum]];
	
	NSString *path = [self pathToOpenNote];
	
	if ([self doesNoteExist] == YES) {
		[textView readRTFDFromFile:path];
	}
	else {
		[textView setString: @""];
	}
	
    [sender setEnabled:YES forSegment:0];
	[navBackMenu setEnabled:YES];
}

- (IBAction)navToPageNumber:(id)sender {
	[self saveNote:self];

	int iPageNum = [sender intValue];
	NSString *pageNum = [sender stringValue];

	[self goToPageNumber:iPageNum pageNum:pageNum];
}

- (IBAction)openPrefs:(id)sender {
	[prefWindow makeKeyAndOrderFront: self];
}

- (IBAction)showRuler:(id)sender {
	[textView toggleRuler: self];
}


#pragma mark -
#pragma mark Note Actions

- (NSString*)pathToSp {
    return [prefWindow pathToSp];
}

- (NSString *)pathToPrefs {
    return [prefWindow pathToPrefs];
}

- (NSString *)pathToNotes {
    return [prefWindow pathToNotes];
}

- (NSString *)pathToOpenNote {  
    NSString *folder2 = [self pathToNotes];
	int pageNum = [pageNumber intValue];	
	NSString *fileName = [NSString stringWithFormat:@"Note %i.rtfd", pageNum];
	
	return [folder2 stringByAppendingPathComponent: fileName];   
}

- (BOOL)doesNoteExist {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = [self pathToNotes];
    
	int pageNum = [pageNumber intValue];	
	NSString *fileName = [NSString stringWithFormat:@"Note %i.rtfd", pageNum];
	
	if ([fileManager fileExistsAtPath:[folder2 stringByAppendingPathComponent: fileName]]) {
		return YES;
	}
	return NO;   
}

- (IBAction)saveNote:(id)sender {
	bool isGarbage = [self noteGarbageCollector];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = [self pathToNotes];
	
	int pageNum = [pageNumber intValue];
	NSString *fileName = [NSString stringWithFormat:@"Note %i.rtfd", pageNum];
	
	NSString *path = [folder2 stringByAppendingPathComponent: fileName];
	
	if (isGarbage == YES) {
		if ([fileManager fileExistsAtPath: path] == YES) {
            [fileManager removeItemAtPath: path error: NULL];
		}
	}
	else {	
		[textView writeRTFDToFile: path atomically:NO];
	}

	[self setDocumentEdited: NO];
}

- (void)goToPageNumber:(int)iPageNum pageNum:(NSString*)pageNum {
	NSString *path;

	if (iPageNum > 0) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
    
        NSString *folder2 = [self pathToNotes];
    	
		NSString *fileName = [NSString stringWithFormat:@"Note %@.rtfd", pageNum];
		path = [folder2 stringByAppendingPathComponent: fileName];
	
		if ([fileManager fileExistsAtPath:path]) {
			[textView readRTFDFromFile:path];
		}
		else {
			[textView setString: @""];
		}
		
		if (iPageNum <= 1) {
			[navigateButtons setEnabled:NO forSegment:0];
			[navBackMenu setEnabled:NO];
		}
		else {
			[navigateButtons setEnabled:YES forSegment:0];
			[navBackMenu setEnabled:YES];
		}
		
		[pageNumber setStringValue: pageNum];
		[self setTitle: [NSString stringWithFormat:@"ScratchPad (%@)", pageNum]];
	}
}

- (void)writeRememberPageNumber {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder2 = [self pathToPrefs];
    
    if ([fileManager fileExistsAtPath: folder2] == NO) {
        [fileManager createDirectoryAtPath: folder2 withIntermediateDirectories: YES attributes: nil error: nil];
    }
	
	NSString *rememberPageNumber = [folder2 stringByAppendingPathComponent: @"RememberPageNumber.txt"];
	
	if ([fileManager fileExistsAtPath:rememberPageNumber]) {
		NSString *yesNo = [NSString stringWithContentsOfFile:rememberPageNumber encoding: NSUTF8StringEncoding error:nil];
		
		if ([yesNo isEqualToString: @"NO"] == NO) {
			[[pageNumber stringValue] writeToFile:rememberPageNumber atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	}
	else {
		[@"1" writeToFile:rememberPageNumber atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
}

- (IBAction)exportNote:(id)sender {
	NSSavePanel *panel = [NSSavePanel savePanel];
	
	[panel setRequiredFileType:@"rtfd"];
	if ([panel runModal] == NSOKButton) {
		[textView writeRTFDToFile:[panel filename] atomically:YES];
	}
}

- (bool)noteGarbageCollector {
	int textEditor = [[textView textStorage] length];
	
	if (textEditor == 0) {
		return YES;
	}
	
	return NO;
}

- (IBAction)deleteNote:(id)sender {
	if (NSRunAlertPanel(NSLocalizedStringFromTable(@"Delete Page", @"Localized", @"Delete Page alert panel title"), NSLocalizedStringFromTable(@"Are you sure you want to delete this page?", @"Localized", @"Delete Page alert panel question"), NSLocalizedStringFromTable(@"No", @"Localized", @"No"), NSLocalizedStringFromTable(@"Yes", @"Localized", @"Yes"), nil) == NSAlertAlternateReturn) {
		[textView setString: @""];
		[self saveNote: self];
	}
}

- (IBAction)createBackup:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories: YES];
	[panel setCanChooseFiles: NO];
	[panel setAllowsMultipleSelection: NO];
	
	if ([panel runModal] == NSOKButton) {	
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		NSString *backupDirectory = [[[panel filenames] objectAtIndex: 0] stringByAppendingPathComponent: @"ScratchPad/"];
    
        NSString *folder2 = [self pathToSp];

		if ([fileManager copyItemAtPath: folder2 toPath: backupDirectory error: NULL]) {
			NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Created", @"Localized", @"Backup Created"), NSLocalizedStringFromTable(@"Your backup has successfully been created!", @"Localized", @"Backup Success"), @"OK", nil, nil);
		}
		else {
			NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Not Created", @"Localized", @"Backup Not Created"), NSLocalizedStringFromTable(@"An error occurred and your backup was not created!", @"Localized", @"Backup Failure"), @"OK", nil, nil);
		}
	}
}

- (IBAction)restoreBackup:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	
	[panel setCanChooseDirectories: YES];
	[panel setCanChooseFiles: NO];
	[panel setAllowsMultipleSelection: NO];
	
	if ([panel runModal] == NSOKButton) {	
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		NSString *backupDirectory = [[panel filenames] objectAtIndex: 0];

		NSString *folder = @"~/Library/Application Support/ScratchPad/";
		folder = [folder stringByExpandingTildeInPath];

		NSString *folder1 = @"~/Library/Application Support/ScratchPad/Notes/";
		folder1 = [folder1 stringByExpandingTildeInPath];
    
		NSString *folder2 = @"~/Library/Application Support/ScratchPad/Preferences/";
		folder2 = [folder2 stringByExpandingTildeInPath];
		
		if (NSRunAlertPanel(NSLocalizedStringFromTable(@"Restore Backup", @"Localized", @"Restore Backup"), NSLocalizedStringFromTable(@"Are you sure you want to restore your backup and replace all of your current preferences and pages? All current preferences and pages will be lost.", @"Localized", @"Restore Backup alert panel question"), NSLocalizedStringFromTable(@"No", @"Localized", @"No"), NSLocalizedStringFromTable(@"Yes", @"Localized", @"Yes"), nil) == NSAlertAlternateReturn) {
			if ([fileManager fileExistsAtPath: folder] == YES) {
                [fileManager removeItemAtPath: folder error: NULL];
			}
			if ([fileManager copyItemAtPath: backupDirectory toPath: folder error: NULL]) {
				NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Restored", @"Localized", @"Backup Restored"), NSLocalizedStringFromTable(@"Your backup has successfully been restored!", @"Localized", @"Backup Restore Success"), @"OK", nil, nil);
			}
			else {
				NSRunAlertPanel(NSLocalizedStringFromTable(@"Backup Not Restored", @"Localized", @"Backup Not Restored"), NSLocalizedStringFromTable(@"An error occurred and your backup was not restored!", @"Localized", @"Backup Restore Failure"), @"OK", nil, nil);
			}
			
			[prefWindow checkAndReadPreferences];    	
			
			NSString *fileName = @"Note 1.rtfd";
			NSString *path = [folder1 stringByAppendingPathComponent: fileName];
	
			[textView readRTFDFromFile:path];
		}
	}
}

#pragma mark -
#pragma mark Transparency Functions

- (IBAction)changeTransparency:(id)sender {
	float f = [sender floatValue];
	
	f = f / 100;
	
	[self setOpaque: NO];
	[self setAlphaValue: f];
	[self update];
	
	[transSlider setFloatValue: [sender floatValue]];	
	[transTextbox setIntValue: [sender intValue]];
    
    NSString *folder2 = [self pathToPrefs];
	
	NSString *transparency = [folder2 stringByAppendingPathComponent: @"Transparency.txt"];

	[[sender stringValue] writeToFile:transparency atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
