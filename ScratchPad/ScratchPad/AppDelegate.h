//
//  AppDelegate.h
//  ScratchPad
//
//  Created by Alex Seifert on 1/31/14.
//  Copyright (c) 2014 Alex Seifert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helper.h"
#import "NoteController.h"
#import "MainViewController.h"
#import "TextViewController.h"
#import "PageListViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet Helper *helper;
@property (assign) IBOutlet NoteController *noteController;
@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet MainViewController *mainViewController;
@property (strong) IBOutlet TextViewController *textViewController;
@property (strong) IBOutlet PageListViewController *pageListViewController;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)loadNote:(NSInteger)noteIndex;
- (IBAction)createBackup:(id)sender;

- (IBAction)openWebsite:(id)sender;
- (IBAction)openFeedback:(id)sender;
- (IBAction)openGithub:(id)sender;
- (IBAction)openReleaseNotes:(id)sender;

@end
