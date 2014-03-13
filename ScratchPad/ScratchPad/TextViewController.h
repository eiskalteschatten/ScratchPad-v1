//
//  TextViewController.h
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TextViewController : NSViewController

@property (assign) IBOutlet NSTextView *textView;

- (IBAction)toggleToolbar:(id)sender;

@end
