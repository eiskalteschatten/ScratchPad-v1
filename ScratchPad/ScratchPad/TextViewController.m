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
	bool isGarbage = [self noteGarbageCollector];
    
    if (isGarbage == NO) {
        NSInteger currentNote = [_noteController getCurrentNote];
        NSInteger numOfNotes = [_noteController getNumberOfNotes];
        NSString *noteName = [_noteTitle stringValue];
        NSString *noteDate = [[NSDate date] description];
        NSString *fileName;
        long note = currentNote + 1;

        if ([noteName isEqual: @""]) {
            noteName = [NSString stringWithFormat:@"Note %li", note];
        }

        if (numOfNotes <= currentNote) {
            fileName = [NSString stringWithFormat:@"Note %li", note];
            fileName = [fileName stringByAppendingString:@".rtfd"];

            [_noteController setNewIndex:currentNote];
        }
        else {
            fileName = [_noteController getNote:currentNote];
        }

        NSString *path = [[_helper pathToNotes] stringByAppendingString:fileName];

        [_textView writeRTFDToFile:path atomically:NO];

        [_noteController setNoteName:noteName index:currentNote];
        [_noteController setNote:fileName index:currentNote];
        [_noteController setNoteDate:noteDate index:currentNote];
        [_noteController saveDictionary];

        [_window setDocumentEdited: NO];
    }
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

- (void)deleteCurrentNote {
    NSInteger currentNote = [_noteController getCurrentNote];
    [self deleteNoteByIndex:currentNote];
}

- (IBAction)deleteNoteAction:(id)sender {
    [self deleteCurrentNote];
}

- (void)deleteNoteByIndex:(NSInteger)index {
    [_noteController deleteNoteByIndex:index];
    [_noteController saveDictionary];
    
    NSInteger currentNote = [_noteController getCurrentNote];

    if (currentNote == index) {
        [self loadNote:index];
    }
}

- (IBAction)newNote:(id)sender {
    NSInteger numOfNotes = [_noteController getNumberOfNotes];
    
    [self loadBlankNote:numOfNotes];
}

- (IBAction)nextNote:(id)sender {
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

- (IBAction)prevNote:(id)sender {
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

- (IBAction)goToFirstNote:(id)sender {
    [self loadNote:0];
}

- (IBAction)goToLastNote:(id)sender {
    NSInteger numOfNotes = [_noteController getNumberOfNotes] - 1;
    [self loadNote:numOfNotes];
}

- (void)enableDisableBackButton:(NSInteger)noteIndex {
    if (noteIndex != 0) {
        [_backForwardButtons setEnabled:true forSegment:0];
        [_previousNoteMenuItem setEnabled:true];
        [_previousNoteMenuItem setAction:@selector(prevNote:)];
    }
    else {
        [_backForwardButtons setEnabled:false forSegment:0];
        [_previousNoteMenuItem setEnabled:false];
        [_previousNoteMenuItem setAction:nil];
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
