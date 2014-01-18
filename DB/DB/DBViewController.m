//
//  DBViewController.m
//  DB
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DBViewController.h"

@implementation DBViewController
@synthesize name, address, phone, status;
@synthesize databasePath;

- (void)saveData:(id)sender
{
    sqlite3_stmt *statment;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")", name.text, address.text, phone.text];

        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statment, NULL);
        if (sqlite3_step(statment) == SQLITE_DONE) {
            self.status.text = @"Contact Added";
            self.name.text = @"";
            self.address.text = @"";
            self.phone.text = @"";
        } else {
            self.status.text = @"Fail to add contact";
        }
        sqlite3_finalize(statment);
        sqlite3_close(contactDB);
    }
}

- (void)findContact:(id)sender
{
    sqlite3_stmt *statment;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT address, phone FROM contacts WHERE name = \"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statment, NULL) == SQLITE_OK) {
            if (sqlite3_step(statment) == SQLITE_ROW) {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statment, 0)];
                self.address.text = addressField;
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statment, 1)];
                self.phone.text = phoneField;
                self.status.text = @"Match Found";
            } else {
                self.status.text = @"Mathc not found";
                self.address.text = @"";
                self.phone.text = @"";
            }
            sqlite3_finalize(statment);
        }
        sqlite3_close(contactDB);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirDIR = [dirPath objectAtIndex:0];
    self.databasePath = [[NSString alloc] initWithString:[dirDIR stringByAppendingPathComponent:@"contacts.db"]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:self.databasePath]) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            if ((sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg)) != SQLITE_OK) {
                self.status.text = @"Failed to create table";
            }
            sqlite3_close(contactDB);
        } else {
            self.status.text = @"Fail to open/create database";
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.name = nil;
    self.address = nil;
    self.phone = nil;
    self.status = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
