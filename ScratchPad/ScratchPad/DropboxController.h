//
//  DropboxController.h
//  ScratchPad
//
//  Created by Alex Seifert on 16/05/2015.
//  Copyright (c) 2015 Alex Seifert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

@interface DropboxController : NSObject

@property (assign) IBOutlet Helper *helper;

@property (assign) IBOutlet NSButton *dropBoxCheck;
@property (assign) IBOutlet NSTextField *locationField;

@property (assign) NSUserDefaults *standardDefaults;

- (IBAction)chooseLocation:(id)sender;

@end
