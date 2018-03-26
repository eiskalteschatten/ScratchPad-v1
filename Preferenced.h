/* Preferenced */

#import <Cocoa/Cocoa.h>

@interface Preferenced : NSWindow {
    IBOutlet id mainWindow;
    IBOutlet id pageNumberBox;
    IBOutlet id textView;
    IBOutlet id changePageNumberMenu;
    IBOutlet id changeRememberPageNumberBox;
	IBOutlet id defaultFontDisplayBox;
	IBOutlet id transSlider;
	IBOutlet id transTextbox;
	IBOutlet id floatAboveWindowsBox;
    IBOutlet id syncDropBox;
    IBOutlet id dropBoxLocationButton;
    IBOutlet id dropBoxLocation;

    NSString *pathToSupportLoc;
}

- (void)checkAndReadPreferences;
- (NSString*)pathToSp;
- (NSString*)pathToPrefs;
- (NSString*)pathToNotes;

- (IBAction)changePageNumberBox:(id)sender;
- (void)togglePageNumberBox:(BOOL)yesNo;
- (IBAction)changeRememberPageNumber:(id)sender;

- (IBAction)changeFloatAboveWindows:(id)sender;

- (IBAction)toggleSyncDropBox:(id)sender;
- (IBAction)setDropBoxLoc:(id)sender;
- (NSString*)syncDropBoxLoc;

- (IBAction)selectDefaultFont:(id)sender;

@end
