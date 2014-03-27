//
//  TextViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

#pragma mark -
#pragma mark Note Actions

- (void)loadNote:(NSInteger)noteIndex {
    NSString *fileName = [_noteController getNote:noteIndex];
    NSString *path = [[_helper pathToNotes] stringByAppendingString:fileName];

    [_textView readRTFDFromFile:path];
    [_noteTitle setStringValue:[_noteController getNoteName:noteIndex]];
    [_noteDate setStringValue:[_helper formatDate:[_noteController getNoteDate:noteIndex]]];
    [_noteController setCurrentNote:noteIndex];
    
    [self enableDisableBackButton:noteIndex];
    [_textView setSelectedRange:(NSRange){0, 0}];
}

- (void)loadBlankNote:(NSInteger)noteIndex {
    NSDate *date = [NSDate date];
    NSString *now = [_helper formatDate:[date description]];
    
    [_textView setString:@""];
    [_noteTitle setStringValue:@""];
    [_noteDate setStringValue:now];
    [_noteController setCurrentNote:noteIndex];
    
    [self enableDisableBackButton:noteIndex];
    [_textView setSelectedRange:(NSRange){0, 0}];
}

- (void)saveNote {
    NSInteger currentNote = [_noteController getCurrentNote];
    NSString *fileName = [_noteController getNote:currentNote];
    NSString *path = [[_helper pathToNotes] stringByAppendingString:fileName];
	bool isGarbage = [self noteGarbageCollector];
    
    if (isGarbage == YES) {
//		if ([fileManager fileExistsAtPath: path] == YES) {
//			[fileManager removeFileAtPath: path handler: nil];
//		}
	}
	else {
		[_textView writeRTFDToFile: path atomically:NO];
	}
    
	[_window setDocumentEdited: NO];
}

- (IBAction)saveNoteAction:(id)sender {
    [self saveNote];
}

- (bool)noteGarbageCollector {
	NSInteger textEditor = [[_textView textStorage] length];
	
	if (textEditor == 0) {
		return YES;
	}
	
	return NO;
}

- (IBAction)newNote:(id)sender {
    NSInteger numOfNotes = [_noteController getNumberOfNotes];
    
    [self loadBlankNote:numOfNotes];
}

- (void)nextNote {
    NSInteger currentNote = [_noteController getCurrentNote];
    NSInteger nextNote = currentNote + 1;
    NSInteger numOfNotes = [_noteController getNumberOfNotes];
    
    [self saveNote];
    
    if (nextNote >= numOfNotes) {
        [self loadBlankNote:nextNote];
    }
    else {
        [self loadNote:nextNote];
    }
}

- (void)prevNote {
    NSInteger currentNote = [_noteController getCurrentNote];
    NSInteger nextNote = currentNote - 1;
    NSInteger numOfNotes = [_noteController getNumberOfNotes];
    
    [self saveNote];
    
    if (nextNote >= 0) {
        if (nextNote >= numOfNotes) {
            [self loadBlankNote:nextNote];
        }
        else {
            [self loadNote:nextNote];
        }
    }
}

- (IBAction)goToNote:(id)sender {
    NSInteger pageNum = [[sender stringValue] integerValue];
    NSInteger numOfNotes = [_noteController getNumberOfNotes];
    
    [self saveNote];
    
    if (pageNum > 0) {
        pageNum--;
    }
    else if (pageNum < 0) {
        pageNum = 0;
    }
    
    if (pageNum > numOfNotes) {
        [self loadBlankNote:pageNum];
    }
    else {
        [self loadNote:pageNum];
    }
}

- (void)enableDisableBackButton:(NSInteger)noteIndex {
    if (noteIndex != 0) {
        [_backForwardButtons setEnabled:true forSegment:0];
    }
    else {
        [_backForwardButtons setEnabled:false forSegment:0];
    }
}


#pragma mark -
#pragma mark TextView Actions

- (IBAction)toggleToolbar:(id)sender {
    if ([_textView usesInspectorBar]) {
        [_textView setUsesInspectorBar:NO];
        [sender setTitle:@"Show Editor Toolbar"];
    }
    else {
        [_textView setUsesInspectorBar:YES];
        [sender setTitle:@"Hide Editor Toolbar"];
    }
}

- (IBAction)toggleRichText:(id)sender {
//    if ([_textView isRichText]) {
//        [_textView setUsesInspectorBar:NO];
//        [_textView setRichText:NO];
//        [sender setTitle:@"Make Rich Text"];
//    }
//    else {
//        [_textView setRichText:YES];
//        [sender setTitle:@"Make Plain Text"];
//    }
    
    NSTextView *view = _textView;
    NSDictionary *textAttributes;
    NSParagraphStyle *paragraphStyle;
    
    _isRichText = false;
    
    //if (!_isRichText && attachmentFlag) [self removeAttachments];
    
    [view setRichText:_isRichText];
    [view setUsesRuler:_isRichText];    /* If NO, this correctly gets rid of the ruler if it was up */
    //if (_isRichText && [[Preferences objectForKey:ShowRuler] boolValue])
    //    [view setRulerVisible:YES];    /* Show ruler if rich, and desired */
    [view setImportsGraphics:_isRichText];
    
    //textAttributes = [self defaultTextAttributes:_isRichText];
    paragraphStyle = [textAttributes objectForKey:NSParagraphStyleAttributeName];
    
    //if ([textStorage length]) {
    //    [textStorage setAttributes:textAttributes range: NSMakeRange(0, [textStorage length])];
    //}
    [view setTypingAttributes:textAttributes];
    [view setDefaultParagraphStyle:paragraphStyle];
}

#pragma mark -
#pragma mark TextView Delegate Actions

- (void) textDidChange: (NSNotification *) notification {
	[_window setDocumentEdited: YES];
}

@end
