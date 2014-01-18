//
//  FileHelper.m
//  TouchTracker
//
//  Created by Yan Xia on 3/4/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#include "FileHelper.h"

NSString *pathInDocumentDirectory(NSString *fileName)
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}