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

@end
