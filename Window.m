#import "Window.h"

@implementation Window

- (void)windowWillClose:(NSNotification *)aNotification {
	[mainWindow saveNote:self];
	[mainWindow writeRememberPageNumber];
	
	[[NSApplication sharedApplication] terminate: self];
}

- (void)windowWillMiniaturize:(NSNotification *)aNotification {
	[mainWindow saveNote:self];
}

- (void)windowDidResignKey:(NSNotification *)aNotification {
	//[mainWindow saveNote:self];
}

@end
