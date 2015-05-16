//
//  PreferencesViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 5/3/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib {
    _standardDefaults = [NSUserDefaults standardUserDefaults];
    
    bool imported = [_standardDefaults boolForKey:@"oldPreferencesImported"];
    //bool imported = NO;
    
    if (imported == NO) {
        [self importOldPreferencesAndSetDefaults];
    }
    
    // FLOAT ABOVE WINDOWS
    
    bool floatWindow = [_standardDefaults boolForKey:@"floatAboveWindows"];
    
    if (floatWindow) {
        [_mainWindow setLevel: NSPopUpMenuWindowLevel];
        [_floatAboveWindows setState:NSOnState];
        [_floatAboveWindowsMenu setState:NSOnState];
    }
    else {
        [_floatAboveWindows setState:NSOffState];
        [_floatAboveWindowsMenu setState:NSOffState];
    }
    
    // REMEMBER PAGE NUMBER
    
    NSInteger rememberPageInt = [_standardDefaults integerForKey:@"rememberPageNumber"];
    
    if (rememberPageInt != -1) {
        [_rememberPageNumber setState:NSOnState];
    }
    else {
        [_rememberPageNumber setState:NSOffState];
    }
    
    // TRANSPARENCY
    
    NSInteger transparency = [_standardDefaults integerForKey:@"transparency"];
    float f = transparency / 100.0;
	
    [_mainWindow setOpaque: NO];
    [_mainWindow setAlphaValue: f];
    [_mainWindow update];
	
    [_transparencySlider setFloatValue:transparency];
    [_transparencyText setIntegerValue:transparency];
}

#pragma mark -
#pragma mark Window Float Options

- (IBAction)setFloatOption:(id)sender {
    bool floatWindow = [_standardDefaults boolForKey:@"floatAboveWindows"];
    
	if (!floatWindow) {
		[_mainWindow setLevel: NSPopUpMenuWindowLevel];
        [_floatAboveWindowsMenu setState:NSOnState];
        [_floatAboveWindows setState:NSOnState];
        [_standardDefaults setBool:YES forKey:@"floatAboveWindows"];
	}
	else {
		[_mainWindow setLevel: NSNormalWindowLevel];
        [_floatAboveWindowsMenu setState:NSOffState];
        [_floatAboveWindows setState:NSOffState];
        [_standardDefaults setBool:NO forKey:@"floatAboveWindows"];
	}
    
    [_standardDefaults synchronize];
}

#pragma mark -
#pragma mark Remember Page Number Functions

- (IBAction)setRememberPageNumberOption:(id)sender {
	if ([sender state] == NSOnState) {
        NSInteger rememberPageInt = [_noteController getCurrentNote];
        [_standardDefaults setInteger:rememberPageInt forKey:@"rememberPageNumber"];
	}
	else {
        [_standardDefaults setInteger:-1 forKey:@"rememberPageNumber"];
	}
    
    [_standardDefaults synchronize];
}

#pragma mark -
#pragma mark Transparency Functions

- (IBAction)changeTransparency:(id)sender {
	float f = [sender floatValue];
	
	f = f / 100;
	
	[_mainWindow setOpaque: NO];
	[_mainWindow setAlphaValue: f];
	[_mainWindow update];
	
	[_transparencySlider setFloatValue: [sender floatValue]];
	[_transparencyText setIntValue: [sender intValue]];
    
    [_standardDefaults setInteger:[sender intValue] forKey:@"transparency"];
    [_standardDefaults synchronize];
}

#pragma mark -
#pragma mark Import Old Prefernces and Set Defaults

- (void)importOldPreferencesAndSetDefaults {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *library = [_helper pathToLibrary];
    library = [library stringByAppendingString:@"Preferences/"];
    
    // FLOAT ABOVE WINDOWS
    
    NSString *pFileName = [library stringByAppendingPathComponent: @"FloatAboveWindows.txt"];
    bool floatWindow;
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {
        floatWindow = [[NSString stringWithContentsOfFile:pFileName encoding: NSUTF8StringEncoding error:nil] boolValue];
    }
    else {
        floatWindow = NO;
    }
    
    [_standardDefaults setBool:floatWindow forKey:@"floatAboveWindows"];
    
    // REMEMBER PAGE NUMBER
    
    pFileName = [library stringByAppendingPathComponent: @"RememberPageNumber.txt"];
    NSString *rememberPage;
    NSInteger rememberPageInt = -1;
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {
        rememberPage = [NSString stringWithContentsOfFile:pFileName encoding: NSUTF8StringEncoding error:nil];
        
        if (![rememberPage isEqual:@"NO"]) {
            rememberPageInt = [rememberPage integerValue];
        }
    }
    else {
        rememberPageInt = 1;
    }
    
    [_standardDefaults setInteger:rememberPageInt forKey:@"rememberPageNumber"];
    
    // SYNC DROPBOX
    
    pFileName = [library stringByAppendingPathComponent: @"SyncDropBox.txt"];
    bool syncDropBox;
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {
        syncDropBox = [[NSString stringWithContentsOfFile:pFileName encoding: NSUTF8StringEncoding error:nil] boolValue];
    }
    else {
        syncDropBox = NO;
    }
    
    [_standardDefaults setBool:syncDropBox forKey:@"syncDropBox"];
    
    // DROPBOX LOCATION
    
    pFileName = [library stringByAppendingPathComponent: @"SyncDropBoxLocation.txt"];
    NSString *dropBoxLocation = @"";
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {
        dropBoxLocation = [NSString stringWithContentsOfFile:pFileName encoding: NSUTF8StringEncoding error:nil];
    }
    
    [_standardDefaults setObject:dropBoxLocation forKey:@"dropBoxLocation"];
    
    // TRANSPARENCY
    
    pFileName = [library stringByAppendingPathComponent: @"Transparency.txt"];
    NSInteger transparency;
    
    if ([fileManager fileExistsAtPath: pFileName] == NO) {
        transparency = [[NSString stringWithContentsOfFile:pFileName encoding: NSUTF8StringEncoding error:nil] integerValue];
    }
    else {
        transparency = 100;
    }
    
    [_standardDefaults setInteger:transparency forKey:@"transparency"];
    
    [_standardDefaults setBool:YES forKey:@"oldPreferencesImported"];
    [_standardDefaults synchronize];
}

@end
