//
//  SearchNotes.h
//  Scratchpad
//
//  Created by Alex Seifert on 22/04/2012.
//  Copyright (c) 2012 AlexSeifert.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchNotes : NSObject {
    IBOutlet id searchBox;
    IBOutlet id searchWindow;
    IBOutlet id searchResults;
}

- (IBAction)performSearch:(id)sender;

@end
