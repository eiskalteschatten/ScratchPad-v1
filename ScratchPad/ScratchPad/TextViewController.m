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

- (void)loadNote:(NSInteger*)noteIndex {
    NSString *noteName = [_pageListViewController getNoteName:noteIndex];
    NSString *fileName = [noteName stringByAppendingString:@".rtfd"];
    NSString *path = [[_helper pathToNotes] stringByAppendingString:fileName];

    [_textView readRTFDFromFile:path];
    [_pageListViewController preparePageAfterLoad:noteIndex];
}

- (void)saveNote {

}

- (void)nextNote {
    
}

- (void)prevNote {
    
}

- (void)goToNote:(NSInteger*)noteIndex {
    
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

@end
