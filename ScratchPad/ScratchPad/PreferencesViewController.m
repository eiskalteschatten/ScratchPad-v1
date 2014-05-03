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
        [self importOldPreferences];
    }
    
    // FLOAT ABOVE WINDOWS
    
    bool floatWindow = [_standardDefaults boolForKey:@"floatAboveWindows"];
    
    if (floatWindow) {
        [_mainWindow setLevel: NSPopUpMenuWindowLevel];
        [_floatAboveWindows setState:NSOnState];
    }
    else {
        [_floatAboveWindows setState:NSOffState];
    }
    
    // REMEMBER PAGE NUMBER
    
    NSInteger rememberPageInt = [_standardDefaults integerForKey:@"rememberPageNumber"];
    
    if (rememberPageInt != -1) {
        [_rememberPageNumber setState:NSOnState];
    }
    else {
        [_rememberPageNumber setState:NSOffState];
    }
}

- (IBAction)setFloatOption:(id)sender {
	if ([sender state] == NSOnState) {
		[_mainWindow setLevel: NSPopUpMenuWindowLevel];
        [_standardDefaults setBool:YES forKey:@"floatAboveWindows"];
	}
	else {
		[_mainWindow setLevel: NSNormalWindowLevel];
        [_standardDefaults setBool:NO forKey:@"floatAboveWindows"];
	}
    
    [_standardDefaults synchronize];
}

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

- (void)importOldPreferences {
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
    
    [_standardDefaults setBool:floatWindow forKey:@"syncDropBox"];
    
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
