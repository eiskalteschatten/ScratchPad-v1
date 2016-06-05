/* Scratched */

#import <Cocoa/Cocoa.h>

@interface Scratched : NSWindow {
    IBOutlet id textView;
    IBOutlet id prefWindow;
    IBOutlet id navigateButtons;
    IBOutlet id pageNumber;
    IBOutlet id totalPages;
    IBOutlet id navBackMenu;
    IBOutlet id navForwardMenu;
    IBOutlet id goToPageNumber;
	IBOutlet id transSlider;
	IBOutlet id transTextbox;
    IBOutlet id pageNumberBox;
    IBOutlet id exportButton;
	
	NSMutableArray *rawnotes;
	NSMutableArray *notes;
	
	NSToolbar *toolbar;
	NSMutableDictionary *items;
}

- (void)makeToolbarItems;
- (IBAction)customizeToolbar:(id)sender;
- (float)ToolbarHeightForWindow;

- (IBAction)navigate:(id)sender;
- (IBAction)navBack:(id)sender;
- (IBAction)navForward:(id)sender;
- (IBAction)navToPageNumber:(id)sender;
- (IBAction)openPrefs:(id)sender;
- (IBAction)showRuler:(id)sender;

- (NSString*)pathToSp;
- (NSString *)pathToPrefs;
- (NSString *)pathToNotes;
- (NSString *)pathToOpenNote;
- (BOOL)doesNoteExist;
- (IBAction)saveNote:(id)sender;
- (void)goToPageNumber:(int)iPageNum pageNum:(NSString*)pageNum;
- (void)writeRememberPageNumber;
- (IBAction)exportNote:(id)sender;
- (bool)noteGarbageCollector;
- (IBAction)deleteNote:(id)sender;
- (IBAction)createBackup:(id)sender;
- (IBAction)restoreBackup:(id)sender;

- (IBAction)changeTransparency:(id)sender;

@end
