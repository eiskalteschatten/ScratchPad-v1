//
//  PageListViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "PageListViewController.h"

@interface PageListViewController ()

@end

@implementation PageListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)openPopover:(id)sender {
    [_popover showRelativeToRect:[_popoverButton bounds] ofView:_popoverButton preferredEdge:NSMinYEdge];
}

@end
