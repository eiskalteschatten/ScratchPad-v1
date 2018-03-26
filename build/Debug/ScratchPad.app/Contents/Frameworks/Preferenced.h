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
}

- (void)checkAndReadPreferences;
- (NSString*)pathToPrefs;

- (IBAction)changePageNumberBox:(id)sender;
- (void)togglePageNumberBox:(BOOL)yesNo;
- (IBAction)changeRememberPageNumber:(id)sender;

- (IBAction)changeFloatAboveWindows:(id)sender;

- (IBAction)selectDefaultFont:(id)sender;

@end
