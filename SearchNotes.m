//
//  SearchNotes.m
//  Scratchpad
//
//  Created by Alex Seifert on 22/04/2012.
//  Copyright (c) 2012 AlexSeifert.com. All rights reserved.
//

#import "SearchNotes.h"

@implementation SearchNotes

- (IBAction)performSearch:(id)sender {
    NSString *searchQuery = [sender stringValue];
    //NSLog(@"query: %@",searchQuery);
    
    if (searchQuery == @"") {
        //close search window
        NSLog(@"empty!");
        [searchWindow close];
    }
    else {
        //perform search
        
        [searchWindow makeKeyAndOrderFront:nil];
    }
}
@end
