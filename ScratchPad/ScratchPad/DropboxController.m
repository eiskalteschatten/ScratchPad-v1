//
//  DropboxController.m
//  ScratchPad
//
//  Created by Alex Seifert on 16/05/2015.
//  Copyright (c) 2015 Alex Seifert. All rights reserved.
//

#import "DropboxController.h"

@implementation DropboxController

- (void)awakeFromNib {
    _standardDefaults = [NSUserDefaults standardUserDefaults];
    
    bool dropBoxSet = [_standardDefaults boolForKey:@"syncDropBox"];
    
    if (dropBoxSet) {
        [_dropBoxCheck setState:NSOnState];
    }
    else {
        [_dropBoxCheck setState:NSOffState];
    }
}

- (IBAction)chooseLocation:(id)sender {
    
}

@end
