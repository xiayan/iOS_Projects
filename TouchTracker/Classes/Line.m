//
//  Line.m
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "Line.h"


@implementation Line

@synthesize begin, end;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeCGPoint:begin forKey:@"begin"];
    [aCoder encodeCGPoint:end forKey:@"end"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    [super init];
    
    [self setBegin:[aDecoder decodeCGPointForKey:@"begin"]];
    [self setEnd:[aDecoder decodeCGPointForKey:@"end"]];
    
    return self;
}

@end
