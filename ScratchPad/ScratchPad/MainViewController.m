//
//  MainViewController.m
//  ScratchPad
//
//  Created by Alex Seifert on 12.03.14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setMainViewTo:(NSViewController *)controller {
    //Remove existing subviews
    while ([[_mainView subviews] count] > 0) {
        [_mainView.subviews[0] removeFromSuperview];
    }
    
    NSView * view = [controller view];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_mainView addSubview:view];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(view);
    [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    
    _currentViewController = controller;
}

- (void)showTextView {
    [self setMainViewTo:_textViewController];

    [_window makeFirstResponder:[_textViewController textView]];
}

- (void)newTextView {
    [self setMainViewTo:[_textViewController init]];
    
    [_window makeFirstResponder:[_textViewController textView]];
}

- (IBAction)prevNextNote:(id)sender {
    [self newTextView];
    
    NSInteger clicked = [sender selectedSegment];
    
    if (clicked == 0) {
        [_textViewController prevNote];
    }
    else {
        [_textViewController nextNote];
    }
}

@end
