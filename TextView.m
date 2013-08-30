#import "TextView.h"

@implementation TextView

- (void) textDidChange: (NSNotification *) notification {
	[mainWindow setDocumentEdited: YES];
}

@end
